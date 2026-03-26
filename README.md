# 📱 Swift - Análisis Completo con Playgrounds

[![Swift](https://img.shields.io/badge/Swift-5.9+-orange.svg)](https://swift.org)
[![Platform](https://img.shields.io/badge/Platform-iOS%20%7C%20macOS-lightgrey.svg)](https://developer.apple.com)
[![License](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![Stars](https://img.shields.io/github/stars/Rodolfo-Swift-dev/Swift-Analisis-Playgrounds.svg)](https://github.com/Rodolfo-Swift-dev/Swift-Analisis-Playgrounds/stargazers)

> 🎯 Repositorio educativo completo con ejemplos prácticos de Swift, principios SOLID y Clean Code implementados en Xcode Playgrounds.

---

## 📋 Tabla de Contenidos

- [Sobre el Proyecto](#-sobre-el-proyecto)
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
| 16 | **AccesLevel** | Public, private, internal, fileprivate |
| 17 | **Gestión de Errores** | do-try-catch, throws |
| 18 | **Type Casting** | is, as, any, anyobject |
| 19 | **Operador Ternario** | Sintaxis y casos de uso |
| + | **KeywordsSwift** | Palabras clave del lenguaje |
| + | **Content** | Índice general |

### 🔶 SOLID Principles

Implementación práctica de los 5 principios SOLID con ejemplos Swift:

- **S**ingle Responsibility Principle (SRP)
- **O**pen/Closed Principle (OCP)
- **L**iskov Substitution Principle (LSP)
- **I**nterface Segregation Principle (ISP)
- **D**ependency Inversion Principle (DIP)

Cada principio incluye ejemplos **BAD** vs **GOOD** para entender el antes y después.

### 🔷 Clean Code

Mejores prácticas de código limpio aplicadas a Swift:

1. ✅ Nombres significativos
2. ✅ Funciones divididas (Single Responsibility)
3. ✅ Comentarios descriptivos
4. ✅ Manejo de errores apropiado
5. ✅ DRY (Don't Repeat Yourself)
6. ✅ KISS (Keep It Simple, Stupid)

---

## 💻 Requisitos

- **Xcode**: 14.0 o superior
- **Swift**: 5.9+
- **macOS**: Monterey (12.0) o superior

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

### Para Principiantes

1. Comienza con `Swift/0-Basic.playground`
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

Las contribuciones son bienvenidas y apreciadas. Para contribuir:

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
- LinkedIn: [Tu LinkedIn]

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
