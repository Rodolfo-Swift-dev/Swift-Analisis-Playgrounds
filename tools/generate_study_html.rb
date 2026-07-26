#!/usr/bin/env ruby

require "cgi"

ROOT = File.expand_path("..", __dir__)
SOURCE = File.join(ROOT, "tools", "study_guide_full.md")
OUTPUT = File.join(ROOT, "docs", "index.html")
REPOSITORY_URL = "https://github.com/Rodolfo-Swift-dev/Swift-Analisis-Playgrounds"

EXAMPLES_BY_CHAPTER = {
  0 => [
    %q{print("Hola, Swift")},
    %q{// Este comentario no se ejecuta},
    "/* Comentario\n   de varias líneas */",
    %q{let pi = 3.14159},
    "var score = 0\nscore += 1",
    %q{let age: Int = 36},
    %q{let language = "Swift" // String inferido},
    %q{let count: Int = 3},
    %q{let opacity: Float = 0.5},
    %q{let price: Double = 19.99},
    %q{let greeting: String = "Hola"},
    %q{let isReady: Bool = true},
    %q{let result = (8 + 2) * 3 / 5},
    %q{let remainder = 9 % 4 // 1},
    %q{let canEnter = age >= 18},
    "var total = 10\ntotal += 5",
    %q{let valid = hasName && hasEmail},
    %q{let allowed = isAdmin || isOwner},
    %q{let isHidden = !isVisible},
    %q{let message = "Edad: \(age)"},
    %q{let fullName = firstName + " " + lastName}
  ],
  1 => [
    "typealias Celsius = Double\nlet temperature: Celsius = 21.5",
    "typealias CharacterName = String\nlet hero: CharacterName = \"Ayla\"",
    "struct User { let name: String }\ntypealias Client = User\nlet client = Client(name: \"Ana\")",
    "typealias Completion = (Result<String, Error>) -> Void\nfunc load(completion: Completion) { }"
  ],
  2 => [
    %q{let person: (String, Int, Bool) = ("Ana", 28, true)},
    "let person = (\"Ana\", 28)\nprint(person.0) // Ana",
    %q{let person = (name: "Ana", age: 28)},
    "let person = (name: \"Ana\", age: 28)\nprint(person.name)",
    "let point = (3, 7)\nlet (x, y) = point",
    "let user = (\"Ana\", 28)\nlet (name, _) = user",
    %q{let result = (user: (name: "Ana", age: 28), active: true)},
    "func bounds() -> (min: Int, max: Int) {\n    (0, 100)\n}",
    "let operation: (result: Int?, error: String?) =\n    (nil, \"División por cero\")"
  ],
  3 => [
    "var nickname: String? = \"Rodo\"\nnickname = nil",
    %q{var selectedUser: User? = nil},
    "if let name = nickname {\n    print(name)\n}",
    "guard let name = nickname else { return }\nprint(name)",
    %q{let count = nickname!.count // Falla si nickname es nil},
    %q{let displayName = nickname ?? "Sin nombre"},
    %q{let firstLetter = nickname?.first},
    "if nickname != nil {\n    print(\"Existe, pero aún es String?\")\n}",
    %q{let length = nickname.map { $0.count }},
    %q{let capitals = ["CL": "Santiago"]; let city = capitals["CL"]}
  ],
  4 => [
    %q{var names: [String] = ["Ana", "Luis"]},
    %q{let firstName = names[0]},
    %q{let numberOfNames = names.count},
    %q{if names.isEmpty { print("Sin nombres") }},
    %q{let edges = (names.first, names.last)},
    %q{names.append("Eva")},
    %q{names.insert("Rosa", at: 1)},
    %q{let hasAna = names.contains("Ana")},
    %q{names.removeAll()},
    %q{let zeros = Array(repeating: 0, count: 4)},
    %q{var tags: Set<String> = ["swift", "ios", "swift"]},
    %q{let insertion = tags.insert("xcode")},
    %q{let usesSwift = tags.contains("swift")},
    %q{let anyTag: String? = tags.first},
    %q{let all = Set([1, 2]).union(Set([2, 3]))},
    %q{let common = Set([1, 2]).intersection(Set([2, 3]))},
    %q{let onlyA = Set([1, 2]).subtracting(Set([2, 3]))},
    %q{let different = Set([1, 2]).symmetricDifference(Set([2, 3]))},
    %q{let included = Set([1, 2]).isSubset(of: Set([1, 2, 3]))},
    %q{var ages: [String: Int] = ["Ana": 28]},
    %q{let age: Int? = ages["Ana"]},
    %q{ages["Luis"] = 31},
    %q{ages["Ana"] = nil // Elimina la entrada},
    %q{let previous = ages.updateValue(32, forKey: "Luis")},
    %q{let removed = ages.removeValue(forKey: "Luis")},
    %q{for (name, age) in ages { print(name, age) }}
  ],
  5 => [
    "if temperature > 30 {\n    print(\"Hace calor\")\n}",
    "if score >= 90 {\n    print(\"Excelente\")\n} else if score >= 60 {\n    print(\"Aprobado\")\n}",
    "if isConnected {\n    loadData()\n} else {\n    showOfflineMessage()\n}",
    "guard isAuthenticated else { return }\nshowProfile()",
    "guard let user = currentUser else { return }\nprint(user.name)",
    "switch status {\ncase .success: print(\"OK\")\ncase .failure: print(\"Error\")\n}",
    "switch number {\ncase 0: print(\"Cero\")\ndefault: print(\"Otro\")\n}",
    "switch number {\ncase 0: print(\"Cero\")\ndefault: break\n}",
    "switch age {\ncase let value where value >= 18: print(\"Adulto\")\ndefault: print(\"Menor\")\n}",
    "for number in numbers {\n    if number < 0 { break }\n}",
    "for name in names {\n    print(name)\n}",
    "for number in numbers where number.isMultiple(of: 2) {\n    print(number)\n}",
    %q{for _ in 1...3 { print("Hola") }},
    "while attempts < 3 {\n    attempts += 1\n}",
    "repeat {\n    attempts += 1\n} while attempts < 3"
  ],
  6 => [
    "func greet(name: String) {\n    print(\"Hola, \\(name)\")\n}",
    "func double(_ value: Int) -> Int {\n    value * 2\n}",
    "func absolute(_ value: Int) -> Int {\n    if value >= 0 { return value }\n    return -value\n}",
    %q{let operation: (Int, Int) -> Int = { $0 + $1 }},
    "func add(_ a: Int, _ b: Int) -> Int { a + b }\nlet operation = add",
    "func coordinates() -> (x: Int, y: Int) {\n    (10, 20)\n}",
    "func greet(to person: String) {\n    print(person)\n}",
    "func square(_ value: Int) -> Int {\n    value * value\n}",
    %q{func connect(host: String, port: Int = 443) { }},
    "func convert(_ value: Int) -> String { String(value) }\nfunc convert(_ value: Double) -> String { String(value) }",
    "func average(_ values: Double...) -> Double {\n    values.reduce(0, +) / Double(values.count)\n}",
    "func increment(_ value: inout Int) {\n    value += 1\n}",
    "var count = 0\nincrement(&count)",
    "func validate(_ value: Int) {\n    func isPositive() -> Bool { value > 0 }\n    print(isPositive())\n}"
  ],
  7 => [
    "struct Point {\n    var x: Int\n    var y: Int\n}",
    "final class Session {\n    var token = \"\"\n}",
    %q{struct User { var name: String }},
    %q{struct Counter { mutating func increment() { value += 1 }; var value = 0 }},
    "class User {\n    let name: String\n    init(name: String) { self.name = name }\n}",
    "struct Point { var x: Int; var y: Int }\nlet point = Point(x: 2, y: 4)",
    "class User {\n    init(name: String) { }\n    convenience init() { self.init(name: \"Invitado\") }\n}",
    "class Connection {\n    deinit { print(\"Conexión liberada\") }\n}",
    "struct Matrix {\n    subscript(row: Int, column: Int) -> Int { 0 }\n}",
    %q{class Dog: Animal { }},
    %q{struct User: Identifiable { let id: Int }},
    %q{extension User { var displayName: String { name.uppercased() } }}
  ],
  8 => [
    "struct Counter {\n    var value = 0\n    func show() { print(value) }\n}",
    "struct User {\n    let name: String\n    func printName() { print(self.name) }\n}",
    "struct Counter {\n    var value = 0\n    mutating func increment() { value += 1 }\n}",
    "class Counter {\n    var value = 0\n    func increment() { value += 1 }\n}",
    "struct Account {\n    private func validate() -> Bool { true }\n}",
    "struct Math {\n    static func square(_ value: Int) -> Int { value * value }\n}\nlet result = Math.square(4)",
    "class Animal {\n    class func sound() -> String { \"...\" }\n}\nclass Dog: Animal {\n    override class func sound() -> String { \"Guau\" }\n}"
  ],
  9 => [
    %q{struct User { var name: String }},
    %q{struct AppSettings { static var language = "es" }},
    "class Animal {\n    class var category: String { \"Animal\" }\n}",
    "struct Rectangle {\n    var width: Double\n    var height: Double\n    var area: Double { width * height }\n}",
    "struct Rectangle {\n    var width: Double\n    var height: Double\n    var area: Double { get { width * height } }\n}",
    "struct Rectangle {\n    var width: Double\n    var height: Double\n    var area: Double {\n        get { width * height }\n        set { width = newValue / height }\n    }\n}",
    "var area: Double {\n    get { width * height }\n    set { width = newValue / height }\n}",
    "var score = 0 {\n    willSet { print(\"Nuevo: \\(newValue)\") }\n}",
    "var score = 0 {\n    didSet { print(\"Actual: \\(score)\") }\n}",
    %q{didSet { print("Antes: \(oldValue)") }},
    "@propertyWrapper\nstruct Clamped {\n    var wrappedValue: Int\n}",
    "var wrappedValue: Int {\n    get { storage }\n    set { storage = min(newValue, 100) }\n}",
    %q{@Clamped var progress = 0}
  ],
  10 => [
    %q{let double = { (value: Int) -> Int in value * 2 }},
    %q{let double = { (value: Int) -> Int in value * 2 }},
    %q{let completion: () -> Void = { print("Listo") }},
    %q{let descending = names.sorted { first, second in first > second }},
    %q{let doubled = numbers.map { $0 * 2 }},
    %q{let sorted = names.sorted { $0 > $1 }},
    %q{let sorted = names.sorted(by: >)},
    %q{let doubled = numbers.map { $0 * 2 }},
    %q{loadData { result in print(result) }},
    "request {\n    print(\"Éxito\")\n} onFailure: {\n    print(\"Error\")\n}",
    "func makeCounter() -> () -> Int {\n    var value = 0\n    return { value += 1; return value }\n}",
    "var total = 0\nlet add = { total += 1 }",
    "let counter = makeCounter()\nlet sameCounter = counter\nprint(counter(), sameCounter())",
    "func load(completion: @escaping () -> Void) {\n    DispatchQueue.main.async { completion() }\n}",
    "func assertPositive(_ value: @autoclosure () -> Bool) {\n    if !value() { print(\"Inválido\") }\n}\nassertPositive(score > 0)"
  ],
  11 => [
    "enum Direction {\n    case north, south, east, west\n}",
    %q{enum State { case loading; case loaded }},
    %q{let direction: Direction = .north},
    "switch direction {\ncase .north: print(\"Norte\")\ncase .south: print(\"Sur\")\ncase .east: print(\"Este\")\ncase .west: print(\"Oeste\")\n}",
    "switch direction {\ncase .north: break\ncase .south, .east, .west: print(\"Otra\")\n}",
    "switch direction {\ncase .north: print(\"Norte\")\ndefault: print(\"Otra\")\n}",
    "enum Status {\n    case success, failure\n    var message: String { self == .success ? \"OK\" : \"Error\" }\n}",
    "enum Status {\n    case success\n    func printValue() { print(self) }\n}",
    %q{enum Status { static func defaultValue() -> Status { .success }; case success }},
    "enum Weekday: CaseIterable { case monday, tuesday }\nfor day in Weekday.allCases { print(day) }",
    %q{enum Field { case text(value: String) }},
    "switch field {\ncase .text(let value): print(value)\n}",
    %q{enum Endpoint: String { case users = "/users" }},
    %q{let path = Endpoint.users.rawValue},
    "enum Planet: Int {\n    case mercury = 1, venus, earth\n}\nprint(Planet.earth.rawValue) // 3"
  ],
  12 => [
    %q{class Dog: Animal { }},
    %q{class Animal { func sound() { } }},
    %q{class Dog: Animal { func fetch() { } }},
    "class Dog: Animal {\n    init(name: String) {\n        super.init(name: name)\n    }\n}",
    "override func sound() {\n    super.sound()\n    print(\"Guau\")\n}",
    "class Dog: Animal {\n    override func sound() { print(\"Guau\") }\n}",
    "class Dog: Animal {\n    override var description: String { \"Perro\" }\n}",
    "class Animal { class func category() -> String { \"Animal\" } }\nclass Dog: Animal { override class func category() -> String { \"Perro\" } }",
    %q{final class TokenStore { }},
    "class Validator {\n    final func validate() -> Bool { true }\n}",
    "class Model {\n    final var identifier: String { \"fixed\" }\n}"
  ],
  13 => [
    "protocol Named {\n    var name: String { get }\n}",
    "struct User: Named {\n    let name: String\n}",
    %q{struct User: Named, Identifiable { let id: Int; let name: String }},
    %q{class Dog: Animal, Named { let name = "Fido" }},
    %q{protocol Named { var name: String { get } }},
    %q{protocol Editable { var text: String { get set } }},
    %q{protocol Resettable { static func resetAll() }},
    %q{protocol Runnable { func run() }},
    %q{protocol Initializable { init(value: Int) }},
    %q{@objc protocol DataSource { }},
    "@objc protocol DataSource {\n    @objc optional func reload()\n}",
    "extension Named {\n    func displayName() -> String { name.uppercased() }\n}",
    "extension User: Named {\n    var name: String { username }\n}"
  ],
  14 => [
    %q{func identity<T>(_ value: T) -> T { value }},
    %q{func printValue<T>(_ value: T) { print(value) }},
    %q{func pair<T, U>(_ first: T, _ second: U) -> (T, U) { (first, second) }},
    "func swap<T>(_ a: inout T, _ b: inout T) {\n    (a, b) = (b, a)\n}",
    "struct Stack<Element> {\n    private var items: [Element] = []\n}",
    %q{mutating func push(_ item: Element) { items.append(item) }},
    %q{mutating func pop() -> Element? { items.popLast() }},
    %q{func maximum<T: Comparable>(_ a: T, _ b: T) -> T { a > b ? a : b }},
    %q{func describe<T>(_ value: T) where T: CustomStringConvertible { print(value.description) }},
    %q{func sum<T: AdditiveArithmetic>(_ a: T, _ b: T) -> T { a + b }},
    "protocol Container {\n    associatedtype Element\n    mutating func append(_ element: Element)\n}",
    %q{struct Stack<Element>: Container { mutating func append(_ element: Element) { } }}
  ],
  15 => [
    "extension String {\n    var trimmed: String { trimmingCharacters(in: .whitespaces) }\n}",
    "extension Int {\n    func doubled() -> Int { self * 2 }\n}",
    "extension User {\n    func greet() { print(\"Hola, \\(name)\") }\n}",
    "extension User {\n    static func guest() -> User { User(name: \"Invitado\") }\n}",
    "extension Rectangle {\n    var area: Double { width * height }\n}",
    "extension User {\n    init() { self.init(name: \"Invitado\") }\n}",
    "extension Named {\n    var displayName: String { name.uppercased() }\n}",
    "extension User: Identifiable {\n    var id: String { name }\n}"
  ],
  16 => [
    %q{struct Account { private var pin: Int }},
    %q{fileprivate let cacheKey = "users"},
    %q{internal struct Session { }},
    %q{package struct SharedModel { }},
    %q{public struct UserAPI { public init() { } }},
    %q{open class ViewController { open func render() { } }}
  ],
  17 => [
    %q{enum ValidationError: Error { case emptyName }},
    %q{enum DatabaseError: Error { case userExists, invalidName }},
    %q{func save() throws { }},
    "func validate(name: String) throws {\n    if name.isEmpty { throw ValidationError.emptyName }\n}",
    %q{let user = try loadUser()},
    "do {\n    let user = try loadUser()\n    print(user)\n} catch {\n    print(error)\n}",
    "do { try save() } catch { print(error) }",
    "do { try save() }\ncatch DatabaseError.userExists { print(\"Ya existe\") }",
    "do { try save() }\ncatch let error { print(error) }",
    %q{let user = try? loadUser() // User?},
    %q{let user = try! loadBundledUser() // Falla si lanza},
    %q{func save() throws(DatabaseError) { throw .invalidName }},
    "let file = openFile()\ndefer { file.close() }\ntry process(file)",
    "func loadProfile() throws -> Profile {\n    try repository.fetchProfile()\n}"
  ],
  18 => [
    %q{if item is Movie { print("Es una película") }},
    %q{let animal: Animal = dog as Animal},
    "if let dog = animal as? Dog {\n    dog.bark()\n}",
    %q{let dog = animal as! Dog // Falla si no es Dog}
  ],
  19 => [
    %q{let status = isConnected ? "En línea" : "Sin conexión"},
    %q{let access = age >= 18 ? "Permitido" : "Denegado"},
    %q{let category = score > 90 ? "A" : score > 70 ? "B" : "C"},
    %q{isReady ? start() : ()},
    %q{let color = hasError ? errorColor : normalColor}
  ]
}.freeze

def slugify(text)
  text
    .unicode_normalize(:nfkd)
    .gsub(/\p{Mn}/, "")
    .downcase
    .gsub(/[^a-z0-9]+/, "-")
    .gsub(/\A-|-?\z/, "")
end

def inline_markdown(text)
  escaped = CGI.escapeHTML(text)
  code_tokens = []

  escaped = escaped.gsub(/`([^`]+)`/) do
    code_tokens << "<code>#{Regexp.last_match(1)}</code>"
    "\u0000CODE#{code_tokens.length - 1}\u0000"
  end

  escaped = escaped.gsub(/\[([^\]]+)\]\(([^)]+)\)/) do
    label = Regexp.last_match(1)
    href = Regexp.last_match(2)
    href = "##{slugify(href.delete_prefix("#"))}" if href.start_with?("#")
    href = "#{REPOSITORY_URL}/blob/main/#{href}" if href.start_with?("Swift/")
    external = href.start_with?("http://", "https://")
    attributes = external ? ' target="_blank" rel="noreferrer"' : ""
    %(<a href="#{href}"#{attributes}>#{label}</a>)
  end

  escaped = escaped.gsub(/\*\*([^*]+)\*\*/, "<strong>\\1</strong>")
  escaped = escaped.gsub(/\*([^*]+)\*/, "<em>\\1</em>")

  code_tokens.each_with_index do |token, index|
    escaped = escaped.gsub("\u0000CODE#{index}\u0000", token)
  end

  escaped
end

def render_markdown(markdown)
  lines = markdown.lines.map(&:chomp)
  html = []
  headings = []
  paragraph = []
  in_code = false
  code_language = ""
  code_lines = []
  section_open = false
  details_open = false
  current_chapter = nil
  example_counts = Hash.new(0)

  flush_paragraph = lambda do
    next if paragraph.empty?

    text = paragraph.join(" ")
    if text.start_with?("**Objetivo:**")
      html << "<div class=\"chapter-objective\">#{inline_markdown(text)}</div>"
    elsif text.start_with?("[Abrir playground]")
      html << "<p class=\"source-link\">#{inline_markdown(text)}</p>"
    else
      html << "<p>#{inline_markdown(text)}</p>"
    end
    paragraph.clear
  end

  close_details = lambda do
    next unless details_open

    html << "      </div>"
    html << "    </details>"
    details_open = false
  end

  close_section = lambda do
    close_details.call
    next unless section_open

    html << "    </div>"
    html << "  </section>"
    section_open = false
  end

  index = 0
  while index < lines.length
    line = lines[index]

    if in_code
      if line.start_with?("```")
        language_class = code_language.empty? ? "" : %( class="language-#{CGI.escapeHTML(code_language)}")
        html << %(<pre><code#{language_class}>#{CGI.escapeHTML(code_lines.join("\n"))}</code><button class="copy-code" type="button" aria-label="Copiar código">Copiar</button></pre>)
        in_code = false
        code_language = ""
        code_lines.clear
      else
        code_lines << line
      end
      index += 1
      next
    end

    if (fence = line.match(/\A```(.*)\z/))
      flush_paragraph.call
      in_code = true
      code_language = fence[1].strip
      index += 1
      next
    end

    if (heading = line.match(/\A(\#{1,3})\s+(.+)\z/))
      flush_paragraph.call
      level = heading[1].length
      title = heading[2]
      id = slugify(title)

      if level == 1
        html << %(<header class="hero" id="#{id}">)
        html << "  <p class=\"eyebrow\">GUÍA DE REFERENCIA</p>"
        html << "  <h1>#{inline_markdown(title)}</h1>"
        html << "  <p class=\"hero-summary\">20 capítulos · sintaxis · comportamiento · límites · nomenclatura oficial</p>"
        html << "  <p class=\"hero-note\">Los ejemplos son fragmentos breves de uso. Algunos dependen de tipos o variables definidos en su capítulo.</p>"
        html << "  <div class=\"hero-guides\">"
        html << "    <a href=\"clean-code.html\">Clean Code en iOS</a>"
        html << "    <a href=\"solid.html\">SOLID en iOS</a>"
        html << "  </div>"
        html << "</header>"
      elsif level == 2
        close_section.call
        chapter = title.match?(/\A\d+\./)
        current_chapter = chapter ? title[/\A\d+/].to_i : nil
        headings << [id, title] if chapter
        classes = chapter ? "chapter numbered-chapter" : "chapter reference-section"
        html << %(<section class="#{classes}" id="#{id}" data-search="#{CGI.escapeHTML(title.downcase)}">)
        html << "  <div class=\"chapter-heading\">"
        html << "    <h2>#{inline_markdown(title)}</h2>"
        html << "    <button class=\"chapter-toggle\" type=\"button\" aria-expanded=\"true\" aria-label=\"Plegar capítulo\">−</button>"
        html << "  </div>"
        html << "    <div class=\"chapter-body\">"
        section_open = true
      else
        close_details.call
        if title == "Nomenclatura oficial"
          html << "    <details class=\"terminology\">"
          html << "      <summary>Nomenclatura oficial <span>Ver términos</span></summary>"
          html << "      <div class=\"terminology-body\">"
          details_open = true
        else
          subgroup_id = current_chapter.nil? ? id : "#{current_chapter}-#{id}"
          html << %(<h3 id="#{subgroup_id}">#{inline_markdown(title)}</h3>)
        end
      end

      index += 1
      next
    end

    if line.match?(/\A-{3,}\z/)
      flush_paragraph.call
      index += 1
      next
    end

    if (item = line.match(/\A-\s+(.+)\z/))
      flush_paragraph.call
      root_content = item[1]
      nested_items = []
      cursor = index + 1

      while cursor < lines.length && (nested = lines[cursor].match(/\A  -\s+(.+)\z/))
        nested_items << nested[1]
        cursor += 1
      end

      if nested_items.empty?
        html << %(<div class="bullet-row"><span aria-hidden="true">•</span><div>#{inline_markdown(root_content)}</div></div>)
      elsif current_chapter
        example_index = example_counts[current_chapter]
        examples = EXAMPLES_BY_CHAPTER.fetch(current_chapter)
        example = examples[example_index]
        raise "Falta ejemplo para capítulo #{current_chapter}, ficha #{example_index + 1}: #{root_content}" unless example

        example_counts[current_chapter] += 1
        html << "<details class=\"study-card\">"
        html << "  <summary>"
        html << "    <span class=\"study-card-title\">#{inline_markdown(root_content)}</span>"
        html << "    <span class=\"card-action\">Ver detalle</span>"
        html << "  </summary>"
        html << "  <div class=\"study-card-body\">"
        html << "    <dl>"
        nested_items.each do |nested_text|
          if (definition = nested_text.match(/\A\*\*([^*]+):\*\*\s*(.*)\z/))
            html << "      <dt>#{inline_markdown(definition[1])}</dt>"
            html << "      <dd>#{inline_markdown(definition[2])}</dd>"
          else
            html << "      <dd>#{inline_markdown(nested_text)}</dd>"
          end
        end
        html << "    </dl>"
        html << "    <div class=\"example-block\">"
        html << "      <div class=\"example-label\">Ejemplo de uso</div>"
        html << %(<pre><code class="language-swift">#{CGI.escapeHTML(example)}</code><button class="copy-code" type="button" aria-label="Copiar código">Copiar</button></pre>)
        html << "    </div>"
        html << "  </div>"
        html << "</details>"
      else
        html << "<article class=\"study-card\">"
        html << "  <h4>#{inline_markdown(root_content)}</h4>"
        html << "  <dl>"
        nested_items.each do |nested_text|
          if (definition = nested_text.match(/\A\*\*([^*]+):\*\*\s*(.*)\z/))
            html << "    <dt>#{inline_markdown(definition[1])}</dt>"
            html << "    <dd>#{inline_markdown(definition[2])}</dd>"
          else
            html << "    <dd>#{inline_markdown(nested_text)}</dd>"
          end
        end
        html << "  </dl>"
        html << "</article>"
      end

      index = cursor
      next
    end

    if (ordered = line.match(/\A\d+\.\s+(.+)\z/))
      flush_paragraph.call
      ordered_items = [ordered[1]]
      cursor = index + 1
      while cursor < lines.length && (next_item = lines[cursor].match(/\A\d+\.\s+(.+)\z/))
        ordered_items << next_item[1]
        cursor += 1
      end
      html << "<ol class=\"ordered-list\">"
      ordered_items.each { |content| html << "  <li>#{inline_markdown(content)}</li>" }
      html << "</ol>"
      index = cursor
      next
    end

    if line.strip.empty?
      flush_paragraph.call
      index += 1
      next
    end

    paragraph << line.strip
    index += 1
  end

  flush_paragraph.call
  close_section.call

  EXAMPLES_BY_CHAPTER.each do |chapter, examples|
    rendered = example_counts[chapter]
    raise "Capítulo #{chapter}: #{rendered} fichas renderizadas, #{examples.length} ejemplos definidos" unless rendered == examples.length
  end

  [html.join("\n"), headings]
end

source = File.read(SOURCE, encoding: "UTF-8")
content, headings = render_markdown(source)

navigation = headings.map do |id, title|
  number, name = title.split(".", 2)
  <<~HTML
    <a class="nav-link" href="##{id}" data-target="#{id}">
      <span class="nav-number">#{number}</span>
      <span>#{CGI.escapeHTML(name.to_s.strip)}</span>
    </a>
  HTML
end.join

document = <<~HTML
  <!doctype html>
  <html lang="es">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="Guía de estudio de Swift: palabras clave, comportamiento, límites y nomenclatura oficial.">
    <title>Swift · Guía de estudio</title>
    <style>
      :root {
        color-scheme: light;
        --background: #f2f5f7;
        --surface: #ffffff;
        --surface-soft: #f8fafb;
        --text: #17212b;
        --muted: #64717d;
        --line: #dce3e8;
        --accent: #e6532f;
        --accent-dark: #b9381a;
        --accent-soft: #fff0eb;
        --code-bg: #17212b;
        --code-text: #eef6f8;
        --sidebar: #111b24;
        --sidebar-text: #d8e2e8;
        --sidebar-muted: #8fa1ad;
        --shadow: 0 12px 34px rgba(17, 27, 36, 0.08);
        --radius: 18px;
        --content-width: 900px;
      }

      [data-theme="dark"] {
        color-scheme: dark;
        --background: #0d141a;
        --surface: #15212a;
        --surface-soft: #101b23;
        --text: #edf3f5;
        --muted: #9cafb9;
        --line: #2a3a45;
        --accent: #ff7655;
        --accent-dark: #ff9a80;
        --accent-soft: #3b211d;
        --code-bg: #080d11;
        --code-text: #e6f0f4;
        --sidebar: #081016;
        --sidebar-text: #dce7ec;
        --sidebar-muted: #8296a2;
        --shadow: 0 14px 38px rgba(0, 0, 0, 0.26);
      }

      * {
        box-sizing: border-box;
      }

      html {
        scroll-behavior: smooth;
        scroll-padding-top: 24px;
      }

      body {
        margin: 0;
        background: var(--background);
        color: var(--text);
        font: 16px/1.65 -apple-system, BlinkMacSystemFont, "SF Pro Text", "Segoe UI", sans-serif;
      }

      button,
      input {
        font: inherit;
      }

      a {
        color: var(--accent-dark);
        text-decoration-thickness: 1px;
        text-underline-offset: 3px;
      }

      code {
        padding: 0.12rem 0.38rem;
        border: 1px solid var(--line);
        border-radius: 6px;
        background: var(--surface-soft);
        color: var(--accent-dark);
        font: 0.92em/1.4 "SFMono-Regular", Consolas, monospace;
      }

      .progress {
        position: fixed;
        z-index: 100;
        top: 0;
        left: 0;
        width: 0;
        height: 3px;
        background: linear-gradient(90deg, var(--accent), #ffb13b);
      }

      .layout {
        min-height: 100vh;
      }

      .sidebar {
        position: fixed;
        inset: 0 auto 0 0;
        z-index: 20;
        width: 300px;
        overflow-y: auto;
        padding: 30px 22px;
        background: var(--sidebar);
        color: var(--sidebar-text);
      }

      .brand {
        display: flex;
        align-items: center;
        gap: 12px;
        margin-bottom: 18px;
      }

      .brand-mark {
        display: grid;
        width: 42px;
        height: 42px;
        place-items: center;
        border-radius: 12px;
        background: linear-gradient(145deg, #ff8a55, #d8391d);
        color: #fff;
        font-weight: 800;
        box-shadow: 0 8px 22px rgba(230, 83, 47, 0.32);
      }

      .brand strong,
      .brand small {
        display: block;
      }

      .brand small {
        color: var(--sidebar-muted);
      }

      .guide-switcher {
        display: grid;
        grid-template-columns: repeat(3, 1fr);
        gap: 5px;
        margin-bottom: 18px;
        padding: 5px;
        border: 1px solid #31414c;
        border-radius: 11px;
      }

      .guide-switcher a {
        padding: 7px 4px;
        border-radius: 7px;
        color: var(--sidebar-muted);
        font-size: 0.73rem;
        text-align: center;
        text-decoration: none;
      }

      .guide-switcher a:hover,
      .guide-switcher a.active {
        background: var(--accent);
        color: #fff;
      }

      .search {
        width: 100%;
        padding: 11px 38px 11px 13px;
        border: 1px solid #31414c;
        border-radius: 10px;
        outline: none;
        background: #0b151c;
        color: #f5fafc;
      }

      .search:focus {
        border-color: var(--accent);
        box-shadow: 0 0 0 3px rgba(230, 83, 47, 0.18);
      }

      .search-wrap {
        position: relative;
      }

      .clear-search {
        position: absolute;
        top: 50%;
        right: 7px;
        display: grid;
        width: 28px;
        height: 28px;
        padding: 0;
        transform: translateY(-50%);
        place-items: center;
        border: 0;
        border-radius: 7px;
        background: transparent;
        color: var(--sidebar-muted);
        cursor: pointer;
      }

      .clear-search:hover {
        background: rgba(255, 255, 255, 0.08);
        color: #fff;
      }

      .search-status {
        min-height: 21px;
        margin: 7px 2px 15px;
        color: var(--sidebar-muted);
        font-size: 0.78rem;
      }

      .nav-label {
        margin: 20px 8px 8px;
        color: var(--sidebar-muted);
        font-size: 0.72rem;
        font-weight: 700;
        letter-spacing: 0.12em;
        text-transform: uppercase;
      }

      .nav-link {
        display: flex;
        align-items: center;
        gap: 10px;
        margin: 2px 0;
        padding: 8px 10px;
        border-radius: 9px;
        color: var(--sidebar-text);
        font-size: 0.9rem;
        text-decoration: none;
      }

      .nav-link:hover,
      .nav-link.active {
        background: rgba(255, 255, 255, 0.08);
        color: #fff;
      }

      .nav-link.active .nav-number {
        background: var(--accent);
        color: #fff;
      }

      .nav-number {
        display: grid;
        flex: 0 0 27px;
        height: 27px;
        place-items: center;
        border-radius: 8px;
        background: #22313b;
        color: #aebdc5;
        font-size: 0.76rem;
        font-weight: 700;
      }

      .sidebar-actions {
        display: grid;
        grid-template-columns: 1fr 1fr;
        gap: 8px;
        margin-top: 24px;
      }

      .sidebar-actions button {
        padding: 8px;
        border: 1px solid #31414c;
        border-radius: 9px;
        background: transparent;
        color: var(--sidebar-text);
        cursor: pointer;
      }

      .sidebar-actions button:hover {
        border-color: var(--accent);
      }

      .main {
        width: min(calc(100% - 300px), 1180px);
        margin-left: 300px;
        padding: 50px clamp(28px, 5vw, 80px) 100px;
      }

      .hero,
      .chapter {
        width: min(100%, var(--content-width));
        margin-inline: auto;
      }

      .hero {
        position: relative;
        overflow: hidden;
        margin-bottom: 34px;
        padding: clamp(38px, 6vw, 70px);
        border-radius: 26px;
        background:
          radial-gradient(circle at 92% 12%, rgba(255, 180, 80, 0.42), transparent 26%),
          linear-gradient(135deg, #e6532f, #b72f18);
        color: #fff;
        box-shadow: var(--shadow);
      }

      .hero::after {
        position: absolute;
        right: -46px;
        bottom: -76px;
        width: 230px;
        height: 230px;
        border: 34px solid rgba(255, 255, 255, 0.1);
        border-radius: 50%;
        content: "";
      }

      .eyebrow {
        margin: 0 0 12px;
        font-size: 0.72rem;
        font-weight: 800;
        letter-spacing: 0.17em;
      }

      .hero h1 {
        max-width: 690px;
        margin: 0;
        font-size: clamp(2.2rem, 5vw, 4.5rem);
        line-height: 0.98;
        letter-spacing: -0.05em;
      }

      .hero-summary {
        max-width: 560px;
        margin: 22px 0 0;
        color: rgba(255, 255, 255, 0.82);
      }

      .hero-note {
        max-width: 610px;
        margin: 12px 0 0;
        color: rgba(255, 255, 255, 0.7);
        font-size: 0.84rem;
      }

      .hero-guides {
        display: flex;
        flex-wrap: wrap;
        gap: 9px;
        margin-top: 22px;
      }

      .hero-guides a {
        padding: 8px 12px;
        border: 1px solid rgba(255, 255, 255, 0.42);
        border-radius: 9px;
        color: #fff;
        font-size: 0.84rem;
        text-decoration: none;
      }

      .chapter {
        margin-bottom: 24px;
        border: 1px solid var(--line);
        border-radius: var(--radius);
        background: var(--surface);
        box-shadow: var(--shadow);
      }

      .chapter-heading {
        display: flex;
        align-items: center;
        justify-content: space-between;
        gap: 16px;
        padding: 24px 28px;
        border-bottom: 1px solid var(--line);
      }

      .chapter-heading h2 {
        margin: 0;
        font-size: clamp(1.35rem, 2vw, 1.8rem);
        letter-spacing: -0.025em;
      }

      .chapter-toggle {
        display: grid;
        flex: 0 0 34px;
        height: 34px;
        place-items: center;
        border: 1px solid var(--line);
        border-radius: 50%;
        background: var(--surface-soft);
        color: var(--text);
        cursor: pointer;
      }

      .chapter-body {
        padding: 26px 28px 32px;
      }

      .source-link {
        margin: 0 0 12px !important;
        font-size: 0.83rem;
      }

      .source-link a {
        display: inline-flex;
        align-items: center;
        padding: 5px 9px;
        border: 1px solid var(--line);
        border-radius: 8px;
        background: var(--surface-soft);
        text-decoration: none;
      }

      .chapter-objective {
        margin: 10px 0 20px;
        padding: 16px 18px;
        border-radius: 12px;
        background: var(--accent-soft);
        color: var(--text);
      }

      .chapter-objective strong {
        color: var(--accent-dark);
      }

      .chapter.collapsed .chapter-body {
        display: none;
      }

      .chapter.collapsed .chapter-heading {
        border-bottom: 0;
      }

      .chapter h3 {
        margin: 30px 0 14px;
        color: var(--accent-dark);
        font-size: 1.03rem;
        letter-spacing: 0.035em;
        text-transform: uppercase;
      }

      .chapter h3:first-child {
        margin-top: 0;
      }

      .terminology {
        margin: 18px 0 26px;
        border: 1px solid var(--line);
        border-radius: 12px;
        background: var(--surface-soft);
      }

      .terminology summary {
        display: flex;
        align-items: center;
        justify-content: space-between;
        gap: 16px;
        padding: 14px 17px;
        color: var(--accent-dark);
        cursor: pointer;
        font-weight: 750;
        list-style: none;
      }

      .terminology summary::-webkit-details-marker {
        display: none;
      }

      .terminology summary span {
        color: var(--muted);
        font-size: 0.76rem;
        font-weight: 600;
      }

      .terminology[open] summary {
        border-bottom: 1px solid var(--line);
      }

      .terminology[open] summary span {
        font-size: 0;
      }

      .terminology[open] summary span::before {
        content: "Ocultar términos";
        font-size: 0.76rem;
      }

      .terminology-body {
        display: grid;
        grid-template-columns: repeat(2, minmax(0, 1fr));
        gap: 4px 20px;
        padding: 12px 17px 16px;
      }

      .terminology .bullet-row {
        margin: 4px 0;
        font-size: 0.9rem;
      }

      .chapter p {
        margin: 12px 0;
      }

      .chapter hr {
        height: 1px;
        margin: 32px 0;
        border: 0;
        background: var(--line);
      }

      .bullet-row {
        display: grid;
        grid-template-columns: 18px 1fr;
        gap: 4px;
        margin: 8px 0;
      }

      .bullet-row > span {
        color: var(--accent);
        font-size: 1.2rem;
        line-height: 1.35;
      }

      .study-card {
        margin: 12px 0;
        border: 1px solid var(--line);
        border-left: 4px solid var(--accent);
        border-radius: 12px;
        background: var(--surface-soft);
        overflow: hidden;
      }

      .study-card:not(details) {
        padding: 18px 20px;
      }

      .study-card h4 {
        margin: 0 0 12px;
        font-size: 1rem;
      }

      details.study-card > summary {
        display: flex;
        align-items: center;
        justify-content: space-between;
        gap: 20px;
        padding: 17px 20px;
        cursor: pointer;
        list-style: none;
      }

      details.study-card > summary::-webkit-details-marker {
        display: none;
      }

      details.study-card > summary:hover {
        background: color-mix(in srgb, var(--accent-soft) 52%, transparent);
      }

      details.study-card[open] > summary {
        border-bottom: 1px solid var(--line);
        background: var(--accent-soft);
      }

      .study-card-title {
        min-width: 0;
        font-size: 1rem;
        font-weight: 720;
      }

      .card-action {
        flex: 0 0 auto;
        color: var(--muted);
        font-size: 0.76rem;
        font-weight: 650;
      }

      details.study-card[open] .card-action::before {
        content: "Ocultar detalle";
      }

      details.study-card[open] .card-action {
        font-size: 0;
      }

      details.study-card[open] .card-action::before {
        font-size: 0.76rem;
      }

      .study-card-body {
        padding: 18px 20px 20px;
      }

      .study-card dl {
        display: grid;
        grid-template-columns: minmax(120px, 170px) 1fr;
        gap: 7px 14px;
        margin: 0;
      }

      .study-card dt {
        color: var(--muted);
        font-size: 0.82rem;
        font-weight: 750;
        letter-spacing: 0.02em;
      }

      .study-card dd {
        margin: 0;
      }

      .example-block {
        margin-top: 18px;
        padding-top: 16px;
        border-top: 1px solid var(--line);
      }

      .example-label {
        margin-bottom: 7px;
        color: var(--muted);
        font-size: 0.74rem;
        font-weight: 750;
        letter-spacing: 0.08em;
        text-transform: uppercase;
      }

      .example-block pre {
        margin: 0;
      }

      .ordered-list {
        padding-left: 1.4rem;
      }

      pre {
        position: relative;
        overflow-x: auto;
        margin: 18px 0;
        padding: 22px;
        border-radius: 14px;
        background: var(--code-bg);
        color: var(--code-text);
      }

      pre code {
        padding: 0;
        border: 0;
        background: transparent;
        color: inherit;
        font-size: 0.88rem;
      }

      .copy-code {
        position: absolute;
        top: 10px;
        right: 10px;
        padding: 5px 9px;
        border: 1px solid #42525e;
        border-radius: 7px;
        background: #24333e;
        color: #dce7ec;
        cursor: pointer;
        font-size: 0.75rem;
      }

      .empty-state {
        display: none;
        width: min(100%, var(--content-width));
        margin: 30px auto;
        padding: 40px;
        border: 1px dashed var(--line);
        border-radius: var(--radius);
        color: var(--muted);
        text-align: center;
      }

      .mobile-bar {
        display: none;
      }

      @media (max-width: 900px) {
        .mobile-bar {
          position: sticky;
          top: 0;
          z-index: 15;
          display: flex;
          align-items: center;
          justify-content: space-between;
          padding: 12px 16px;
          border-bottom: 1px solid var(--line);
          background: var(--surface);
          background: color-mix(in srgb, var(--surface) 92%, transparent);
          backdrop-filter: blur(12px);
        }

        .mobile-bar button {
          padding: 7px 11px;
          border: 1px solid var(--line);
          border-radius: 8px;
          background: var(--surface);
          color: var(--text);
        }

        .sidebar {
          width: min(84vw, 320px);
          transform: translateX(-105%);
          transition: transform 180ms ease;
          box-shadow: 20px 0 50px rgba(0, 0, 0, 0.3);
        }

        .sidebar.open {
          transform: translateX(0);
        }

        .main {
          width: 100%;
          margin-left: 0;
          padding: 24px 16px 70px;
        }

        .hero {
          border-radius: 20px;
        }
      }

      @media (max-width: 560px) {
        .chapter-heading,
        .chapter-body {
          padding-inline: 18px;
        }

        .study-card dl {
          grid-template-columns: 1fr;
        }

        .terminology-body {
          grid-template-columns: 1fr;
        }

        .study-card dt {
          margin-top: 6px;
        }
      }

      @media print {
        :root {
          --background: #fff;
          --surface: #fff;
          --surface-soft: #fff;
          --text: #000;
          --muted: #444;
          --line: #bbb;
          --shadow: none;
        }

        .sidebar,
        .mobile-bar,
        .progress,
        .chapter-toggle,
        .copy-code {
          display: none !important;
        }

        .main {
          width: 100%;
          margin: 0;
          padding: 0;
        }

        .hero {
          padding: 30px;
          border: 1px solid #aaa;
          background: #fff;
          color: #000;
          box-shadow: none;
        }

        .hero-summary {
          color: #333;
        }

        .chapter {
          break-inside: avoid-page;
          box-shadow: none;
        }

        .chapter.collapsed .chapter-body {
          display: block;
        }

        a {
          color: #000;
        }
      }
    </style>
  </head>
  <body>
    <div class="progress" id="progress"></div>
    <div class="mobile-bar">
      <strong>Swift · Estudio</strong>
      <button id="menuButton" type="button">Capítulos</button>
    </div>
    <div class="layout">
      <aside class="sidebar" id="sidebar">
        <div class="brand">
          <div class="brand-mark">S</div>
          <div>
            <strong>Swift Study</strong>
            <small>20 capítulos</small>
          </div>
        </div>
        <div class="guide-switcher">
          <a class="active" href="index.html">Swift</a>
          <a href="clean-code.html">Clean Code</a>
          <a href="solid.html">SOLID</a>
        </div>
        <div class="search-wrap">
          <input class="search" id="search" type="search" placeholder="Buscar concepto…" aria-label="Buscar concepto" autocomplete="off">
          <button class="clear-search" id="clearSearch" type="button" aria-label="Limpiar búsqueda">×</button>
        </div>
        <div class="search-status" id="searchStatus" aria-live="polite">20 capítulos disponibles</div>
        <div class="nav-label">Capítulos</div>
        <nav id="navigation">
          #{navigation}
        </nav>
        <div class="sidebar-actions">
          <button id="expandAll" type="button">Expandir</button>
          <button id="collapseAll" type="button">Plegar</button>
          <button id="themeToggle" type="button">Tema</button>
          <button id="printButton" type="button">Imprimir</button>
        </div>
      </aside>
      <main class="main">
        #{content}
        <div class="empty-state" id="emptyState">No se encontraron conceptos con esa búsqueda.</div>
      </main>
    </div>
    <script>
      const chapters = [...document.querySelectorAll(".chapter")];
      const numberedChapters = [...document.querySelectorAll(".numbered-chapter")];
      const navLinks = [...document.querySelectorAll(".nav-link")];
      const studyCards = [...document.querySelectorAll("details.study-card")];
      const sidebar = document.querySelector("#sidebar");
      const search = document.querySelector("#search");
      const searchStatus = document.querySelector("#searchStatus");
      const emptyState = document.querySelector("#emptyState");

      document.querySelectorAll(".chapter-toggle").forEach((button) => {
        button.addEventListener("click", () => {
          const chapter = button.closest(".chapter");
          const collapsed = chapter.classList.toggle("collapsed");
          button.textContent = collapsed ? "+" : "−";
          button.setAttribute("aria-expanded", String(!collapsed));
        });
      });

      document.querySelector("#expandAll").addEventListener("click", () => {
        chapters.forEach((chapter) => chapter.classList.remove("collapsed"));
        document.querySelectorAll("details").forEach((detail) => { detail.open = true; });
        document.querySelectorAll(".chapter-toggle").forEach((button) => {
          button.textContent = "−";
          button.setAttribute("aria-expanded", "true");
        });
      });

      document.querySelector("#collapseAll").addEventListener("click", () => {
        document.querySelectorAll("details").forEach((detail) => { detail.open = false; });
        numberedChapters.forEach((chapter) => chapter.classList.add("collapsed"));
        numberedChapters.forEach((chapter) => {
          const button = chapter.querySelector(".chapter-toggle");
          button.textContent = "+";
          button.setAttribute("aria-expanded", "false");
        });
      });

      const normalizeText = (value) => {
        const lowered = String(value || "").toLowerCase();
        return typeof lowered.normalize === "function"
          ? lowered.normalize("NFD").replace(/[\\u0300-\\u036f]/g, "")
          : lowered;
      };

      const runSearch = () => {
        const query = normalizeText(search.value.trim());
        let matchingChapters = 0;
        let matchingCards = 0;

        chapters.forEach((chapter) => {
          const cards = [...chapter.querySelectorAll("details.study-card")];
          const heading = chapter.querySelector("h2");
          const terminology = chapter.querySelector("details.terminology");
          const objective = chapter.querySelector(".chapter-objective");
          const titleMatches = Boolean(query && heading && normalizeText(heading.textContent).includes(query));
          const supportingText = `${terminology ? terminology.textContent : ""} ${objective ? objective.textContent : ""}`;
          const supportingMatches = Boolean(query && normalizeText(supportingText).includes(query));
          let chapterCardMatches = 0;

          cards.forEach((card) => {
            const cardMatches = !query || titleMatches || normalizeText(card.textContent).includes(query);
            card.hidden = !cardMatches;
            if (query && cardMatches) {
              card.open = true;
              chapterCardMatches += 1;
            }
          });

          const completeTextMatches = !query || normalizeText(chapter.textContent).includes(query);
          const matches = !query || titleMatches || supportingMatches || chapterCardMatches > 0 || (cards.length === 0 && completeTextMatches);
          chapter.hidden = !matches;

          if (supportingMatches && terminology) terminology.open = true;

          if (matches && chapter.classList.contains("numbered-chapter")) {
            matchingChapters += 1;
            matchingCards += query ? chapterCardMatches : cards.length;
          }

          if (matches && query) {
            chapter.classList.remove("collapsed");
            const button = chapter.querySelector(".chapter-toggle");
            button.textContent = "−";
            button.setAttribute("aria-expanded", "true");
          }
        });

        navLinks.forEach((link) => {
          const target = document.getElementById(link.dataset.target);
          link.hidden = Boolean(target && target.hidden);
        });

        emptyState.style.display = matchingChapters ? "none" : "block";
        searchStatus.textContent = query
          ? `${matchingChapters} ${matchingChapters === 1 ? "capítulo" : "capítulos"} · ${matchingCards} ${matchingCards === 1 ? "subpunto" : "subpuntos"}`
          : `${numberedChapters.length} capítulos disponibles`;
      };

      search.addEventListener("input", runSearch);
      search.addEventListener("search", runSearch);
      search.addEventListener("keydown", (event) => {
        if (event.key !== "Escape") return;
        search.value = "";
        runSearch();
      });

      document.querySelector("#clearSearch").addEventListener("click", () => {
        search.value = "";
        runSearch();
        search.focus();
      });

      document.querySelectorAll(".copy-code").forEach((button) => {
        button.addEventListener("click", async () => {
          const code = button.parentElement.querySelector("code").textContent;
          try {
            await navigator.clipboard.writeText(code);
            button.textContent = "Copiado";
          } catch {
            button.textContent = "No disponible";
          }
          setTimeout(() => { button.textContent = "Copiar"; }, 1200);
        });
      });

      try {
        const savedTheme = localStorage.getItem("swift-study-theme");
        if (savedTheme) document.documentElement.dataset.theme = savedTheme;
      } catch {
        // Algunos navegadores bloquean localStorage cuando el archivo usa file://.
      }

      document.querySelector("#themeToggle").addEventListener("click", () => {
        const next = document.documentElement.dataset.theme === "dark" ? "light" : "dark";
        document.documentElement.dataset.theme = next;
        try {
          localStorage.setItem("swift-study-theme", next);
        } catch {
          // El cambio de tema sigue funcionando aunque no pueda persistirse.
        }
      });

      document.querySelector("#printButton").addEventListener("click", () => window.print());
      document.querySelector("#menuButton").addEventListener("click", () => sidebar.classList.toggle("open"));
      navLinks.forEach((link) => link.addEventListener("click", () => sidebar.classList.remove("open")));

      if ("IntersectionObserver" in window) {
        const observer = new IntersectionObserver((entries) => {
          entries.forEach((entry) => {
            if (!entry.isIntersecting) return;
            navLinks.forEach((link) => link.classList.toggle("active", link.dataset.target === entry.target.id));
          });
        }, { rootMargin: "-15% 0px -75% 0px" });

        numberedChapters.forEach((chapter) => observer.observe(chapter));
      }

      let printCardStates = [];
      let printChapterStates = [];
      window.addEventListener("beforeprint", () => {
        printCardStates = studyCards.map((card) => card.open);
        printChapterStates = chapters.map((chapter) => chapter.classList.contains("collapsed"));
        studyCards.forEach((card) => { card.open = true; });
        chapters.forEach((chapter) => chapter.classList.remove("collapsed"));
      });

      window.addEventListener("afterprint", () => {
        studyCards.forEach((card, index) => { card.open = printCardStates[index]; });
        chapters.forEach((chapter, index) => {
          chapter.classList.toggle("collapsed", printChapterStates[index]);
        });
      });

      window.addEventListener("scroll", () => {
        const scrollable = document.documentElement.scrollHeight - innerHeight;
        const progress = scrollable > 0 ? (scrollY / scrollable) * 100 : 0;
        document.querySelector("#progress").style.width = `${Math.min(progress, 100)}%`;
      }, { passive: true });
    </script>
  </body>
  </html>
HTML

File.write(OUTPUT, document, mode: "w", encoding: "UTF-8")
puts "Generated #{OUTPUT}"
