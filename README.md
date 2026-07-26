# 📱 Swift - Análisis Completo con Playgrounds

[![Swift](https://img.shields.io/badge/Swift-5.9+-orange.svg)](https://swift.org)
[![Platform](https://img.shields.io/badge/Platform-iOS%20%7C%20macOS-lightgrey.svg)](https://developer.apple.com)
[![License](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![Stars](https://img.shields.io/github/stars/Rodolfo-Swift-dev/Swift-Analisis-Playgrounds.svg)](https://github.com/Rodolfo-Swift-dev/Swift-Analisis-Playgrounds/stargazers)
[![Guía web](https://img.shields.io/website?label=Gu%C3%ADa%20web&url=https%3A%2F%2Frodolfo-swift-dev.github.io%2FSwift-Analisis-Playgrounds%2F)](https://rodolfo-swift-dev.github.io/Swift-Analisis-Playgrounds/)

> 🎯 Repositorio educativo completo con ejemplos prácticos de Swift, principios SOLID y Clean Code implementados en Xcode Playgrounds.

## 🌐 Guía interactiva

La guía reúne los 20 capítulos con buscador, ejemplos desplegables, palabras clave,
comportamiento y límites del lenguaje. Funciona en Safari móvil y navegadores de
escritorio.

### **[➡️ Abrir Swift · Guía de estudio](https://rodolfo-swift-dev.github.io/Swift-Analisis-Playgrounds/)**

Guías complementarias enfocadas en diseño de aplicaciones iOS:

- **[Clean Code en Swift e iOS](https://rodolfo-swift-dev.github.io/Swift-Analisis-Playgrounds/clean-code.html)**
- **[SOLID en Swift e iOS](https://rodolfo-swift-dev.github.io/Swift-Analisis-Playgrounds/solid.html)**

También puedes consultar los archivos directamente en el repositorio:

- [HTML publicado (`docs/index.html`)](docs/index.html)
- [Clean Code (`docs/clean-code.html`)](docs/clean-code.html)
- [SOLID (`docs/solid.html`)](docs/solid.html)
- [Resumen en Markdown](docs/TEMARIO_DE_ESTUDIO_SWIFT.md)
- [Ruta de aprendizaje](docs/LEARNING_PATH.md)

---

## 📋 Tabla de Contenidos

- [Sobre el Proyecto](#-sobre-el-proyecto)
- [Guía interactiva](#-guía-interactiva)
- [Contenido](#-contenido)
- [Requisitos](#-requisitos)
- [Instalación](#-instalación)
- [Uso](#-uso)
- [Estructura del Proyecto](#-estructura-del-proyecto)
- [Temas Cubiertos](#-temas-cubiertos)
- [Contribuir](#-contribuir)
- [Licencia](#-licencia)
- [Contacto](#-contacto)

---

## 🎓 Sobre el Proyecto

Este repositorio contiene una colección completa de **Xcode Playgrounds** diseñados para aprender y dominar Swift desde cero hasta conceptos avanzados. Ideal para:

- 🌱 Desarrolladores principiantes en Swift
- 💪 Desarrolladores que quieren reforzar conceptos
- 🎯 Preparación para entrevistas técnicas
- 📚 Referencia rápida de sintaxis y patrones

Todos los ejemplos están documentados en **español** con explicaciones claras y casos prácticos.

---

## 📦 Contenido

### 🔷 Swift Fundamentals (20+ Playgrounds)

Colección completa de playgrounds organizados por tema:

| # | Playground | Descripción |
|---|---|---|
| 0 | **Basic** | Tipos de datos, operadores, print |
| 1 | **TypeAlias** | Alias de tipos personalizados |
| 2 | **Tuplas** | Trabajar con tuplas |
| 3 | **Optional** | Manejo de opcionales y unwrapping |
| 4 | **Colecciones** | Arrays, Sets, Dictionaries |
| 5 | **ControlFlow** | If, guard, switch, loops |
| 6 | **Funciones** | Declaración, parámetros, retorno |
| 7 | **Clases y Estructuras** | Diferencias y usos |
| 8 | **Métodos** | Instance y type methods |
| 9 | **Propiedades** | Stored, computed, observers |
| 10 | **Closures** | Sintaxis, captura de valores |
| 11 | **Enum** | Enumeraciones y associated values |
| 12 | **Herencia** | Subclassing y override |
| 13 | **Protocolos** | Protocols y conformance |
| 14 | **Genéricos** | Generic functions y types |
| 15 | **Extensiones** | Extender tipos existentes |
| 16 | **Access Level** | open, public, package, internal, fileprivate, private |
| 17 | **Gestión de Errores** | do-try-catch, throws |
| 18 | **Type Casting** | is, as, as?, as!, Any, AnyObject |
| 19 | **Operador Ternario** | Sintaxis y casos de uso |
| + | **KeywordsSwift** | Palabras clave del lenguaje |
| + | **Content** | Índice general |

### 🔶 SOLID Principles

Implementación práctica de los 5 principios SOLID mediante una funcionalidad
de perfiles para iOS:

- **S**ingle Responsibility Principle (SRP)
- **O**pen/Closed Principle (OCP)
- **L**iskov Substitution Principle (LSP)
- **I**nterface Segregation Principle (ISP)
- **D**ependency Inversion Principle (DIP)

Cada principio incluye intención, comportamiento, límites, ejemplos
**BAD** vs **GOOD**, contratos verificables, concurrencia y señales de
sobrearquitectura.

### 🔷 Clean Code

Mejores prácticas de código limpio aplicadas a Swift e iOS:

1. ✅ Nombres y diseño de APIs
2. ✅ Estado, alcance y value semantics
3. ✅ Funciones y tipos del dominio
4. ✅ Optional, `throws` y errores con significado
5. ✅ Efectos secundarios e inyección de dependencias
6. ✅ `async/await`, `MainActor`, `Sendable` y cancelación
7. ✅ ARC, pruebas de comportamiento y DocC
8. ✅ DRY, refactorización y límites de las abstracciones

---

## 💻 Requisitos

- **Xcode**: 15.0 o superior; Xcode 16+ para ejecutar ejemplos con Swift Testing
- **Swift**: 5.9 o superior; los playgrounds de diseño también se validan con Swift 6 y concurrencia estricta
- **macOS**: una versión compatible con la edición de Xcode seleccionada

---

## 🚀 Instalación

### Clonar el repositorio

```bash
git clone https://github.com/Rodolfo-Swift-dev/Swift-Analisis-Playgrounds.git
cd Swift-Analisis-Playgrounds
```

### Abrir en Xcode

```bash
# Opción 1: Abrir playground individual
open Swift/0-Basic.playground

# Opción 2: Abrir carpeta completa en Xcode
open .
```

---

## 🎯 Uso

### Desde móvil o navegador

1. Abre la [guía de Swift](https://rodolfo-swift-dev.github.io/Swift-Analisis-Playgrounds/), [Clean Code](https://rodolfo-swift-dev.github.io/Swift-Analisis-Playgrounds/clean-code.html) o [SOLID](https://rodolfo-swift-dev.github.io/Swift-Analisis-Playgrounds/solid.html).
2. Usa el buscador para localizar una palabra clave.
3. Despliega cada subpunto para revisar su explicación y ejemplo.
4. Pulsa **Abrir playground** para consultar el código fuente correspondiente en GitHub.

### Para Principiantes

1. Comienza con [`Swift/0-Basic.playground`](Swift/0-Basic.playground/Contents.swift)
2. Sigue el orden numérico (0 → 19)
3. Ejecuta cada ejemplo línea por línea
4. Experimenta modificando los valores

### Para Desarrolladores Intermedios

1. Revisa `SOLID/SOLID.playground` para arquitectura
2. Estudia `Clean_Code/CleanCode.playground` para mejores prácticas
3. Usa como referencia rápida para conceptos específicos

### Ejemplo de Uso

```swift
// Abre Swift/3-Optional.playground
// Ejecuta el playground y observa los resultados

var optionalString: String? = "Hello"

// Unwrapping seguro
if let unwrapped = optionalString {
    print(unwrapped) // "Hello"
}

// Nil coalescing
let defaultValue = optionalString ?? "Default"
print(defaultValue) // "Hello"
```

---

## 📁 Estructura del Proyecto

```
Swift-Analisis-Playgrounds/
├── README.md                          # Este archivo
├── CHANGELOG.md                       # Historial de cambios
├── docs/                              # Guía web publicada con GitHub Pages
│   ├── .nojekyll
│   ├── CONTRIBUTING.md
│   ├── LEARNING_PATH.md
│   ├── clean-code.html
│   ├── index.html
│   ├── solid.html
│   └── TEMARIO_DE_ESTUDIO_SWIFT.md
├── tools/                             # Fuente y generador de la guía web
│   ├── clean_code_ios.md
│   ├── generate_principles_html.rb
│   ├── generate_study_html.rb
│   ├── solid_ios.md
│   └── study_guide_full.md
├── Swift/                             # Playgrounds de Swift
│   ├── 0-Basic.playground
│   ├── 1-TypeAlias.playground
│   ├── 2-Tuplas.playground
│   ├── 3-Optional.playground
│   ├── 4-Colecciones.playground
│   ├── 5-ControlFlow.playground
│   ├── 6-Funciones.playground
│   ├── 7-ClasesyEstructuras.playground
│   ├── 8-Metodos.playground
│   ├── 9-Propiedades.playground
│   ├── 10-Closures.playground
│   ├── 11-Enum.playground
│   ├── 12-Herencia.playground
│   ├── 13-Protocolos.playground
│   ├── 14-Genericos.playground
│   ├── 15-Extensiones.playground
│   ├── 16-AccesLevel.playground
│   ├── 17-Gestion de errores.playground
│   ├── 18-typeCasting.playground
│   ├── 19-Operador ternario.playground
│   ├── Content.playground
│   └── KeywordsSwift.playground
├── SOLID/                             # Principios SOLID
│   └── SOLID.playground
└── Clean_Code/                        # Clean Code
    └── CleanCode.playground
```

---

## 🛠️ Mantenimiento de la guía

GitHub Pages publica los archivos de `docs/` desde la rama `main`. El navegador
no necesita Ruby ni las herramientas del proyecto.

Para actualizar la guía de los 20 capítulos:

1. Edita [`tools/study_guide_full.md`](tools/study_guide_full.md).
2. Actualiza los ejemplos del generador cuando corresponda.
3. Ejecuta:

   ```bash
   ruby tools/generate_study_html.rb
   ```

4. Comprueba que `docs/index.html` contiene los cambios.

Para actualizar las guías de Clean Code y SOLID:

1. Edita [`tools/clean_code_ios.md`](tools/clean_code_ios.md) o
   [`tools/solid_ios.md`](tools/solid_ios.md).
2. Ejecuta:

   ```bash
   ruby tools/generate_principles_html.rb
   ```

3. Comprueba `docs/clean-code.html` y `docs/solid.html`.

[`tools/generate_study_html.rb`](tools/generate_study_html.rb) es una herramienta de
mantenimiento: genera una salida reproducible y evita editar manualmente un HTML de
miles de líneas. [`tools/generate_principles_html.rb`](tools/generate_principles_html.rb)
aplica la misma idea a las dos guías de diseño iOS.

---

## 📚 Temas Cubiertos

### Fundamentos
- ✅ Variables y Constantes (`let`, `var`)
- ✅ Tipos de Datos Básicos (Int, Double, String, Bool)
- ✅ Inferencia de Tipos
- ✅ Operadores (Aritméticos, Comparación, Lógicos)
- ✅ Strings y Interpolación

### Colecciones
- ✅ Arrays (arreglos)
- ✅ Sets (conjuntos)
- ✅ Dictionaries (diccionarios)
- ✅ Iteración y métodos de colección

### Control de Flujo
- ✅ If-Else
- ✅ Guard
- ✅ Switch
- ✅ For, While, Repeat-While
- ✅ Range Operators

### Funciones y Closures
- ✅ Declaración de funciones
- ✅ Parámetros y valores de retorno
- ✅ Parámetros in-out
- ✅ Closures y trailing closure syntax
- ✅ Captura de valores

### Programación Orientada a Objetos
- ✅ Clases vs Estructuras
- ✅ Propiedades (stored, computed, observers)
- ✅ Métodos (instance, type)
- ✅ Herencia
- ✅ Inicializadores
- ✅ Deinicializadores

### Protocolos y Extensiones
- ✅ Protocol-Oriented Programming
- ✅ Protocol conformance
- ✅ Extensions
- ✅ Default implementations

### Características Avanzadas
- ✅ Optionals y Optional Chaining
- ✅ Error Handling (do-try-catch)
- ✅ Generics
- ✅ Type Casting
- ✅ Access Control
- ✅ Memory Management (ARC)

### Patrones de Diseño
- ✅ SOLID Principles
- ✅ Clean Code practices
- ✅ Swift best practices

---

## 🤝 Contribuir

Las contribuciones son bienvenidas. Consulta también la
[guía completa de contribución](docs/CONTRIBUTING.md).

1. **Fork** el proyecto
2. Crea tu rama de feature (`git checkout -b feature/AmazingFeature`)
3. Commit tus cambios (`git commit -m 'Add some AmazingFeature'`)
4. Push a la rama (`git push origin feature/AmazingFeature`)
5. Abre un **Pull Request**

### Ideas para Contribuir

- 📝 Agregar más ejemplos a playgrounds existentes
- 🆕 Crear nuevos playgrounds (Combine, Async/Await, etc.)
- 🌍 Traducir a otros idiomas
- 🐛 Reportar o corregir errores
- 📚 Mejorar documentación
- ✨ Actualizar a las últimas versiones de Swift

---

## 📄 Licencia

Distribuido bajo la licencia MIT. Ver `LICENSE` para más información.

---

## 👨‍💻 Contacto

**Rodolfo Gonzalez**
- GitHub: [@Rodolfo-Swift-dev](https://github.com/Rodolfo-Swift-dev)

**Link del Proyecto**: [https://github.com/Rodolfo-Swift-dev/Swift-Analisis-Playgrounds](https://github.com/Rodolfo-Swift-dev/Swift-Analisis-Playgrounds)

---

## ⭐ Agradecimientos

- Swift.org por la documentación oficial
- Comunidad de desarrolladores iOS/macOS
- Todos los contribuidores de este proyecto

---

## 📈 Roadmap

- [ ] Agregar playgrounds de SwiftUI
- [ ] Agregar playgrounds de Combine
- [ ] Agregar playgrounds de Async/Await (Swift 5.5+)
- [ ] Agregar playgrounds de Swift Concurrency
- [ ] Agregar Unit Tests examples
- [ ] Crear versión en inglés
- [ ] Agregar videos explicativos

---

<div align="center">

**⭐ Si este proyecto te ayudó, considera darle una estrella ⭐**

Made with ❤️ by [Rodolfo-Swift-dev](https://github.com/Rodolfo-Swift-dev)

</div>
