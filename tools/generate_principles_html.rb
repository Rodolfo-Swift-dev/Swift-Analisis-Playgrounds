#!/usr/bin/env ruby

require "cgi"

ROOT = File.expand_path("..", __dir__)
REPOSITORY_URL = "https://github.com/Rodolfo-Swift-dev/Swift-Analisis-Playgrounds"

PAGES = [
  {
    slug: "clean-code",
    source: File.join(ROOT, "tools", "clean_code_ios.md"),
    output: File.join(ROOT, "docs", "clean-code.html"),
    eyebrow: "DISEÑO Y MANTENIBILIDAD",
    short_title: "Clean Code",
    playground: "Clean_Code/CleanCode.playground/Contents.swift",
    accent: "#0f8b8d",
    accent_dark: "#086d70",
    accent_soft: "#e4f7f5",
    sources: [
      ["Swift API Design Guidelines", "https://www.swift.org/documentation/api-design-guidelines/"],
      ["Writing documentation", "https://developer.apple.com/documentation/xcode/writing-documentation"],
      ["Swift Testing", "https://developer.apple.com/documentation/testing"],
      ["Automatic Reference Counting", "https://docs.swift.org/swift-book/documentation/the-swift-programming-language/automaticreferencecounting/"],
      ["Definition of Refactoring", "https://martinfowler.com/bliki/DefinitionOfRefactoring.html"]
    ]
  },
  {
    slug: "solid",
    source: File.join(ROOT, "tools", "solid_ios.md"),
    output: File.join(ROOT, "docs", "solid.html"),
    eyebrow: "PRINCIPIOS DE DISEÑO",
    short_title: "SOLID",
    playground: "SOLID/SOLID.playground/Contents.swift",
    accent: "#5661d8",
    accent_dark: "#3e48b8",
    accent_soft: "#eceeff",
    sources: [
      ["Protocol-Oriented Programming in Swift", "https://developer.apple.com/videos/play/wwdc2015/408/"],
      ["Modern Swift API Design", "https://developer.apple.com/videos/play/wwdc2019/415/"],
      ["Design protocol interfaces in Swift", "https://developer.apple.com/videos/play/wwdc2022/110353/"],
      ["Eliminate data races using Swift Concurrency", "https://developer.apple.com/videos/play/wwdc2022/110351/"]
    ]
  }
].freeze

def slugify(text)
  text
    .unicode_normalize(:nfkd)
    .gsub(/\p{Mn}/, "")
    .downcase
    .gsub(/[^a-z0-9]+/, "-")
    .gsub(/\A-|-?\z/, "")
end

def inline(text)
  text.split(/(`[^`]+`)/).map do |part|
    if part.start_with?("`") && part.end_with?("`")
      "<code>#{CGI.escapeHTML(part[1..-2])}</code>"
    else
      CGI.escapeHTML(part)
    end
  end.join
end

def parse_guide(path)
  guide = { title: nil, intro: [], sections: [] }
  current_section = nil
  current_card = nil
  in_code = false
  code_lines = []

  File.readlines(path, encoding: "UTF-8", chomp: true).each do |line|
    if in_code
      if line.start_with?("```")
        current_card[:code] = code_lines.join("\n")
        code_lines.clear
        in_code = false
      else
        code_lines << line
      end
      next
    end

    if line.start_with?("```")
      raise "#{path}: bloque de código fuera de una ficha" unless current_card

      in_code = true
      next
    end

    case line
    when /\A# (.+)\z/
      guide[:title] = Regexp.last_match(1)
    when /\A## (.+)\z/
      current_section = {
        title: Regexp.last_match(1),
        id: slugify(Regexp.last_match(1)),
        cards: []
      }
      guide[:sections] << current_section
      current_card = nil
    when /\A### (.+)\z/
      raise "#{path}: ficha sin sección" unless current_section

      current_card = {
        title: Regexp.last_match(1),
        id: slugify(Regexp.last_match(1)),
        details: {},
        code: nil
      }
      current_section[:cards] << current_card
    when /\A\*\*([^*]+):\*\*\s*(.+)\z/
      raise "#{path}: detalle fuera de una ficha" unless current_card

      current_card[:details][Regexp.last_match(1)] = Regexp.last_match(2)
    else
      stripped = line.strip
      guide[:intro] << stripped if !stripped.empty? && current_section.nil?
    end
  end

  raise "#{path}: bloque de código sin cerrar" if in_code
  raise "#{path}: falta título" unless guide[:title]
  raise "#{path}: no contiene secciones" if guide[:sections].empty?

  guide[:sections].each do |section|
    raise "#{path}: sección sin fichas: #{section[:title]}" if section[:cards].empty?

    section[:cards].each do |card|
      ["En simple", "Qué ocurre", "Cuidado"].each do |label|
        raise "#{path}: #{card[:title]} no contiene #{label}" unless card[:details][label]
      end
      raise "#{path}: #{card[:title]} no contiene ejemplo" unless card[:code]
    end
  end

  guide
end

def render_page(config, guide)
  section_navigation = guide[:sections].map.with_index(1) do |section, index|
    <<~HTML
      <a class="section-link" href="##{section[:id]}" data-target="#{section[:id]}">
        <span>#{index}</span>#{CGI.escapeHTML(section[:title])}
      </a>
    HTML
  end.join

  sections = guide[:sections].map do |section|
    cards = section[:cards].map do |card|
      details = card[:details].map do |label, description|
        <<~HTML
          <dt>#{CGI.escapeHTML(label)}</dt>
          <dd>#{inline(description)}</dd>
        HTML
      end.join

      <<~HTML
        <details class="study-card" id="#{card[:id]}">
          <summary>
            <span class="card-title">#{CGI.escapeHTML(card[:title])}</span>
            <span class="card-action">Ver detalle</span>
          </summary>
          <div class="card-body">
            <dl>#{details}</dl>
            <div class="example">
              <div class="example-label">Ejemplo</div>
              <pre><code>#{CGI.escapeHTML(card[:code])}</code><button class="copy-code" type="button" aria-label="Copiar código" aria-live="polite">Copiar</button></pre>
            </div>
          </div>
        </details>
      HTML
    end.join

    <<~HTML
      <section class="guide-section" id="#{section[:id]}">
        <div class="section-heading">
          <h2>#{CGI.escapeHTML(section[:title])}</h2>
          <span>#{section[:cards].length} #{section[:cards].length == 1 ? "subtema" : "subtemas"}</span>
        </div>
        #{cards}
      </section>
    HTML
  end.join

  sources = config[:sources].map do |label, url|
    %(<a href="#{url}" target="_blank" rel="noreferrer">#{CGI.escapeHTML(label)}</a>)
  end.join

  guide_links = [
    {
      slug: "swift",
      title: "Swift",
      detail: "20 capítulos",
      href: "index.html"
    },
    *PAGES.map do |page|
      {
        slug: page[:slug],
        title: page[:short_title],
        detail: page[:slug] == "clean-code" ? "15 temas prácticos" : "10 temas de diseño",
        href: "#{page[:slug]}.html"
      }
    end
  ].map do |page|
    current = page[:slug] == config[:slug]
    content = <<~HTML.chomp
      <span><strong>#{CGI.escapeHTML(page[:title])}</strong><small>#{current ? "Actual · " : ""}#{CGI.escapeHTML(page[:detail])}</small></span>
      <span class="guide-link-action" aria-hidden="true">#{current ? "✓" : "→"}</span>
    HTML

    if current
      %(<span class="guide-link active" aria-current="page">#{content}</span>)
    else
      %(<a class="guide-link" href="#{page[:href]}">#{content}</a>)
    end
  end.join

  card_count = guide[:sections].sum { |section| section[:cards].length }
  intro = guide[:intro].map { |paragraph| "<p>#{inline(paragraph)}</p>" }.join
  source_url = "#{REPOSITORY_URL}/blob/main/#{config[:playground]}"

  <<~HTML
    <!doctype html>
    <html lang="es">
    <head>
      <meta charset="utf-8">
      <meta name="viewport" content="width=device-width, initial-scale=1">
      <meta name="description" content="#{CGI.escapeHTML(guide[:intro].join(" "))}">
      <meta name="theme-color" content="#{config[:accent]}" media="(prefers-color-scheme: light)">
      <meta name="theme-color" content="#{config[:accent_dark]}" media="(prefers-color-scheme: dark)">
      <title>#{CGI.escapeHTML(guide[:title])} · Swift Study</title>
      <style>
        :root {
          color-scheme: light;
          --background: #f3f6f8;
          --surface: #ffffff;
          --surface-soft: #f8fafb;
          --text: #17212b;
          --muted: #667580;
          --line: #dce4e8;
          --code: #101a22;
          --code-text: #edf5f7;
          --sidebar: #101a22;
          --sidebar-text: #dbe6eb;
          --accent: #{config[:accent]};
          --accent-dark: #{config[:accent_dark]};
          --accent-soft: #{config[:accent_soft]};
          --shadow: 0 14px 38px rgba(22, 32, 40, 0.08);
        }

        @media (prefers-color-scheme: dark) {
          :root {
            color-scheme: dark;
            --background: #0c1318;
            --surface: #14212a;
            --surface-soft: #101b22;
            --text: #edf4f6;
            --muted: #9caeb8;
            --line: #2a3a44;
            --code: #080d11;
            --code-text: #e8f1f4;
            --sidebar: #081015;
            --accent-soft: #1b3136;
            --shadow: 0 16px 42px rgba(0, 0, 0, 0.28);
          }
        }

        * { box-sizing: border-box; }
        html { scroll-behavior: smooth; scroll-padding-top: 22px; }
        body {
          margin: 0;
          background: var(--background);
          color: var(--text);
          font: 16px/1.65 -apple-system, BlinkMacSystemFont, "SF Pro Text", "Segoe UI", sans-serif;
        }
        button, input { font: inherit; }
        a { color: var(--accent-dark); text-underline-offset: 3px; }
        a:focus-visible,
        button:focus-visible,
        input:focus-visible,
        summary:focus-visible {
          outline: 3px solid var(--accent);
          outline-offset: 3px;
        }
        code {
          padding: .12rem .36rem;
          border: 1px solid var(--line);
          border-radius: 6px;
          background: var(--surface-soft);
          color: var(--accent-dark);
          font: .91em/1.4 "SFMono-Regular", Consolas, monospace;
        }
        .progress {
          position: fixed;
          z-index: 50;
          top: 0;
          left: 0;
          width: 0;
          height: 3px;
          background: var(--accent);
        }
        .sidebar {
          position: fixed;
          inset: 0 auto 0 0;
          z-index: 30;
          width: 300px;
          overflow-y: auto;
          padding: 28px 22px;
          background: var(--sidebar);
          color: var(--sidebar-text);
        }
        .brand {
          display: flex;
          align-items: center;
          gap: 12px;
          color: #fff;
          text-decoration: none;
        }
        .brand-mark {
          display: grid;
          width: 42px;
          height: 42px;
          place-items: center;
          border-radius: 12px;
          background: var(--accent);
          color: #fff;
          font-weight: 850;
        }
        .brand strong, .brand small { display: block; }
        .brand small { color: #91a4ae; }
        .guide-switcher {
          display: grid;
          gap: 4px;
          margin: 24px 0 18px;
        }
        .guide-switcher-label {
          margin: 0 8px 4px;
          color: #91a4ae;
          font-size: .7rem;
          font-weight: 700;
          letter-spacing: .1em;
          text-transform: uppercase;
        }
        .guide-link {
          display: grid;
          grid-template-columns: 1fr auto;
          align-items: center;
          min-height: 44px;
          padding: 9px 10px;
          border: 1px solid transparent;
          border-radius: 9px;
          color: #9db0ba;
          text-decoration: none;
        }
        .guide-link strong, .guide-link small { display: block; }
        .guide-link strong {
          color: #dbe6eb;
          font-size: .82rem;
        }
        .guide-link small {
          margin-top: 1px;
          font-size: .7rem;
        }
        a.guide-link:hover {
          border-color: #415661;
          background: rgba(255,255,255,.06);
        }
        .guide-link.active {
          border-color: var(--accent);
          background: rgba(255,255,255,.08);
          color: #fff;
        }
        .guide-link-action {
          color: #91a4ae;
          font-size: .78rem;
          font-weight: 700;
        }
        .guide-link.active .guide-link-action { color: var(--accent); }
        .search-wrap { position: relative; }
        .search {
          width: 100%;
          min-height: 44px;
          padding: 11px 38px 11px 12px;
          border: 1px solid #31434e;
          border-radius: 10px;
          outline: none;
          background: #0b151b;
          color: #fff;
        }
        .search:focus {
          border-color: var(--accent);
          box-shadow: 0 0 0 3px var(--accent-soft);
        }
        .clear-search {
          position: absolute;
          top: 50%;
          right: 2px;
          width: 40px;
          height: 40px;
          transform: translateY(-50%);
          border: 0;
          background: transparent;
          color: #91a4ae;
          cursor: pointer;
        }
        .clear-search[hidden] { display: none; }
        .search-status {
          min-height: 21px;
          margin: 7px 2px 16px;
          color: #91a4ae;
          font-size: .78rem;
        }
        .nav-label {
          margin: 18px 8px 8px;
          color: #8297a2;
          font-size: .7rem;
          font-weight: 800;
          letter-spacing: .12em;
          text-transform: uppercase;
        }
        .section-link {
          display: flex;
          align-items: center;
          gap: 9px;
          min-height: 44px;
          margin: 2px 0;
          padding: 8px 9px;
          border-radius: 9px;
          color: #d5e1e6;
          font-size: .87rem;
          text-decoration: none;
        }
        .section-link span {
          display: grid;
          flex: 0 0 25px;
          height: 25px;
          place-items: center;
          border-radius: 7px;
          background: #24343e;
          color: #a8bac3;
          font-size: .72rem;
        }
        .section-link:hover, .section-link.active { background: #1d2a32; color: #fff; }
        .section-link.active span { background: var(--accent); color: #fff; }
        .sidebar-actions {
          display: grid;
          grid-template-columns: repeat(3, 1fr);
          gap: 7px;
          margin-top: 22px;
        }
        .sidebar-actions button {
          min-height: 44px;
          padding: 8px;
          border: 1px solid #31434e;
          border-radius: 8px;
          background: transparent;
          color: #d5e1e6;
          cursor: pointer;
        }
        .main {
          width: min(calc(100% - 300px), 1220px);
          margin-left: 300px;
          padding: 48px clamp(24px, 5vw, 76px) 90px;
        }
        .hero, .guide-section, .sources {
          width: min(100%, 920px);
          margin-inline: auto;
        }
        .hero {
          position: relative;
          overflow: hidden;
          margin-bottom: 26px;
          padding: clamp(36px, 6vw, 66px);
          border-radius: 26px;
          background:
            radial-gradient(circle at 90% 10%, rgba(255,255,255,.2), transparent 28%),
            linear-gradient(135deg, var(--accent), var(--accent-dark));
          color: #fff;
          box-shadow: var(--shadow);
        }
        .eyebrow {
          margin: 0 0 10px;
          font-size: .7rem;
          font-weight: 850;
          letter-spacing: .16em;
        }
        .hero h1 {
          max-width: 720px;
          margin: 0;
          font-size: clamp(2.15rem, 5vw, 4.2rem);
          line-height: 1;
          letter-spacing: -.045em;
        }
        .hero p { max-width: 650px; color: rgba(255,255,255,.82); }
        .hero-note {
          margin-bottom: 0;
          color: rgba(255,255,255,.68) !important;
          font-size: .82rem;
        }
        .hero-actions {
          display: flex;
          flex-wrap: wrap;
          gap: 9px;
          margin-top: 22px;
        }
        .hero-actions a {
          display: inline-flex;
          align-items: center;
          min-height: 44px;
          padding: 9px 13px;
          border: 1px solid rgba(255,255,255,.42);
          border-radius: 9px;
          color: #fff;
          font-size: .85rem;
          text-decoration: none;
        }
        .guide-section {
          margin-bottom: 24px;
          padding: 24px;
          border: 1px solid var(--line);
          border-radius: 18px;
          background: var(--surface);
          box-shadow: var(--shadow);
        }
        .section-heading {
          display: flex;
          align-items: baseline;
          justify-content: space-between;
          gap: 12px;
          margin-bottom: 15px;
        }
        .section-heading h2 { margin: 0; font-size: clamp(1.35rem, 2vw, 1.8rem); }
        .section-heading > span { color: var(--muted); font-size: .78rem; }
        .study-card {
          margin: 11px 0;
          border: 1px solid var(--line);
          border-left: 4px solid var(--accent);
          border-radius: 12px;
          background: var(--surface-soft);
          overflow: hidden;
        }
        .study-card summary {
          display: flex;
          align-items: center;
          justify-content: space-between;
          gap: 18px;
          padding: 17px 18px;
          cursor: pointer;
          list-style: none;
        }
        .study-card summary::-webkit-details-marker { display: none; }
        .study-card[open] summary {
          border-bottom: 1px solid var(--line);
          background: var(--accent-soft);
        }
        .card-title { font-weight: 760; }
        .card-action { color: var(--muted); font-size: .74rem; white-space: nowrap; }
        .study-card[open] .card-action { font-size: 0; }
        .study-card[open] .card-action::after { content: "Ocultar"; font-size: .74rem; }
        .card-body { padding: 18px; }
        dl {
          display: grid;
          grid-template-columns: 125px 1fr;
          gap: 8px 13px;
          margin: 0;
        }
        dt {
          color: var(--accent-dark);
          font-size: .78rem;
          font-weight: 800;
          text-transform: uppercase;
        }
        dd { margin: 0; }
        .example {
          margin-top: 18px;
          padding-top: 15px;
          border-top: 1px solid var(--line);
        }
        .example-label {
          margin-bottom: 7px;
          color: var(--muted);
          font-size: .72rem;
          font-weight: 800;
          letter-spacing: .1em;
          text-transform: uppercase;
        }
        pre {
          position: relative;
          overflow-x: auto;
          margin: 0;
          padding: 22px;
          border-radius: 12px;
          background: var(--code);
          color: var(--code-text);
        }
        pre code {
          padding: 0;
          border: 0;
          background: transparent;
          color: inherit;
          font-size: .86rem;
        }
        .copy-code {
          position: absolute;
          top: 9px;
          right: 9px;
          min-width: 44px;
          min-height: 44px;
          padding: 5px 8px;
          border: 1px solid #41515b;
          border-radius: 7px;
          background: #22313a;
          color: #e4edf0;
          cursor: pointer;
        }
        .sources {
          padding: 22px 4px;
          color: var(--muted);
          font-size: .83rem;
        }
        .sources strong { color: var(--text); }
        .sources a { margin-right: 12px; }
        .empty {
          display: none;
          width: min(100%, 920px);
          margin: 20px auto;
          padding: 38px;
          border: 1px dashed var(--line);
          border-radius: 16px;
          color: var(--muted);
          text-align: center;
        }
        .mobile-bar { display: none; }
        @media (max-width: 900px) {
          .mobile-bar {
            position: sticky;
            top: 0;
            z-index: 20;
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 11px 15px;
            border-bottom: 1px solid var(--line);
            background: var(--surface);
          }
          .mobile-bar button {
            min-height: 44px;
            padding: 7px 10px;
            border: 1px solid var(--line);
            border-radius: 8px;
            background: var(--surface);
            color: var(--text);
          }
          .sidebar {
            width: min(85vw, 320px);
            transform: translateX(-105%);
            transition: transform 180ms ease;
            box-shadow: 22px 0 50px rgba(0,0,0,.3);
          }
          .sidebar.open { transform: translateX(0); }
          .main { width: 100%; margin-left: 0; padding: 22px 15px 65px; }
          .hero { border-radius: 20px; }
        }
        @media (max-width: 560px) {
          .guide-section { padding: 17px; }
          .section-heading { align-items: flex-start; flex-direction: column; }
          dl { grid-template-columns: 1fr; }
          dt { margin-top: 7px; }
          pre { padding: 20px 16px; }
        }
        @media (prefers-reduced-motion: reduce) {
          html { scroll-behavior: auto; }
          .sidebar { transition: none; }
        }
        @media print {
          .sidebar, .mobile-bar, .progress, .copy-code { display: none !important; }
          .main { width: 100%; margin: 0; padding: 0; }
          .hero { border: 1px solid #aaa; background: #fff; color: #000; box-shadow: none; }
          .hero p { color: #333; }
          .guide-section { break-inside: avoid-page; box-shadow: none; }
          .study-card:not([open]) .card-body { display: block; }
        }
      </style>
    </head>
    <body>
      <div class="progress" id="progress"></div>
      <div class="mobile-bar">
        <strong>#{CGI.escapeHTML(config[:short_title])} · iOS</strong>
        <button id="menuButton" type="button" aria-controls="sidebar" aria-expanded="false">Contenido</button>
      </div>
      <aside class="sidebar" id="sidebar">
        <a class="brand" href="index.html">
          <span class="brand-mark">S</span>
          <span><strong>Swift Study</strong><small>Guías de diseño iOS</small></span>
        </a>
        <nav class="guide-switcher" aria-label="Guías de estudio">
          <div class="guide-switcher-label">Guías de estudio</div>
          #{guide_links}
        </nav>
        <div class="search-wrap">
          <input class="search" id="search" type="search" placeholder="Buscar concepto…" aria-label="Buscar concepto" autocomplete="off">
          <button class="clear-search" id="clearSearch" type="button" aria-label="Limpiar búsqueda" hidden>×</button>
        </div>
        <div class="search-status" id="searchStatus" aria-live="polite">#{card_count} subtemas disponibles</div>
        <div class="nav-label">Contenido</div>
        <nav>#{section_navigation}</nav>
        <div class="sidebar-actions">
          <button id="expandAll" type="button">Expandir</button>
          <button id="collapseAll" type="button">Plegar</button>
          <button id="printButton" type="button">Imprimir</button>
        </div>
      </aside>
      <main class="main">
        <header class="hero">
          <div class="eyebrow">#{CGI.escapeHTML(config[:eyebrow])}</div>
          <h1>#{CGI.escapeHTML(guide[:title])}</h1>
          #{intro}
          <p class="hero-note">Los ejemplos web son fragmentos enfocados en un concepto. El playground enlazado contiene la implementación completa, ejecutable y verificada.</p>
          <div class="hero-actions">
            <a href="#{source_url}" target="_blank" rel="noreferrer">Abrir playground</a>
          </div>
        </header>
        #{sections}
        <div class="empty" id="emptyState">No se encontraron subtemas con esa búsqueda.</div>
        <footer class="sources">
          <strong>Fuentes principales:</strong>
          #{sources}
        </footer>
      </main>
      <script>
        const cards = [...document.querySelectorAll(".study-card")];
        const sections = [...document.querySelectorAll(".guide-section")];
        const sectionLinks = [...document.querySelectorAll(".section-link")];
        const search = document.querySelector("#search");
        const searchStatus = document.querySelector("#searchStatus");
        const sidebar = document.querySelector("#sidebar");
        const emptyState = document.querySelector("#emptyState");
        const clearSearch = document.querySelector("#clearSearch");
        const menuButton = document.querySelector("#menuButton");

        const setSidebarOpen = (open) => {
          sidebar.classList.toggle("open", open);
          menuButton.setAttribute("aria-expanded", String(open));
          menuButton.textContent = open ? "Cerrar" : "Contenido";
        };

        const normalizeText = (value) => {
          const lowered = String(value || "").toLowerCase();
          return typeof lowered.normalize === "function"
            ? lowered.normalize("NFD").replace(/[\\u0300-\\u036f]/g, "")
            : lowered;
        };

        const runSearch = () => {
          const query = normalizeText(search.value.trim());
          let matches = 0;

          cards.forEach((card) => {
            const sectionTitle = card.closest(".guide-section").querySelector("h2").textContent;
            const sectionMatches = Boolean(query && normalizeText(sectionTitle).includes(query));
            const visible = !query || sectionMatches || normalizeText(card.textContent).includes(query);
            card.hidden = !visible;
            if (visible) matches += 1;
            if (query && visible) card.open = true;
          });

          sections.forEach((section) => {
            section.hidden = ![...section.querySelectorAll(".study-card")].some((card) => !card.hidden);
          });

          sectionLinks.forEach((link) => {
            const target = document.getElementById(link.dataset.target);
            link.hidden = Boolean(target && target.hidden);
          });

          searchStatus.textContent = query
            ? `${matches} ${matches === 1 ? "subtema encontrado" : "subtemas encontrados"}`
            : `${cards.length} subtemas disponibles`;
          clearSearch.hidden = !search.value;
          emptyState.style.display = matches ? "none" : "block";
        };

        search.addEventListener("input", runSearch);
        search.addEventListener("search", runSearch);
        search.addEventListener("keydown", (event) => {
          if (event.key !== "Escape") return;
          search.value = "";
          runSearch();
        });

        clearSearch.addEventListener("click", () => {
          search.value = "";
          runSearch();
          search.focus();
        });

        document.querySelector("#expandAll").addEventListener("click", () => {
          cards.forEach((card) => { card.open = true; });
        });
        document.querySelector("#collapseAll").addEventListener("click", () => {
          cards.forEach((card) => { card.open = false; });
        });

        document.querySelectorAll(".copy-code").forEach((button) => {
          button.addEventListener("click", async () => {
            const value = button.parentElement.querySelector("code").textContent;
            try {
              await navigator.clipboard.writeText(value);
              button.textContent = "Copiado";
            } catch {
              button.textContent = "No disponible";
            }
            setTimeout(() => { button.textContent = "Copiar"; }, 1100);
          });
        });

        document.querySelector("#printButton").addEventListener("click", () => window.print());
        menuButton.addEventListener("click", () => setSidebarOpen(!sidebar.classList.contains("open")));
        sectionLinks.forEach((link) => link.addEventListener("click", () => setSidebarOpen(false)));
        document.addEventListener("keydown", (event) => {
          if (event.key === "Escape" && sidebar.classList.contains("open")) {
            setSidebarOpen(false);
            menuButton.focus();
          }
        });

        if ("IntersectionObserver" in window) {
          const observer = new IntersectionObserver((entries) => {
            entries.forEach((entry) => {
              if (!entry.isIntersecting) return;
              sectionLinks.forEach((link) => {
                const current = link.dataset.target === entry.target.id;
                link.classList.toggle("active", current);
                if (current) {
                  link.setAttribute("aria-current", "location");
                } else {
                  link.removeAttribute("aria-current");
                }
              });
            });
          }, { rootMargin: "-15% 0px -75% 0px" });
          sections.forEach((section) => observer.observe(section));
        }

        window.addEventListener("scroll", () => {
          const scrollable = document.documentElement.scrollHeight - innerHeight;
          const value = scrollable > 0 ? (scrollY / scrollable) * 100 : 0;
          document.querySelector("#progress").style.width = `${Math.min(value, 100)}%`;
        }, { passive: true });
      </script>
    </body>
    </html>
  HTML
end

PAGES.each do |config|
  guide = parse_guide(config[:source])
  File.write(config[:output], render_page(config, guide), mode: "w", encoding: "UTF-8")
  puts "Generated #{config[:output]}"
end
