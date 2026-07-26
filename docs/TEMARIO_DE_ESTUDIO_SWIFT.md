# Swift: guía rápida de estudio

Resumen de los 20 playgrounds del proyecto. Este archivo sirve para repasar palabras clave y reglas esenciales.

La explicación completa, los límites y los ejemplos están en [la guía HTML](TEMARIO_DE_ESTUDIO_SWIFT.html).

## Índice

0. [Basic](#0-basic)
1. [TypeAlias](#1-typealias)
2. [Tuplas](#2-tuplas)
3. [Optional](#3-optional)
4. [Colecciones](#4-colecciones)
5. [ControlFlow](#5-controlflow)
6. [Funciones](#6-funciones)
7. [Clases y estructuras](#7-clases-y-estructuras)
8. [Métodos](#8-métodos)
9. [Propiedades](#9-propiedades)
10. [Closures](#10-closures)
11. [Enum](#11-enum)
12. [Herencia](#12-herencia)
13. [Protocolos](#13-protocolos)
14. [Genéricos](#14-genéricos)
15. [Extensiones](#15-extensiones)
16. [Access Level](#16-access-level)
17. [Gestión de errores](#17-gestión-de-errores)
18. [Type Casting](#18-type-casting)
19. [Operador ternario](#19-operador-ternario)

---

## 0. Basic

**Palabras clave:** `let`, `var`, `Int`, `Float`, `Double`, `String`, `Bool`.

- `let` crea una constante; `var` crea una variable.
- Swift conserva el tipo después de inferirlo o declararlo.
- `Int` representa enteros; `Float` y `Double`, decimales.
- `+ - * / %` son operadores aritméticos.
- `== != < > <= >=` producen un `Bool`.
- `&&`, `||` y `!` combinan o invierten condiciones.
- `"\(value)"` interpola un valor; `+` concatena strings.
- Swift no convierte automáticamente entre tipos numéricos diferentes.

[Playground](Swift/0-Basic.playground/Contents.swift) · [Explicación completa](TEMARIO_DE_ESTUDIO_SWIFT.html#0-basic)

## 1. TypeAlias

**Palabra clave:** `typealias`.

- **Type Alias** da otro nombre a un tipo existente.
- `typealias Celsius = Double` mejora la intención del dato.
- También puede aplicarse a tipos propios o firmas complejas.
- El alias conserva todas las operaciones del tipo original.
- No crea identidad, validación ni seguridad de tipo adicional.
- Para crear un tipo realmente distinto se utiliza `struct`, `class` o `enum`.

[Playground](Swift/1-TypeAlias.playground/Contents.swift) · [Explicación completa](TEMARIO_DE_ESTUDIO_SWIFT.html#1-typealias)

## 2. Tuplas

**Sintaxis clave:** `(A, B)`, `.0`, `.1`, nombres y descomposición.

- **Tuple** agrupa una cantidad fija de valores, incluso de tipos diferentes.
- Se accede por posición: `tuple.0`.
- Puede usar nombres: `(name: String, age: Int)` y `tuple.name`.
- **Tuple Decomposition:** `let (name, age) = tuple`.
- `_` ignora un elemento durante la descomposición.
- Una función puede retornar varios valores mediante una tupla.
- El orden, la cantidad y los tipos forman parte de la tupla.
- Para modelos estables o complejos se prefiere `struct`.

[Playground](Swift/2-Tuplas.playground/Contents.swift) · [Explicación completa](TEMARIO_DE_ESTUDIO_SWIFT.html#2-tuplas)

## 3. Optional

**Palabras clave:** `T?`, `nil`, `if let`, `guard let`, `!`, `??`, `?.`.

- **Optional** representa un valor que puede existir o ser `nil`.
- **Optional Binding:** `if let` y `guard let` extraen el valor de forma segura.
- `guard let` deja el valor disponible después de la validación y debe abandonar el scope si falla.
- **Forced Unwrapping:** `optional!` extrae sin comprobar y falla si contiene `nil`.
- **Nil-Coalescing Operator:** `optional ?? fallback` entrega un valor alternativo.
- **Optional Chaining:** `optional?.member` propaga `nil` si falla algún acceso.
- `dictionary[key]` devuelve un opcional porque la clave puede no existir.
- `T!` es un **Implicitly Unwrapped Optional**; no equivale simplemente a escribir `!` después de un `T?`.

[Playground](Swift/3-Optional.playground/Contents.swift) · [Explicación completa](TEMARIO_DE_ESTUDIO_SWIFT.html#3-optional)

## 4. Colecciones

**Tipos clave:** `Array<Element>`, `Set<Element>`, `Dictionary<Key, Value>`.

- **Array** mantiene orden, acepta duplicados y permite acceso por índice.
- Un índice inválido produce un error en ejecución.
- `first` y `last` son opcionales; `append`, `insert` y `removeAll` modifican el arreglo.
- **Set** mantiene valores únicos, sin orden estable.
- Los elementos de un `Set` deben conformar `Hashable`.
- `union`, `intersection`, `subtracting` y `symmetricDifference` operan entre sets.
- **Dictionary** relaciona claves únicas con valores.
- Sus claves deben conformar `Hashable`.
- `dictionary[key]` devuelve `Value?`; asignar `nil` elimina el par.

[Playground](Swift/4-Colecciones.playground/Contents.swift) · [Explicación completa](TEMARIO_DE_ESTUDIO_SWIFT.html#4-colecciones)

## 5. ControlFlow

**Palabras clave:** `if`, `else`, `guard`, `switch`, `case`, `where`, `for`, `while`, `repeat`.

- `if / else if / else` elige la primera rama cuya condición sea verdadera.
- Swift exige condiciones de tipo `Bool`.
- **Early Exit:** `guard` exige que una condición se cumpla para continuar.
- El `else` de `guard` debe salir mediante `return`, `break`, `continue` o `throw`.
- `switch` compara patrones y debe ser exhaustivo.
- `default` cubre casos restantes, pero puede ocultar nuevos casos de un enum.
- `where` agrega una condición a un caso o una iteración.
- `for-in` recorre secuencias.
- `while` pregunta antes de ejecutar; `repeat-while` ejecuta al menos una vez.

[Playground](Swift/5-ControlFlow.playground/Contents.swift) · [Explicación completa](TEMARIO_DE_ESTUDIO_SWIFT.html#5-controlflow)

## 6. Funciones

**Palabras clave:** `func`, `return`, `->`, `_`, `...`, `inout`, `&`.

- Una función tiene nombre, parámetros y un retorno opcional.
- Su tipo se forma con parámetros y retorno: `(Int, Int) -> Int`.
- **Argument Label** se usa al llamar; **Parameter Name**, dentro de la función.
- `_` elimina una etiqueta externa.
- Un parámetro puede tener un valor predeterminado.
- **Overloading** permite el mismo nombre con firmas distinguibles.
- `T...` declara un **Variadic Parameter**.
- `inout` permite modificar una variable externa; la llamada utiliza `&variable`.
- Una función puede almacenarse, enviarse, retornarse o declararse dentro de otra.

[Playground](Swift/6-Funciones.playground/Contents.swift) · [Explicación completa](TEMARIO_DE_ESTUDIO_SWIFT.html#6-funciones)

## 7. Clases y estructuras

**Palabras clave:** `struct`, `class`, `init`, `deinit`.

- `struct` es un **Value Type**: una asignación produce un valor independiente.
- `class` es un **Reference Type**: varias referencias pueden apuntar a la misma instancia.
- Un `struct` declarado con `let` no puede mutar; en una clase, `let` fija la referencia pero no sus propiedades `var`.
- `===` y `!==` comprueban identidad entre instancias de clase.
- Todas las propiedades almacenadas deben inicializarse.
- Los `struct` reciben un **Memberwise Initializer** cuando corresponde.
- Las clases pueden tener inicializadores designados y `convenience`.
- Solo las clases admiten herencia y `deinit`.
- Elegir entre ambos depende de valor independiente frente a identidad compartida, no de una garantía de stack o heap.

[Playground](Swift/7-ClasesyEstructuras.playground/Contents.swift) · [Explicación completa](TEMARIO_DE_ESTUDIO_SWIFT.html#7-clases-y-estructuras)

## 8. Métodos

**Palabras clave:** `self`, `mutating`, `static`, `class`, `private`.

- **Instance Method** se ejecuta sobre una instancia.
- `self` representa la instancia actual.
- Un método de `struct` necesita `mutating` para cambiar estado.
- La instancia del `struct` debe estar declarada con `var`.
- `private func` oculta una operación fuera de su ámbito permitido.
- `static func` pertenece al tipo y no puede sobrescribirse.
- `class func` pertenece a una clase y admite `override`.

[Playground](Swift/8-Metodos.playground/Contents.swift) · [Explicación completa](TEMARIO_DE_ESTUDIO_SWIFT.html#8-metodos)

## 9. Propiedades

**Palabras clave:** `static`, `class`, `get`, `set`, `willSet`, `didSet`, `@propertyWrapper`.

- **Stored Property** conserva estado.
- **Computed Property** calcula un valor y se declara con `var`.
- `get` produce el valor; `set` procesa una asignación.
- **Type Property** pertenece al tipo: normalmente utiliza `static`.
- `class var` permite sobrescritura en clases y debe ser computada.
- `willSet` se ejecuta antes del cambio; `didSet`, después.
- `newValue` representa el valor entrante; `oldValue`, el anterior.
- **Property Wrapper** reutiliza reglas de almacenamiento mediante `wrappedValue`.

[Playground](Swift/9-Propiedades.playground/Contents.swift) · [Explicación completa](TEMARIO_DE_ESTUDIO_SWIFT.html#9-propiedades)

## 10. Closures

**Palabras clave:** `in`, `$0`, trailing closure, `@escaping`, `@autoclosure`.

- **Closure Expression** es un bloque de comportamiento sin nombre.
- Swift puede inferir parámetros y retorno desde el contexto.
- Una sola expresión permite retorno implícito.
- `$0`, `$1` son **Shorthand Argument Names**.
- **Trailing Closure** escribe el último argumento closure fuera de los paréntesis.
- Un closure puede capturar valores de su contexto.
- Los closures tienen semántica de referencia respecto de su estado capturado.
- `@escaping` permite ejecutar o guardar el closure después de terminar la función.
- `@autoclosure` envuelve una expresión y retrasa su evaluación.

[Playground](Swift/10-Closures.playground/Contents.swift) · [Explicación completa](TEMARIO_DE_ESTUDIO_SWIFT.html#10-closures)

## 11. Enum

**Palabras clave:** `enum`, `case`, `switch`, `CaseIterable`, `rawValue`, `indirect`.

- Un enum modela un conjunto finito de estados.
- `switch` puede comprobar exhaustivamente todos sus casos.
- Los enums tienen semántica de valor.
- Pueden incluir propiedades computadas y métodos.
- `CaseIterable` permite obtener `allCases` cuando puede sintetizarse.
- **Associated Value** es un dato variable entregado al crear el caso.
- **Raw Value** es un dato fijo definido junto al caso.
- Los raw values enteros pueden asignarse incrementalmente.
- Un enum recursivo utiliza `indirect`.

[Playground](Swift/11-Enum.playground/Contents.swift) · [Explicación completa](TEMARIO_DE_ESTUDIO_SWIFT.html#11-enum)

## 12. Herencia

**Palabras clave:** `super`, `override`, `final`.

- Una subclase hereda miembros accesibles de una superclase.
- Swift permite una sola superclase directa.
- `super.init` inicializa la parte heredada.
- `super.member` accede a la implementación de la superclase.
- `override` sustituye un método o propiedad heredada.
- `class` permite sobrescribir miembros de tipo; `static` no.
- `final class` impide herencia.
- `final func` y `final var` impiden sobrescritura.
- Solo las clases participan en herencia de implementación.

[Playground](Swift/12-Herencia.playground/Contents.swift) · [Explicación completa](TEMARIO_DE_ESTUDIO_SWIFT.html#12-herencia)

## 13. Protocolos

**Palabras clave:** `protocol`, `{ get }`, `{ get set }`, conformidad y extensiones.

- Un protocolo declara un contrato sin almacenar estado de instancia.
- Un tipo puede conformar varios protocolos.
- `{ get }` exige lectura; `{ get set }`, lectura y escritura.
- Los requisitos de métodos declaran firma, no implementación.
- Un protocolo puede exigir un `init`.
- Una clase no final normalmente implementa ese requisito con `required init`.
- **Protocol Extension** entrega comportamiento compartido.
- La implementación concreta del tipo tiene prioridad sobre la predeterminada.
- `@objc optional` solo sirve en protocolos compatibles con Objective-C.

[Playground](Swift/13-Protocolos.playground/Contents.swift) · [Explicación completa](TEMARIO_DE_ESTUDIO_SWIFT.html#13-protocolos)

## 14. Genéricos

**Palabras clave:** `<T>`, `where`, `associatedtype`.

- Un parámetro de tipo permite reutilizar código con diferentes tipos concretos.
- Usar el mismo `T` exige el mismo tipo en esas posiciones.
- `<T, U>` declara tipos independientes.
- **Generic Type** aplica el mismo principio a `struct`, `class` o `enum`.
- **Type Constraint:** `<T: Protocol>` exige una capacidad.
- **Generic Where Clause** expresa restricciones más complejas.
- `associatedtype` deja que una conformidad resuelva un tipo relacionado.
- Un genérico solo puede usar operaciones garantizadas por sus restricciones.
- `Array`, `Set` y `Dictionary` son tipos genéricos.

[Playground](Swift/14-Genericos.playground/Contents.swift) · [Explicación completa](TEMARIO_DE_ESTUDIO_SWIFT.html#14-genericos)

## 15. Extensiones

**Palabra clave:** `extension`.

- Una extensión agrega funcionalidad a un tipo existente.
- Puede agregar métodos de instancia y de tipo.
- Puede agregar propiedades computadas.
- Puede agregar inicializadores bajo las reglas del tipo.
- No puede agregar propiedades almacenadas ni `deinit`.
- `extension Type: Protocol` organiza una conformidad.
- **Protocol Extension** comparte implementaciones predeterminadas.
- Una cláusula `where` puede limitar cuándo está disponible la extensión.

[Playground](Swift/15-Extensiones.playground/Contents.swift) · [Explicación completa](TEMARIO_DE_ESTUDIO_SWIFT.html#15-extensiones)

## 16. Access Level

**Palabras clave:** `private`, `fileprivate`, `internal`, `package`, `public`, `open`.

- `private`: declaración y extensiones permitidas del mismo tipo.
- `fileprivate`: mismo archivo.
- `internal`: mismo módulo; es el nivel habitual predeterminado.
- `package`: módulos del mismo paquete.
- `public`: uso desde otros módulos.
- `open`: además permite herencia y sobrescritura desde otros módulos.
- `open` solo se aplica a clases y miembros de clases.
- Una API no puede exponer un tipo con acceso más restrictivo.

[Playground](Swift/16-AccesLevel.playground/Contents.swift) · [Explicación completa](TEMARIO_DE_ESTUDIO_SWIFT.html#16-access-level)

## 17. Gestión de errores

**Palabras clave:** `Error`, `throws`, `throw`, `try`, `do`, `catch`, `try?`, `try!`, `defer`.

- Un tipo de error conforma el protocolo `Error`.
- **Throwing Function:** `throws` declara que una función puede propagar errores.
- `throw error` interrumpe la ruta actual con un error concreto.
- `try` reconoce que una operación puede fallar.
- **Do-Catch:** `do` ejecuta; `catch` encuentra y maneja el error.
- `try?` convierte éxito en valor y error en `nil`, perdiendo el detalle.
- `try!` afirma que no habrá error y falla en ejecución si lo hay.
- **Typed Throws:** `throws(MyError)` restringe el tipo de error propagado.
- `defer` ejecuta limpieza antes de abandonar el scope.

[Playground](Swift/17-Gestion%20de%20errores.playground/Contents.swift) · [Explicación completa](TEMARIO_DE_ESTUDIO_SWIFT.html#17-gestion-de-errores)

## 18. Type Casting

**Operadores clave:** `is`, `as`, `as?`, `as!`.

- **Type-Checking Operator:** `is` pregunta por el tipo y devuelve `Bool`.
- **Upcasting:** `as` trata una subclase como una superclase.
- **Downcasting** recupera un tipo más específico.
- **Conditional Downcast:** `as?` devuelve el tipo convertido o `nil`.
- **Forced Downcast:** `as!` falla en ejecución si la conversión no es válida.
- El patrón seguro es `if let value = instance as? Type`.
- Type casting no crea otro objeto; cambia la información de tipo disponible.
- Los valores guardados como `Any` necesitan convertirse para recuperar su interfaz concreta.

[Playground](Swift/18-typeCasting.playground/Contents.swift) · [Explicación completa](TEMARIO_DE_ESTUDIO_SWIFT.html#18-type-casting)

## 19. Operador ternario

**Sintaxis:** `condition ? trueExpression : falseExpression`.

- **Ternary Conditional Operator** selecciona una de dos expresiones.
- La condición debe ser `Bool`.
- Ambas ramas deben producir tipos compatibles.
- Solo se evalúa la rama seleccionada.
- Es apropiado para elegir valores breves.
- Los ternarios anidados y los efectos secundarios reducen claridad.
- Cuando una rama no hace nada o contiene varias instrucciones, se prefiere `if`.

[Playground](Swift/19-Operador%20ternario.playground/Contents.swift) · [Explicación completa](TEMARIO_DE_ESTUDIO_SWIFT.html#19-operador-ternario)

---

## Documentación oficial

- [The Swift Programming Language](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/)
- [The Basics](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/thebasics/)
- [Functions](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/functions/)
- [Closures](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/closures/)
- [Protocols](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/protocols/)
- [Generics](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/generics/)
- [Error Handling](https://docs.swift.org/swift-book/LanguageGuide/ErrorHandling.html)
- [Type Casting](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/typecasting/)
