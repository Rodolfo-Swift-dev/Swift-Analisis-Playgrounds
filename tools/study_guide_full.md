# Swift: palabras clave, comportamiento y límites

## Cómo usar esta guía

Guía completa basada en los 20 playgrounds numerados de este proyecto.

Cada capítulo responde tres preguntas:

1. ¿Qué palabra clave o sintaxis debo reconocer?
2. ¿Qué comportamiento produce?
3. ¿Cuál es su límite, riesgo o regla?

Los nombres en inglés marcados como **Nomenclatura oficial** corresponden a los términos utilizados por *The Swift Programming Language*. Conviene aprenderlos porque son los que aparecen en la documentación, en los diagnósticos del compilador y en conversaciones técnicas.

## 0. Basic

[Abrir playground](Swift/0-Basic.playground/Contents.swift)

**Objetivo:** reconocer cómo Swift declara datos, infiere tipos, ejecuta operaciones y construye texto.

### Nomenclatura oficial

- **Constants and Variables** — constantes y variables.
- **Type Annotations** — anotaciones de tipo.
- **Type Safety and Type Inference** — seguridad e inferencia de tipos.
- **Numeric Type Conversion** — conversión explícita entre tipos numéricos.
- **String Interpolation** — interpolación de strings.
- **Arithmetic, Comparison and Logical Operators** — operadores aritméticos, de comparación y lógicos.

### Salida y comentarios

- **`print(valor)`**
  - **Comportamiento:** Escribe un valor en la consola.
  - **Límite o cuidado:** Es una salida de depuración; no modifica el valor.

- **`//`**
  - **Comportamiento:** Comenta hasta el final de la línea.
  - **Límite o cuidado:** El compilador ignora ese texto.

- **`/* ... */`**
  - **Comportamiento:** Comenta un bloque.
  - **Límite o cuidado:** Debe cerrarse correctamente.

### Variables, constantes y tipos

- **`let nombre = valor`**
  - **Comportamiento:** Crea una constante.
  - **Límite o cuidado:** No puede recibir otro valor después.

- **`var nombre = valor`**
  - **Comportamiento:** Crea una variable.
  - **Límite o cuidado:** Puede cambiar de valor, pero conserva su tipo.

- **`nombre: Tipo`**
  - **Comportamiento:** Declara el tipo explícitamente.
  - **Límite o cuidado:** El valor asignado debe ser compatible.

- **Inferencia de tipo**
  - **Comportamiento:** Swift deduce el tipo desde el valor inicial.
  - **Límite o cuidado:** Inferir el tipo no significa que pueda cambiar más tarde.

- **`Int`**
  - **Comportamiento:** Representa enteros.
  - **Límite o cuidado:** Una división entre `Int` elimina la parte decimal.

- **`Float`**
  - **Comportamiento:** Representa decimales con menor precisión.
  - **Límite o cuidado:** No se mezcla automáticamente con `Double`.

- **`Double`**
  - **Comportamiento:** Representa decimales con mayor precisión.
  - **Límite o cuidado:** No se convierte implícitamente a `Int`.

- **`String`**
  - **Comportamiento:** Representa texto.
  - **Límite o cuidado:** La concatenación requiere valores compatibles con `String`.

- **`Bool`**
  - **Comportamiento:** Solo puede ser `true` o `false`.
  - **Límite o cuidado:** Swift no trata `0`, `1` o strings como booleanos.

### Operadores

- **`+ - * /`**
  - **Comportamiento:** Ejecutan operaciones aritméticas.
  - **Límite o cuidado:** Los operandos deben admitir la operación.

- **`%`**
  - **Comportamiento:** Obtiene el resto de una división.
  - **Límite o cuidado:** No representa porcentaje.

- **`== != < > <= >=`**
  - **Comportamiento:** Comparan dos valores y producen `Bool`.
  - **Límite o cuidado:** Los tipos deben ser comparables entre sí.

- **`+= -= *= /=`**
  - **Comportamiento:** Opera y reasigna la variable.
  - **Límite o cuidado:** No se puede aplicar a una constante `let`.

- **`&&`**
  - **Comportamiento:** Es verdadero si ambas condiciones son verdaderas.
  - **Límite o cuidado:** Usa cortocircuito: puede no evaluar la segunda condición.

- **`||` — OR lógico**
  - **Comportamiento:** Se escribe con dos barras verticales y acepta una condición verdadera.
  - **Límite o cuidado:** También usa cortocircuito.

- **`!valor`**
  - **Comportamiento:** Invierte un booleano.
  - **Límite o cuidado:** Aquí `!` no significa desempaquetar un opcional; depende del contexto.

### Construcción de texto

- **`"\(valor)"`**
  - **Comportamiento:** Interpola un valor dentro de un `String`.
  - **Límite o cuidado:** La expresión debe ser válida.

- **`textoA + textoB`**
  - **Comportamiento:** Concatena strings.
  - **Límite o cuidado:** Para otros tipos conviene interpolar o convertir.


Claves del capítulo: `print`, `let`, `var`, `Int`, `Float`, `Double`, `String`, `Bool`, operadores e interpolación.

---

## 1. TypeAlias

[Abrir playground](Swift/1-TypeAlias.playground/Contents.swift)

**Objetivo:** usar nombres alternativos para expresar mejor la intención de un tipo sin crear un tipo nuevo.

### Nomenclatura oficial

- **Type Alias** — nombre alternativo para un tipo existente.
- **Type Alias Declaration** — declaración realizada con `typealias`.

### Alias de tipos estándar y personalizados

- **`typealias Celsius = Double`**
  - **Comportamiento:** Da un nombre alternativo a `Double`.
  - **Límite o cuidado:** No crea un tipo nuevo ni evita mezclarlo con otros `Double`.

- **`typealias CharacterName = String`**
  - **Comportamiento:** Expresa mejor el significado de un dato.
  - **Límite o cuidado:** Conserva todas las reglas y operaciones de `String`.

- **`typealias Client = User`**
  - **Comportamiento:** Permite referirse a un tipo propio con otro nombre.
  - **Límite o cuidado:** `Client` y `User` siguen siendo exactamente el mismo tipo.

- **Alias de tipo complejo**
  - **Comportamiento:** Reduce ruido en firmas largas.
  - **Límite o cuidado:** Un nombre poco claro puede ocultar información útil.


Comportamiento esencial:

```swift
typealias Celsius = Double
let temperature: Celsius = 12.2
```

Límite esencial: `typealias` mejora la lectura, pero no agrega validación, identidad ni seguridad de tipo adicional. Para eso se necesita crear un `struct`, `class` o `enum`.

---

## 2. Tuplas

[Abrir playground](Swift/2-Tuplas.playground/Contents.swift)

**Objetivo:** agrupar y descomponer pequeñas cantidades de valores relacionados, incluso cuando tienen tipos diferentes.

### Nomenclatura oficial

- **Tuples** — agrupaciones de varios valores en un único valor compuesto.
- **Tuple Decomposition** — descomposición de una tupla en constantes o variables.
- **Named Tuple Elements** — elementos identificados mediante nombres.
- **Ignoring Parts of a Tuple** — descarte de elementos mediante `_`.
- **Multiple Return Values** — retorno de varios valores desde una función.

### Declaración y acceso

- **`(String, Int, Bool)`**
  - **Comportamiento:** Agrupa valores de tipos distintos y en un orden fijo.
  - **Límite o cuidado:** La cantidad, el orden y los tipos forman parte del tipo de la tupla.

- **`tuple.0`, `tuple.1`**
  - **Comportamiento:** Accede por posición.
  - **Límite o cuidado:** Pierde claridad cuando hay muchos elementos.

- **`(name: String, age: Int)`**
  - **Comportamiento:** Asigna nombres a los elementos.
  - **Límite o cuidado:** Los nombres no convierten la tupla en un tipo nominal reutilizable.

- **`tuple.name`**
  - **Comportamiento:** Accede mediante la etiqueta del elemento.
  - **Límite o cuidado:** La etiqueta debe existir en esa tupla.

### Descomposición

- **`let (name, age) = tuple`**
  - **Comportamiento:** Descompone todos los valores.
  - **Límite o cuidado:** La estructura del patrón debe coincidir con la tupla.

- **`let (name, _) = tuple`**
  - **Comportamiento:** Ignora elementos no necesarios.
  - **Límite o cuidado:** `_` descarta ese valor.

### Composición y retornos

- **`((...), (...))`**
  - **Comportamiento:** Permite anidar tuplas.
  - **Límite o cuidado:** El acceso se vuelve difícil de leer rápidamente.

- **`func f() -> (A, B)`**
  - **Comportamiento:** Retorna varios valores.
  - **Límite o cuidado:** Para modelos grandes o estables es preferible un tipo propio.

- **`(resultado: Int?, error: String?)`**
  - **Comportamiento:** Modela dos resultados relacionados.
  - **Límite o cuidado:** Puede representar estados inválidos; `Result` o errores lanzables son más seguros.


Usos presentes: agrupar datos relacionados, retornar varios valores, descomponer resultados y manejar pequeños grupos temporales.

Límite esencial: una tupla es de tamaño fijo y no es una colección dinámica. Cuando el modelo necesita métodos, validaciones o una identidad clara, se debe preferir `struct`.

---

## 3. Optional

[Abrir playground](Swift/3-Optional.playground/Contents.swift)

**Objetivo:** representar ausencia de valor y elegir una estrategia segura para acceder al dato opcional.

### Nomenclatura oficial

- **Optionals** — valores que pueden contener un dato o `nil`.
- **Optional Binding** — extracción condicional mediante `if let` o `guard let`.
- **Forced Unwrapping** — extracción forzada mediante `!`.
- **Nil-Coalescing Operator** — valor alternativo mediante `??`.
- **Optional Chaining** — acceso condicional mediante `?.`.
- **Implicitly Unwrapped Optional** — opcional declarado como `T!`; no es lo mismo que aplicar `!` a un `T?`.

### Representar ausencia

- **`T?`**
  - **Comportamiento:** Representa `Optional<T>`: puede contener un `T` o `nil`.
  - **Límite o riesgo:** No se puede usar directamente como un `T`.

- **`nil`**
  - **Comportamiento:** Indica ausencia de valor.
  - **Límite o riesgo:** Solo puede asignarse a un opcional.

### Desempaquetado seguro

- **Optional Binding — `if let value = optional`**
  - **Comportamiento:** Desempaqueta si existe un valor.
  - **Límite o riesgo:** `value` vive solamente en el alcance correspondiente.

- **Optional Binding — `guard let value = optional else { return }`**
  - **Comportamiento:** Valida y deja disponible el valor en el resto del scope.
  - **Límite o riesgo:** El bloque `else` debe salir con `return`, `break`, `continue` o `throw`.

### Alternativas y riesgos

- **Forced Unwrapping — `optional!`**
  - **Comportamiento:** Extrae el valor sin comprobarlo.
  - **Límite o riesgo:** Produce un error en ejecución si contiene `nil`.

- **Nil-Coalescing Operator — `optional ?? defaultValue`**
  - **Comportamiento:** Usa el valor o entrega uno predeterminado.
  - **Límite o riesgo:** Ambos lados deben producir tipos compatibles.

- **Optional Chaining — `optional?.member`**
  - **Comportamiento:** Accede al miembro solo si existe el valor.
  - **Límite o riesgo:** Si cualquier paso es `nil`, toda la cadena produce `nil`.

- **`optional != nil`**
  - **Comportamiento:** Solo comprueba existencia.
  - **Límite o riesgo:** Después aún es necesario desempaquetar para usar el valor.

### Operaciones y colecciones

- **`optional.map { ... }`**
  - **Comportamiento:** Transforma el contenido únicamente si existe.
  - **Límite o riesgo:** El resultado continúa siendo opcional.

- **`dictionary[key]`**
  - **Comportamiento:** Busca un valor por clave.
  - **Límite o riesgo:** Siempre devuelve un opcional porque la clave podría no existir.


Flujo seguro recomendado:

```swift
guard let value = optional else {
    return
}
// value ya no es opcional aquí
```

Orden de seguridad:

1. Preferir `if let`, `guard let`, `??` o `?.`.
2. Usar `!` únicamente cuando la existencia del valor esté garantizada por una regla verificable.

---

## 4. Colecciones

[Abrir playground](Swift/4-Colecciones.playground/Contents.swift)

**Objetivo:** seleccionar y operar correctamente con colecciones ordenadas, únicas o basadas en claves.

### Nomenclatura oficial

- **Collection Types** — tipos de colección.
- **Arrays** — colecciones ordenadas.
- **Sets** — colecciones sin duplicados y sin orden definido.
- **Dictionaries** — colecciones de pares clave-valor.
- **Set Operations** — operaciones de conjuntos.
- **Hashable** — requisito que permite identificar valores como claves o elementos de un set.

### `Array<Element>`

- **`[T]` o `Array<T>`**
  - **Comportamiento:** Colección ordenada de elementos del mismo tipo.
  - **Límite o riesgo:** Acepta duplicados.

- **`array[index]`**
  - **Comportamiento:** Lee o modifica por posición.
  - **Límite o riesgo:** Un índice inválido produce error en ejecución.

- **`count`**
  - **Comportamiento:** Entrega la cantidad de elementos.
  - **Límite o riesgo:** No indica si un índice específico es válido sin comprobarlo.

- **`isEmpty`**
  - **Comportamiento:** Indica si no contiene elementos.
  - **Límite o riesgo:** Solo retorna `Bool`.

- **`first`, `last`**
  - **Comportamiento:** Obtiene el primer o último elemento.
  - **Límite o riesgo:** El resultado es opcional.

- **`append(value)`**
  - **Comportamiento:** Agrega al final.
  - **Límite o riesgo:** El valor debe ser del tipo `Element`.

- **`insert(value, at: i)`**
  - **Comportamiento:** Inserta en una posición.
  - **Límite o riesgo:** El índice debe ser válido.

- **`contains(value)`**
  - **Comportamiento:** Comprueba existencia.
  - **Límite o riesgo:** Realiza búsqueda; no entrega el índice.

- **`removeAll()`**
  - **Comportamiento:** Elimina todos los elementos.
  - **Límite o riesgo:** Modifica la colección original.

- **`Array(repeating:count:)`**
  - **Comportamiento:** Repite un valor una cantidad determinada.
  - **Límite o riesgo:** `count` no puede ser negativo.


### `Set<Element>`

- **`Set<T>`**
  - **Comportamiento:** Colección sin orden estable y sin duplicados.
  - **Límite o riesgo:** `T` debe conformar `Hashable`.

- **`insert(value)`**
  - **Comportamiento:** Agrega el valor si no estaba presente.
  - **Límite o riesgo:** No existe `append`; no hay posición final.

- **`contains(value)`**
  - **Comportamiento:** Comprueba pertenencia.
  - **Límite o riesgo:** No entrega una posición porque no usa índices enteros.

- **`first`**
  - **Comportamiento:** Entrega algún elemento.
  - **Límite o riesgo:** Es opcional y no significa “el primero insertado”.

- **`union`**
  - **Comportamiento:** Reúne los valores de ambos sets.
  - **Límite o riesgo:** Elimina duplicados.

- **`intersection`**
  - **Comportamiento:** Conserva valores comunes.
  - **Límite o riesgo:** Puede producir un set vacío.

- **`subtracting`**
  - **Comportamiento:** Conserva valores del primer set que no están en el segundo.
  - **Límite o riesgo:** El orden de los operandos cambia el resultado.

- **`symmetricDifference`**
  - **Comportamiento:** Conserva valores no compartidos.
  - **Límite o riesgo:** Excluye la intersección.

- **`isSubset(of:)`**
  - **Comportamiento:** Comprueba si todos sus elementos están en otro set.
  - **Límite o riesgo:** No comprueba igualdad por sí solo.


### `Dictionary<Key, Value>`

- **`[Key: Value]`**
  - **Comportamiento:** Almacena pares clave-valor.
  - **Límite o riesgo:** `Key` debe conformar `Hashable`.

- **`dict[key]`**
  - **Comportamiento:** Lee o modifica el valor asociado.
  - **Límite o riesgo:** La lectura devuelve `Value?`.

- **`dict[newKey] = value`**
  - **Comportamiento:** Agrega un par.
  - **Límite o riesgo:** Sobrescribe si la clave ya existe.

- **`dict[key] = nil`**
  - **Comportamiento:** Elimina el par.
  - **Límite o riesgo:** Solo actúa si la clave existe.

- **`updateValue(_:forKey:)`**
  - **Comportamiento:** Inserta o actualiza.
  - **Límite o riesgo:** Devuelve opcionalmente el valor anterior.

- **`removeValue(forKey:)`**
  - **Comportamiento:** Elimina por clave.
  - **Límite o riesgo:** Devuelve opcionalmente el valor eliminado.

- **`keys`, `values`**
  - **Comportamiento:** Expone vistas de claves o valores.
  - **Límite o riesgo:** No se debe depender de un orden fijo.


Elección:

- Orden, índices o duplicados → `Array`.
- Unicidad y operaciones de conjuntos → `Set`.
- Acceso mediante una clave → `Dictionary`.

---

## 5. ControlFlow

[Abrir playground](Swift/5-ControlFlow.playground/Contents.swift)

**Objetivo:** decidir qué código se ejecuta, repetir operaciones y abandonar un flujo cuando no se cumplen sus condiciones.

### Nomenclatura oficial

- **Conditional Statements** — sentencias condicionales.
- **If Statement** — sentencia `if`.
- **Switch Statement** — sentencia `switch`.
- **For-In Loops** — ciclos `for-in`.
- **While Loops** — ciclos `while` y `repeat-while`.
- **Early Exit** — salida anticipada mediante `guard`.
- **Where Clause** — condición adicional aplicada a un patrón o iteración.
- **Control Transfer Statements** — `continue`, `break`, `fallthrough`, `return` y `throw`.

### Condiciones

- **`if condición`**
  - **Comportamiento:** Ejecuta un bloque cuando el `Bool` es verdadero.
  - **Límite o regla:** La condición debe ser `Bool`; no admite valores “truthy”.

- **`else if`**
  - **Comportamiento:** Evalúa otra condición si las anteriores fallaron.
  - **Límite o regla:** Solo se ejecuta la primera rama verdadera.

- **`else`**
  - **Comportamiento:** Ejecuta la alternativa final.
  - **Límite o regla:** No lleva condición.

### Salida anticipada

- **`guard condición else`**
  - **Comportamiento:** Exige que la condición sea verdadera para continuar.
  - **Límite o regla:** El `else` debe abandonar el scope.

- **`guard let`**
  - **Comportamiento:** Desempaqueta un opcional y permite usarlo después.
  - **Límite o regla:** Falla y sale cuando el valor es `nil`.

### Selección por casos

- **`switch valor`**
  - **Comportamiento:** Compara un valor con patrones o casos.
  - **Límite o regla:** Debe ser exhaustivo.

- **`case`**
  - **Comportamiento:** Define un patrón aceptado por `switch`.
  - **Límite o regla:** No existe caída implícita al caso siguiente.

- **`default`**
  - **Comportamiento:** Cubre los valores restantes.
  - **Límite o regla:** Puede ocultar nuevos casos de un enum; omitirlo ayuda a detectar cambios.

- **`case ... where condición`**
  - **Comportamiento:** Agrega un filtro al patrón.
  - **Límite o regla:** La condición se evalúa después de coincidir el patrón.

- **`break`**
  - **Comportamiento:** Termina el bloque o ciclo actual.
  - **Límite o regla:** No sale automáticamente de scopes externos.

### Iteración

- **`for value in sequence`**
  - **Comportamiento:** Recorre una secuencia.
  - **Límite o regla:** El orden depende de la colección.

- **`for value in sequence where ...`**
  - **Comportamiento:** Filtra durante el recorrido.
  - **Límite o regla:** No modifica la colección original.

- **`_`**
  - **Comportamiento:** Ignora el elemento actual.
  - **Límite o regla:** El valor no queda disponible dentro del bloque.

### Ciclos condicionales

- **`while condición`**
  - **Comportamiento:** Comprueba y después ejecuta repetidamente.
  - **Límite o regla:** Puede no ejecutarse nunca o producir un bucle infinito.

- **`repeat { ... } while condición`**
  - **Comportamiento:** Ejecuta y después comprueba.
  - **Límite o regla:** Siempre se ejecuta al menos una vez.


Comparación clave:

```text
while        = preguntar → ejecutar
repeat-while = ejecutar → preguntar
```

---

## 6. Funciones

[Abrir playground](Swift/6-Funciones.playground/Contents.swift)

**Objetivo:** definir unidades reutilizables de comportamiento y comprender sus parámetros, etiquetas, firmas y retornos.

### Nomenclatura oficial

- **Defining and Calling Functions** — definición y llamada de funciones.
- **Function Argument Labels and Parameter Names** — etiquetas de argumento y nombres de parámetro.
- **Default Parameter Values** — valores predeterminados.
- **Variadic Parameters** — parámetros variádicos.
- **In-Out Parameters** — parámetros de entrada-salida.
- **Function Types** — tipos o firmas de función.
- **Nested Functions** — funciones anidadas.
- **Overloading** — varias declaraciones con el mismo nombre y firmas distinguibles.

### Declaración, retorno y firma

- **`func nombre(...)`**
  - **Comportamiento:** Declara una función reutilizable.
  - **Límite o regla:** Los tipos de sus parámetros deben estar declarados.

- **`-> ReturnType`**
  - **Comportamiento:** Declara el tipo retornado.
  - **Límite o regla:** Todas las rutas válidas deben retornar ese tipo.

- **`return`**
  - **Comportamiento:** Finaliza la función y entrega un valor.
  - **Límite o regla:** El valor debe coincidir con el retorno declarado.

- **`(Int, Int) -> Int`**
  - **Comportamiento:** Representa el tipo de una función.
  - **Límite o regla:** Los nombres de parámetros no forman parte del tipo.

- **`let operation = function`**
  - **Comportamiento:** Guarda una función como valor.
  - **Límite o regla:** La firma debe ser compatible.

- **`func f() -> (A, B)`**
  - **Comportamiento:** Retorna varios valores mediante una tupla.
  - **Límite o regla:** Para resultados complejos conviene un tipo propio.

### Etiquetas, sobrecarga y valores predeterminados

- **`external internal: T`**
  - **Comportamiento:** Usa un nombre al llamar y otro dentro de la función.
  - **Límite o regla:** El nombre externo forma parte de la llamada.

- **`_ value: T`**
  - **Comportamiento:** Omite la etiqueta externa.
  - **Límite o regla:** Reduce contexto; debe usarse solo si la llamada sigue siendo clara.

- **`parameter: T = value`**
  - **Comportamiento:** Define un valor predeterminado.
  - **Límite o regla:** El argumento puede omitirse, pero su tipo no cambia.

- **Sobrecarga**
  - **Comportamiento:** Permite el mismo nombre con firmas distintas.
  - **Límite o regla:** Las firmas deben poder distinguirse sin ambigüedad.

### Parámetros especiales

- **`values: T...`**
  - **Comportamiento:** Recibe cero o más argumentos como un arreglo.
  - **Límite o regla:** Es un parámetro variádico, no un arreglo enviado directamente.

- **`value: inout T`**
  - **Comportamiento:** Permite modificar el argumento original.
  - **Límite o regla:** La llamada requiere `&` y una variable, no una constante.

- **`&variable`**
  - **Comportamiento:** Entrega acceso modificable a `inout`.
  - **Límite o regla:** Swift aplica reglas de acceso exclusivo para evitar modificaciones simultáneas.

### Alcance

- **Función anidada**
  - **Comportamiento:** Limita una función al scope de otra.
  - **Límite o regla:** No puede llamarse desde fuera del scope contenedor.


Firma que debes saber leer:

```swift
func add(a: Int, b: Int) -> Int
// tipo: (Int, Int) -> Int
```

---

## 7. Clases y estructuras

[Abrir playground](Swift/7-ClasesyEstructuras.playground/Contents.swift)

**Objetivo:** distinguir semántica de valor e identidad compartida para elegir entre `struct` y `class`.

### Nomenclatura oficial

- **Structures and Classes** — estructuras y clases.
- **Instances** — valores concretos creados desde un tipo.
- **Value Types** — tipos con semántica de valor, como `struct` y `enum`.
- **Reference Types** — tipos con identidad y referencias compartidas, como `class`.
- **Identity Operators** — `===` y `!==` para comprobar identidad de clase.
- **Initialization** — proceso que establece el estado inicial.
- **Memberwise Initializers for Structure Types** — inicializador generado para estructuras.
- **Deinitialization** — limpieza de una instancia de clase mediante `deinit`.
- **Subscripts** — accesos con sintaxis `instance[index]`.

### Construcción de tipos

- **`struct`**
  - **Comportamiento:** Crea un tipo con semántica de valor.
  - **Límite o regla:** Una asignación produce un valor independiente.
  - **Regla con `let`:** Una instancia constante no permite modificar sus propiedades variables.

- **`class`**
  - **Comportamiento:** Crea un tipo con semántica de referencia.
  - **Límite o regla:** Varias variables pueden observar y modificar la misma instancia.
  - **Regla con `let`:** La referencia no puede reasignarse, pero sus propiedades `var` sí pueden cambiar.

- **Propiedad**
  - **Comportamiento:** Almacena o calcula estado del tipo.
  - **Límite o regla:** Toda propiedad almacenada debe quedar inicializada.

- **Método**
  - **Comportamiento:** Define comportamiento asociado al tipo.
  - **Límite o regla:** En un `struct`, modificar estado requiere `mutating`.

### Inicialización y ciclo de vida

- **`init`**
  - **Comportamiento:** Establece el estado inicial.
  - **Límite o regla:** No puede finalizar con propiedades almacenadas sin valor.

- **Memberwise init**
  - **Comportamiento:** Swift lo genera para estructuras.
  - **Límite o regla:** Declarar un `init` dentro del `struct` puede ocultar el generado.

- **`convenience init`**
  - **Comportamiento:** Agrega una ruta secundaria de inicialización a una clase.
  - **Límite o regla:** Debe delegar finalmente en un inicializador designado.

- **`deinit`**
  - **Comportamiento:** Se ejecuta antes de liberar una instancia de clase.
  - **Límite o regla:** No existe en estructuras.

- **Subscript**
  - **Comportamiento:** Permite acceso mediante `instancia[indice]`.
  - **Límite o regla:** Debe declarar los tipos de entrada y resultado.

### Capacidades compartidas

- **Herencia**
  - **Comportamiento:** Una clase puede heredar comportamiento de otra.
  - **Límite o regla:** Swift admite una sola superclase; `struct` no hereda de clases.

- **Protocolo**
  - **Comportamiento:** Agrega un contrato por composición.
  - **Límite o regla:** Los requisitos deben implementarse.

- **Extensión**
  - **Comportamiento:** Agrega funcionalidad al tipo.
  - **Límite o regla:** No puede agregar propiedades almacenadas.


### Diferencia de comportamiento

```swift
// struct: copia independiente
var b = a
b.value = 2       // a no cambia

// class: referencia compartida
var b = a
b.value = 2       // a observa el cambio
```

Límite conceptual importante: `struct` no significa “siempre en el stack” y `class` no significa “siempre accesible solo desde el heap”. Swift puede optimizar la memoria. La diferencia que debe guiar el diseño es **valor frente a identidad compartida**.

Elección:

- Datos independientes y modelos simples → `struct`.
- Identidad compartida, herencia u Objective-C → `class`.

---

## 8. Métodos

[Abrir playground](Swift/8-Metodos.playground/Contents.swift)

**Objetivo:** asociar comportamiento a instancias o tipos y controlar cuándo un método puede modificar estado.

### Nomenclatura oficial

- **Instance Methods** — métodos de instancia.
- **The self Property** — referencia a la instancia actual.
- **Modifying Value Types from Within Instance Methods** — modificación mediante `mutating`.
- **Type Methods** — métodos asociados al tipo mediante `static` o `class`.

### Métodos de instancia y mutación

- **Método de instancia**
  - **Comportamiento:** Se ejecuta sobre una instancia concreta.
  - **Límite o regla:** Requiere haber creado la instancia.

- **`self`**
  - **Comportamiento:** Representa la instancia actual.
  - **Límite o regla:** Su escritura suele poder omitirse, salvo cuando es necesaria para desambiguar nombres.

- **`mutating func`**
  - **Comportamiento:** Permite a un método de `struct` cambiar `self` o sus propiedades.
  - **Límite o regla:** La instancia debe estar declarada con `var`.

- **Método de clase normal**
  - **Comportamiento:** Puede modificar propiedades `var` de la instancia.
  - **Límite o regla:** Sigue sujeto al nivel de acceso de esas propiedades.

### Encapsulación

- **`private func`**
  - **Comportamiento:** Oculta el método fuera de su ámbito permitido.
  - **Límite o regla:** No puede llamarse desde código externo.

### Métodos de tipo

- **`static func`**
  - **Comportamiento:** Crea un método del tipo, no de la instancia.
  - **Límite o regla:** No puede sobrescribirse en una subclase.

- **`class func`**
  - **Comportamiento:** Crea un método de tipo sobrescribible en una clase.
  - **Límite o regla:** Solo está disponible en clases.


Comparación:

```text
instance.method() = método de instancia
Type.method()     = método de tipo
```

---

## 9. Propiedades

[Abrir playground](Swift/9-Propiedades.playground/Contents.swift)

**Objetivo:** diferenciar estado almacenado, valores calculados, observación de cambios y reutilización mediante wrappers.

### Nomenclatura oficial

- **Stored Properties** — propiedades almacenadas.
- **Computed Properties** — propiedades computadas.
- **Read-Only Computed Properties** — propiedades computadas de solo lectura.
- **Property Observers** — observadores `willSet` y `didSet`.
- **Property Wrappers** — wrappers declarados con `@propertyWrapper`.
- **Type Properties** — propiedades asociadas al tipo.
- **Wrapped Value** — valor administrado por el wrapper mediante `wrappedValue`.

### Propiedades almacenadas y de tipo

- **Propiedad almacenada**
  - **Comportamiento:** Conserva un valor por instancia.
  - **Límite o regla:** Debe inicializarse antes de terminar `init`.

- **`static var`**
  - **Comportamiento:** Comparte una propiedad en el tipo.
  - **Límite o regla:** No requiere una instancia.

- **`class var`**
  - **Comportamiento:** Propiedad de tipo sobrescribible.
  - **Límite o regla:** Solo en clases y debe ser computada.

### Propiedades computadas

- **Propiedad computada**
  - **Comportamiento:** Calcula el valor al acceder.
  - **Límite o regla:** Se declara con `var`; no almacena su propio valor.

- **`get`**
  - **Comportamiento:** Produce el valor de una propiedad computada.
  - **Límite o regla:** Debe retornar el tipo declarado.

- **`set`**
  - **Comportamiento:** Recibe y procesa un valor nuevo.
  - **Límite o regla:** Solo existe si la propiedad es escribible.

- **`newValue`**
  - **Comportamiento:** Nombre implícito del valor recibido por `set` o `willSet`.
  - **Límite o regla:** Puede reemplazarse por un nombre explícito.

### Observadores

- **`willSet`**
  - **Comportamiento:** Se ejecuta antes de cambiar una propiedad almacenada.
  - **Límite o regla:** No evita el cambio por sí solo.

- **`didSet`**
  - **Comportamiento:** Se ejecuta después del cambio.
  - **Límite o regla:** No se ejecuta durante la inicialización inicial de la propia instancia.

- **`oldValue`**
  - **Comportamiento:** Expone el valor anterior dentro de `didSet`.
  - **Límite o regla:** Solo está disponible en ese observador.

### Property wrappers

- **`@propertyWrapper`**
  - **Comportamiento:** Crea lógica reutilizable alrededor de una propiedad.
  - **Límite o regla:** El wrapper debe proporcionar `wrappedValue`.

- **`wrappedValue`**
  - **Comportamiento:** Define cómo leer y escribir el valor envuelto.
  - **Límite o regla:** Debe coincidir con el tipo esperado por la propiedad.

- **`@Wrapper var value`**
  - **Comportamiento:** Aplica el wrapper a una propiedad.
  - **Límite o regla:** La inicialización debe ser compatible con el wrapper.


Relación:

```text
almacenada = conserva estado
computada  = calcula estado
willSet    = observa antes
didSet     = observa después
wrapper    = reutiliza reglas de lectura/escritura
```

---

## 10. Closures

[Abrir playground](Swift/10-Closures.playground/Contents.swift)

**Objetivo:** tratar bloques de comportamiento como valores, simplificar su sintaxis y controlar captura y ejecución diferida.

### Nomenclatura oficial

- **Closure Expressions** — closures anónimos escritos en línea.
- **Inferring Type From Context** — inferencia de tipos desde el contexto.
- **Implicit Returns from Single-Expression Closures** — retornos implícitos.
- **Shorthand Argument Names** — argumentos abreviados `$0`, `$1`, etc.
- **Operator Methods** — uso de operadores como funciones.
- **Trailing Closures** — closures escritos después de los paréntesis.
- **Capturing Values** — captura de valores del contexto.
- **Closures Are Reference Types** — los closures tienen semántica de referencia.
- **Escaping Closures** — closures marcados con `@escaping`.
- **Autoclosures** — closures creados automáticamente con `@autoclosure`.

### Sintaxis y simplificación

- **`{ (value: T) -> U in ... }`**
  - **Comportamiento:** Crea una función anónima.
  - **Límite o regla:** Su firma debe coincidir con el contexto donde se usa.

- **`in`**
  - **Comportamiento:** Separa firma y cuerpo.
  - **Límite o regla:** Puede omitirse con sintaxis abreviada.

- **`() -> Void`**
  - **Comportamiento:** Closure sin parámetros ni retorno útil.
  - **Límite o regla:** `Void` equivale a `()`.

- **Inferencia**
  - **Comportamiento:** Omite tipos conocidos por el contexto.
  - **Límite o regla:** Sin contexto suficiente, hay que escribirlos.

- **Retorno implícito**
  - **Comportamiento:** Omite `return` en una sola expresión.
  - **Límite o regla:** Con varias sentencias normalmente se necesita `return`.

- **`$0`, `$1`**
  - **Comportamiento:** Nombres abreviados de argumentos.
  - **Límite o regla:** Reducen claridad en closures largos.

- **`sorted(by: >)`**
  - **Comportamiento:** Usa un operador compatible como función.
  - **Límite o regla:** La firma del operador debe coincidir.

### Funciones de orden superior

- **`map(transform)`**
  - **Comportamiento:** Produce una colección transformada.
  - **Límite o regla:** No modifica el arreglo original.

### Trailing closures

- **Trailing closure**
  - **Comportamiento:** Escribe fuera de paréntesis el último argumento closure.
  - **Límite o regla:** Solo aplica cuando el argumento correspondiente es un closure.

- **Múltiples trailing closures**
  - **Comportamiento:** Etiqueta closures adicionales después del primero.
  - **Límite o regla:** Los nombres deben coincidir con los parámetros.

### Retorno y captura de valores

- **Retornar `() -> T`**
  - **Comportamiento:** Una función puede devolver otra función o closure.
  - **Límite o regla:** Para ejecutarlo se necesita invocar el valor retornado.

- **Captura de valores**
  - **Comportamiento:** Conserva acceso a variables del contexto.
  - **Límite o regla:** Puede prolongar la vida del estado capturado.

- **Semántica de referencia**
  - **Comportamiento:** Copias de un closure comparten su estado capturado.
  - **Límite o regla:** Dos variables pueden observar el mismo contador capturado.

### Ejecución diferida

- **`@escaping`**
  - **Comportamiento:** Permite guardar o ejecutar el closure después de terminar la función.
  - **Límite o regla:** Puede requerir `self` explícito y cuidado con ciclos de referencias.

- **`@autoclosure`**
  - **Comportamiento:** Convierte una expresión en un closure sin llaves.
  - **Límite o regla:** Oculta la evaluación diferida; debe usarse con moderación.


Optimización sintáctica mostrada:

```swift
names.sorted(by: { (a: String, b: String) -> Bool in return a > b })
names.sorted { a, b in a > b }
names.sorted { $0 > $1 }
names.sorted(by: >)
```

Ejecución diferida:

```text
closure normal = se entrega código
@escaping      = el código puede sobrevivir a la función
@autoclosure   = una expresión se envuelve automáticamente como código diferido
```

---

## 11. Enum

[Abrir playground](Swift/11-Enum.playground/Contents.swift)

**Objetivo:** modelar un conjunto finito de estados y asociar información o comportamiento a cada caso.

### Nomenclatura oficial

- **Enumeration Syntax** — declaración de un `enum` y sus casos.
- **Matching Enumeration Values with a Switch Statement** — evaluación exhaustiva con `switch`.
- **Associated Values** — datos variables asociados a un caso.
- **Raw Values** — valores fijos asociados a los casos.
- **Implicitly Assigned Raw Values** — raw values asignados automáticamente.
- **CaseIterable** — protocolo que permite obtener `allCases`.
- **Recursive Enumerations** — enums recursivos; requieren `indirect` y no aparecen desarrollados en el playground.

### Declaración y control de flujo

- **`enum Name`**
  - **Comportamiento:** Crea un tipo con un conjunto definido de estados.
  - **Límite o regla:** Solo admite los casos declarados.

- **`case value`**
  - **Comportamiento:** Declara un estado posible.
  - **Límite o regla:** El nombre debe ser único dentro del enum.

- **`.value`**
  - **Comportamiento:** Usa un caso cuando Swift ya conoce el tipo.
  - **Límite o regla:** Sin contexto puede ser necesario escribir `Enum.value`.

- **`switch enumValue`**
  - **Comportamiento:** Ejecuta lógica según el caso.
  - **Límite o regla:** Debe cubrir todos los casos o usar `default`.

- **`break`**
  - **Comportamiento:** Permite un caso sin otra operación.
  - **Límite o regla:** Finaliza solamente ese caso.

- **`default`**
  - **Comportamiento:** Cubre casos restantes.
  - **Límite o regla:** Puede impedir que el compilador avise al agregar un caso nuevo.

### Propiedades y métodos

- **Propiedad computada**
  - **Comportamiento:** Deriva información desde el caso actual.
  - **Límite o regla:** Un enum no admite propiedades almacenadas de instancia.

- **Método de instancia**
  - **Comportamiento:** Ejecuta comportamiento sobre un caso.
  - **Límite o regla:** Accede al caso mediante `self`.

- **`static func`**
  - **Comportamiento:** Agrega comportamiento del tipo.
  - **Límite o regla:** Se llama sobre el enum, no sobre un caso.

### Iteración

- **`CaseIterable`**
  - **Comportamiento:** Sintetiza `allCases`.
  - **Límite o regla:** Solo se sintetiza automáticamente cuando los casos no tienen valores asociados.

### Valores asociados

- **`case field(value: T)`**
  - **Comportamiento:** Agrega valores asociados distintos en cada instancia.
  - **Límite o regla:** El dato debe entregarse al crear ese caso.

- **`case .field(let value)`**
  - **Comportamiento:** Extrae un valor asociado en un patrón.
  - **Límite o regla:** El patrón debe coincidir con la forma del caso.

### Raw values

- **`enum E: String`**
  - **Comportamiento:** Define un tipo común de raw value.
  - **Límite o regla:** Cada caso posee un raw value único.

- **`.rawValue`**
  - **Comportamiento:** Obtiene el valor base del caso.
  - **Límite o regla:** No es lo mismo que un valor asociado.

- **Raw value `Int`**
  - **Comportamiento:** Puede autoincrementar casos posteriores.
  - **Límite o regla:** El incremento parte del valor explícito anterior.


Diferencia:

```text
valor asociado = dato variable entregado al crear el caso
raw value       = dato fijo definido junto al caso
```

Los enums tienen semántica de valor: asignarlos a otra variable crea una copia independiente.

---

## 12. Herencia

[Abrir playground](Swift/12-Herencia.playground/Contents.swift)

**Objetivo:** reutilizar y especializar comportamiento entre clases, respetando inicialización y restricciones de sobrescritura.

### Nomenclatura oficial

- **Base Class** — clase base o superclase.
- **Subclassing** — creación de una subclase.
- **Overriding** — sobrescritura de métodos o propiedades.
- **Accessing Superclass Methods, Properties, and Subscripts** — acceso mediante `super`.
- **Preventing Overrides** — uso de `final` para impedir herencia o sobrescritura.
- **Two-Phase Initialization** — inicialización en dos fases de las clases.

### Jerarquía de clases

- **`class Child: Parent`**
  - **Comportamiento:** Hereda miembros accesibles de una superclase.
  - **Límite o regla:** Una clase solo puede tener una superclase directa.

- **Superclase**
  - **Comportamiento:** Define comportamiento reutilizable.
  - **Límite o regla:** Sus miembros privados no son accesibles directamente en la subclase.

- **Subclase**
  - **Comportamiento:** Agrega o especializa comportamiento.
  - **Límite o regla:** Debe respetar las reglas de inicialización del padre.

### Inicialización y acceso a la superclase

- **`super.init(...)`**
  - **Comportamiento:** Inicializa la parte heredada.
  - **Límite o regla:** Debe llamarse en el orden exigido por la inicialización en dos fases.

- **`super.method()`**
  - **Comportamiento:** Ejecuta la implementación heredada.
  - **Límite o regla:** Solo está disponible dentro de la subclase.

### Sobrescritura

- **`override func`**
  - **Comportamiento:** Reemplaza un método heredado.
  - **Límite o regla:** Solo puede sobrescribir un miembro existente y permitido.

- **`override var`**
  - **Comportamiento:** Reemplaza una propiedad sobrescribible.
  - **Límite o regla:** No puede convertir una propiedad heredada de lectura-escritura en solo lectura.

- **`class func` / `class var`**
  - **Comportamiento:** Permiten sobrescritura de miembros de tipo.
  - **Límite o regla:** Un miembro `static` no se sobrescribe.

### Restricciones con `final`

- **`final class`**
  - **Comportamiento:** Prohíbe crear subclases.
  - **Límite o regla:** Termina la jerarquía de herencia.

- **`final func`**
  - **Comportamiento:** Prohíbe sobrescribir el método.
  - **Límite o regla:** La clase aún puede heredarse si no es `final`.

- **`final var`**
  - **Comportamiento:** Prohíbe sobrescribir la propiedad.
  - **Límite o regla:** La propiedad heredada sigue siendo utilizable.


Jerarquía usada como referencia:

```text
UIButton → UIControl → UIView → UIResponder → NSObject
```

Límite esencial: Swift permite herencia de implementación solo entre clases. Estructuras y enums amplían comportamiento mediante protocolos, composición y extensiones.

---

## 13. Protocolos

[Abrir playground](Swift/13-Protocolos.playground/Contents.swift)

**Objetivo:** definir contratos de comportamiento que distintos tipos puedan adoptar sin compartir una superclase.

### Nomenclatura oficial

- **Protocol Syntax** — declaración y adopción de protocolos.
- **Property Requirements** — requisitos de propiedades.
- **Method Requirements** — requisitos de métodos.
- **Initializer Requirements** — requisitos de inicialización.
- **Protocols as Types** — uso de un protocolo como tipo.
- **Protocol Conformance** — conformidad de un tipo.
- **Protocol Extensions** — implementaciones y funcionalidad compartida.
- **Optional Protocol Requirements** — requisitos opcionales limitados a interoperabilidad `@objc`.

### Declaración y conformidad

- **`protocol Name`**
  - **Comportamiento:** Declara un contrato.
  - **Límite o regla:** No almacena estado de instancia.

- **`Type: Protocol`**
  - **Comportamiento:** Declara conformidad.
  - **Límite o regla:** El tipo debe implementar todos los requisitos obligatorios.

- **`Type: P1, P2`**
  - **Comportamiento:** Adopta varios protocolos.
  - **Límite o regla:** No existe límite de una sola conformidad.

- **`Subclass: Superclass, P1`**
  - **Comportamiento:** Hereda y conforma protocolos.
  - **Límite o regla:** La superclase debe escribirse primero.

### Requisitos

- **`var value: T { get }`**
  - **Comportamiento:** Exige una propiedad legible.
  - **Límite o regla:** La implementación puede ser almacenada o computada.

- **`var value: T { get set }`**
  - **Comportamiento:** Exige lectura y escritura.
  - **Límite o regla:** Una constante o propiedad de solo lectura no cumple.

- **`static var` / `static func`**
  - **Comportamiento:** Exige miembros del tipo.
  - **Límite o regla:** La implementación concreta debe cumplir la firma.

- **`func action()`**
  - **Comportamiento:** Exige un método de instancia.
  - **Límite o regla:** El protocolo declara la firma, no la lógica obligatoria.

- **`init(...)`**
  - **Comportamiento:** Exige un inicializador.
  - **Límite o regla:** Una clase no final normalmente usa `required init`.

### Requisitos opcionales de Objective-C

- **`@objc protocol`**
  - **Comportamiento:** Habilita interoperabilidad con Objective-C.
  - **Límite o regla:** Solo admite tipos representables en Objective-C.

- **`@objc optional`**
  - **Comportamiento:** Hace opcional un requisito Objective-C.
  - **Límite o regla:** Se limita a protocolos `@objc` y tipos de clase compatibles.

### Implementaciones con extensiones

- **`extension Protocol`**
  - **Comportamiento:** Agrega implementación predeterminada.
  - **Límite o regla:** No agrega almacenamiento.

- **`extension ConformingType`**
  - **Comportamiento:** Separa la conformidad de la declaración principal.
  - **Límite o regla:** Debe seguir cumpliendo todos los requisitos.


Tres lugares de implementación:

```text
1. Dentro del tipo
2. En una extensión del tipo
3. Como implementación predeterminada en una extensión del protocolo
```

Resolución esencial:

- Una implementación concreta del tipo tiene prioridad sobre la implementación predeterminada.
- Un método existente solo en la extensión y no declarado como requisito puede usar despacho estático cuando el valor está tipado como protocolo.

---

## 14. Genéricos

[Abrir playground](Swift/14-Genericos.playground/Contents.swift)

**Objetivo:** reutilizar una implementación con múltiples tipos, declarando explícitamente las capacidades que necesita.

### Nomenclatura oficial

- **Generic Functions** — funciones genéricas.
- **Type Parameters** — parámetros de tipo como `T`.
- **Naming Type Parameters** — nombres como `T`, `U`, `Element`, `Key` y `Value`.
- **Generic Types** — clases, estructuras o enums genéricos.
- **Type Constraints** — restricciones de clase o protocolo.
- **Associated Types** — tipos asociados declarados con `associatedtype`.
- **Generic Where Clauses** — requisitos expresados mediante `where`.
- **Concrete Type** — tipo real que sustituye al parámetro genérico.

### Funciones y parámetros genéricos

- **`<T>`**
  - **Comportamiento:** Declara un placeholder de tipo.
  - **Límite o regla:** Cada uso de `T` dentro de esa especialización representa el mismo tipo.

- **`func f<T>(value: T)`**
  - **Comportamiento:** Crea una función genérica.
  - **Límite o regla:** Solo puede realizar operaciones conocidas para cualquier `T`.

- **`<T, U>`**
  - **Comportamiento:** Declara dos tipos independientes.
  - **Límite o regla:** `T` y `U` pueden coincidir, pero no están obligados.

- **`inout T`**
  - **Comportamiento:** Permite modificar un valor genérico original.
  - **Límite o regla:** La llamada requiere una variable con `&`.

### Tipos genéricos

- **`struct Stack<Element>`**
  - **Comportamiento:** Crea un tipo genérico.
  - **Límite o regla:** El tipo concreto queda definido al instanciarlo o inferirlo.

- **`push`**
  - **Comportamiento:** Agrega un elemento al stack.
  - **Límite o regla:** Debe ser compatible con `Element`.

- **`pop`**
  - **Comportamiento:** Retira el último elemento: LIFO.
  - **Límite o regla:** Debe manejarse el caso de stack vacío.

### Restricciones

- **`<T: Protocol>`**
  - **Comportamiento:** Restringe `T` a tipos que conforman un protocolo.
  - **Límite o regla:** Solo esos tipos pueden especializar el genérico.

- **`where T: Protocol`**
  - **Comportamiento:** Expresa restricciones en una cláusula separada.
  - **Límite o regla:** La restricción sigue siendo obligatoria.

- **`AdditiveArithmetic`**
  - **Comportamiento:** Garantiza operaciones aritméticas básicas como `+`.
  - **Límite o regla:** No significa que el tipo sea específicamente `Int` o `Double`.

### Tipos asociados

- **`associatedtype Element`**
  - **Comportamiento:** Declara un tipo pendiente dentro de un protocolo.
  - **Límite o regla:** La conformidad debe resolverlo explícita o implícitamente.

- **Tipo genérico + protocolo**
  - **Comportamiento:** Permite una conformidad para cualquier `Element` válido.
  - **Límite o regla:** Las restricciones del protocolo y del tipo se acumulan.


Problema que resuelven:

```text
función para String  ┐
función para Int     ├─→ una función genérica
función para Double  ┘
```

Límite esencial: un genérico no permite usar cualquier operación sobre `T`. Primero hay que garantizar esa capacidad mediante una restricción de protocolo.

---

## 15. Extensiones

[Abrir playground](Swift/15-Extensiones.playground/Contents.swift)

**Objetivo:** agregar y organizar funcionalidad de tipos existentes sin modificar su declaración original.

### Nomenclatura oficial

- **Extensions** — extensiones de tipos existentes.
- **Computed Properties** — propiedades computadas agregadas por una extensión.
- **Initializers** — inicializadores adicionales.
- **Methods** — métodos de instancia o de tipo agregados.
- **Adding Protocol Conformance with an Extension** — conformidad declarada en una extensión.
- **Protocol Extensions** — funcionalidad compartida por tipos conformes.
- **Extensions with a Generic Where Clause** — extensiones disponibles solo bajo ciertas restricciones.

### Extender tipos

- **`extension Type`**
  - **Comportamiento:** Agrega funcionalidad a un tipo existente.
  - **Límite o regla:** La extensión no tiene nombre propio.

- **Extensión de `String` o `Int`**
  - **Comportamiento:** Agrega métodos a tipos que no controlamos.
  - **Límite o regla:** No modifica el código fuente original.

- **Método de instancia**
  - **Comportamiento:** Queda disponible mediante notación de punto.
  - **Límite o regla:** Respeta los niveles de acceso.

### Miembros e inicializadores

- **`static func`**
  - **Comportamiento:** Agrega un método del tipo.
  - **Límite o regla:** Se invoca sin crear una instancia.

- **Propiedad computada**
  - **Comportamiento:** Agrega un valor derivado.
  - **Límite o regla:** No puede agregar propiedades almacenadas.

- **`init` en extensión**
  - **Comportamiento:** Agrega formas de inicialización.
  - **Límite o regla:** Debe inicializar completamente la instancia.

### Protocolos y conformidad

- **`extension Protocol`**
  - **Comportamiento:** Entrega comportamiento predeterminado.
  - **Límite o regla:** No puede aportar almacenamiento por instancia.

- **`extension Type: Protocol`**
  - **Comportamiento:** Declara y organiza una conformidad.
  - **Límite o regla:** Debe satisfacer todos los requisitos.


Usos:

- Separar responsabilidades.
- Organizar conformidades.
- Agregar métodos a tipos estándar.
- Conservar el memberwise initializer de un `struct` al declarar inicializadores adicionales fuera de su cuerpo principal.

No permiten:

- Agregar propiedades almacenadas.
- Agregar un `deinit`.
- Sobrescribir libremente métodos de una clase como si fueran una subclase.

---

## 16. Access Level

[Abrir playground](Swift/16-AccesLevel.playground/Contents.swift)

**Objetivo:** controlar qué partes del programa pueden ver o utilizar cada declaración.

### Nomenclatura oficial

- **Access Control** — control de visibilidad por declaración, archivo, módulo y paquete.
- **Open Access** — acceso abierto.
- **Public Access** — acceso público.
- **Package Access** — acceso dentro del mismo paquete.
- **Internal Access** — acceso dentro del módulo.
- **File-Private Access** — acceso dentro del archivo.
- **Private Access** — acceso dentro de la declaración y extensiones permitidas.
- **Guiding Principle of Access Levels** — una entidad no puede exponer otra entidad con acceso más restrictivo.

### Niveles de acceso

- **`private`**
  - **Visibilidad:** Declaración y extensiones del mismo tipo dentro del archivo.
  - **Límite principal:** Es el nivel más restrictivo usado en el playground.

- **`fileprivate`**
  - **Visibilidad:** Cualquier código del mismo archivo Swift.
  - **Límite principal:** No cruza a otro archivo.

- **`internal`**
  - **Visibilidad:** Todo el módulo actual.
  - **Límite principal:** Es el nivel predeterminado si no se escribe otro.

- **`package`**
  - **Visibilidad:** Todos los módulos que pertenecen al mismo paquete.
  - **Límite principal:** No es visible desde código situado fuera del paquete.
  - **Origen:** Ampliación desde la documentación actual; no aparece en el playground original.

- **`public`**
  - **Visibilidad:** Otros módulos pueden usar la API.
  - **Límite principal:** Fuera del módulo no pueden crear subclases ni sobrescribir miembros públicos.

- **`open`**
  - **Visibilidad:** Otros módulos pueden usar, heredar y sobrescribir.
  - **Límite principal:** Solo se aplica a clases y miembros de clases.


### Aplicación práctica

- **`private var`:** Oculta una propiedad fuera del ámbito permitido.

- **`private func`:** Impide llamadas externas al método.

- **Tipo privado:** Limita también la exposición posible de sus miembros.

- **API pública + implementación privada:** Expone operaciones seguras y oculta detalles internos.


Regla esencial: una declaración no puede exponer públicamente un tipo que tenga un nivel de acceso más restrictivo.

---

## 17. Gestión de errores

[Abrir playground](Swift/17-Gestion%20de%20errores.playground/Contents.swift)

**Objetivo:** representar, lanzar, propagar y manejar fallos recuperables sin confundirlos con ausencia de valor.

### Nomenclatura oficial

- **Representing and Throwing Errors** — representación y lanzamiento de errores.
- **Throwing Functions** — funciones declaradas con `throws`.
- **Propagating Errors Using Throwing Functions** — propagación hacia el llamador.
- **Handling Errors Using Do-Catch** — manejo mediante `do-catch`.
- **Converting Errors to Optional Values** — conversión a opcional mediante `try?`.
- **Disabling Error Propagation** — afirmación forzada mediante `try!`.
- **Typed Throws** — restricción del error con `throws(ErrorType)`.
- **Cleanup Actions Using Defer** — limpieza garantizada mediante `defer`.

### Representar errores

- **`Error`**
  - **Comportamiento:** Protocolo que identifica tipos utilizables como errores.
  - **Límite o regla:** Conformar no lanza el error automáticamente.

- **`enum MyError: Error`**
  - **Comportamiento:** Agrupa casos de error conocidos.
  - **Límite o regla:** Cada caso debe lanzarse o manejarse explícitamente donde corresponda.

### Lanzar y propagar

- **`throws`**
  - **Comportamiento:** Declara que una función puede propagar un error.
  - **Límite o regla:** No significa que siempre falle; obliga al llamador a reconocer la posibilidad.

- **`throw error`**
  - **Comportamiento:** Interrumpe la ruta actual y lanza un error específico.
  - **Límite o regla:** El valor lanzado debe conformar `Error`.

### Intentar y capturar

- **`try operation()`**
  - **Comportamiento:** Marca una llamada que puede lanzar.
  - **Límite o regla:** Debe usarse dentro de manejo válido o propagarse desde otra función `throws`.

- **`do { ... }`**
  - **Comportamiento:** Define el bloque donde se intenta una operación.
  - **Límite o regla:** No captura nada por sí solo.

- **`catch { ... }`**
  - **Comportamiento:** Captura un error lanzado desde el `do`.
  - **Límite o regla:** Debe cubrir los errores no manejados por catches anteriores.

- **`catch MyError.case`**
  - **Comportamiento:** Maneja un caso específico.
  - **Límite o regla:** El patrón debe corresponder al error recibido.

- **`catch let error`**
  - **Comportamiento:** Captura el error como valor.
  - **Límite o regla:** Si es el catch final, captura cualquier error restante.

### Variantes de `try` y limpieza

- **`try? operation()`**
  - **Comportamiento:** Convierte éxito en valor opcional y fallo en `nil`.
  - **Límite o regla:** Descarta la identidad y detalles del error.

- **`try! operation()`**
  - **Nombre oficial:** Disabling Error Propagation.
  - **Comportamiento:** Afirma que la operación no fallará y extrae su resultado.
  - **Límite o regla:** Produce un error en ejecución si la operación lanza.

- **`throws(MyError)`**
  - **Nombre oficial:** Typed Throws.
  - **Comportamiento:** Declara el tipo concreto de error que puede propagarse.
  - **Límite o regla:** La función no puede lanzar otro tipo de error.

- **`defer { ... }`**
  - **Nombre oficial:** Cleanup Actions.
  - **Comportamiento:** Ejecuta acciones antes de abandonar el scope, exista o no un error.
  - **Límite o regla:** Se ejecuta al salir del scope y no inmediatamente donde se declara.

- **Propagación**
  - **Comportamiento:** Una función `throws` puede dejar que el error suba al llamador.
  - **Límite o regla:** El error debe manejarse en algún nivel del flujo.


Flujo completo:

```text
enum Error          identifica los fallos posibles
throws              declara que una función puede fallar
throw               produce el fallo concreto
try                 intenta ejecutar la función
do                  contiene el intento
catch               recibe y maneja el error
```

Ejemplo integrado:

```swift
enum DatabaseError: Error {
    case userExists
    case invalidName
}

func saveUser(name: String) throws {
    guard !name.isEmpty else {
        throw DatabaseError.invalidName
    }
}

do {
    try saveUser(name: "")
} catch DatabaseError.invalidName {
    print("Nombre inválido")
} catch {
    print("Otro error: \(error)")
}
```

Diferencia fundamental:

```text
try  + do/catch = conserva y maneja el error
try?            = solo entrega valor o nil; pierde el detalle del error
```

---

## 18. Type Casting

[Abrir playground](Swift/18-typeCasting.playground/Contents.swift)

**Objetivo:** comprobar el tipo dinámico de una instancia y recuperar de forma segura un tipo más específico.

### Nomenclatura oficial

- **Type Casting** — comprobación o tratamiento de una instancia como otro tipo compatible.
- **Checking Type / Type-Checking Operator** — comprobación con `is`.
- **Upcasting** — tratamiento de una subclase como su superclase mediante `as`.
- **Downcasting** — intento de recuperar un tipo más específico.
- **Conditional Downcast** — conversión segura mediante `as?`.
- **Forced Downcast** — conversión forzada mediante `as!`.
- **Type Casting for Any and AnyObject** — recuperación de tipos concretos almacenados como `Any` o `AnyObject`.

### Comprobar y convertir tipos

- **`is` — Type-Checking Operator**
  - **Comportamiento:** Comprueba el tipo y retorna `Bool`.
  - **Límite o riesgo:** No convierte ni entrega la instancia tipada.

- **`as` — Upcasting**
  - **Comportamiento:** Trata una subclase como su superclase o convierte de forma garantizada.
  - **Límite o riesgo:** Se pierden temporalmente los miembros exclusivos de la subclase.

- **`as?` — Conditional Downcast**
  - **Comportamiento:** Intenta convertir y devuelve un opcional.
  - **Límite o riesgo:** Debe desempaquetarse; entrega `nil` si falla.

- **`as!` — Forced Downcast**
  - **Comportamiento:** Afirma que la conversión tendrá éxito.
  - **Límite o riesgo:** Produce error en ejecución si el tipo real no coincide.


Patrón seguro:

```swift
if let fish = animal as? Fish {
    fish.respirarBajoAgua()
}
```

Polimorfismo:

```text
[Animal] puede contener Dog, Cat y Bird
          ↓
as? recupera el subtipo concreto
          ↓
permite usar el método específico
```

Reglas:

- `is` pregunta.
- `as` sube hacia un tipo más general.
- `as?` intenta bajar de forma segura.
- `as!` obliga a bajar y puede bloquear la aplicación.
- Type casting cambia la vista tipada de una instancia; no crea otro objeto.

---

## 19. Operador ternario

[Abrir playground](Swift/19-Operador%20ternario.playground/Contents.swift)

**Objetivo:** seleccionar una de dos expresiones cuando la decisión es breve y produce un valor.

### Nomenclatura oficial

- **Ternary Conditional Operator** — operador condicional ternario.
- **Condition** — expresión booleana evaluada.
- **True Expression** — expresión elegida cuando la condición es verdadera.
- **False Expression** — expresión elegida cuando la condición es falsa.

### Sintaxis y decisiones

- **`condition ? A : B`**
  - **Comportamiento:** Evalúa `condition` y ejecuta solo una de las expresiones.
  - **Límite o riesgo:** La condición debe ser `Bool`.

- **`let value = condition ? A : B`**
  - **Comportamiento:** Produce un valor para una asignación.
  - **Límite o riesgo:** `A` y `B` deben tener tipos compatibles.

- **Ternario anidado**
  - **Comportamiento:** Evalúa otra condición dentro de una rama.
  - **Límite o riesgo:** Pierde legibilidad rápidamente.

- **`condition ? action() : ()`**
  - **Comportamiento:** Usa `()` como rama sin acción útil.
  - **Límite o riesgo:** Un `if` suele expresar mejor una acción sin alternativa.

- **Asignaciones en las ramas**
  - **Comportamiento:** Modifica una variable según la condición.
  - **Límite o riesgo:** Los efectos secundarios dentro del ternario son difíciles de leer.


Forma recomendada:

```swift
let status = isConnected ? "Conectado" : "Desconectado"
```

Usar ternario para elegir valores breves. Usar `if-else` para varias instrucciones, ternarios anidados o cambios de estado.

---

## Documentación oficial consultada

- [The Basics](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/thebasics/) — tipos básicos, variables, tuplas y opcionales.
- [Basic Operators](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/basicoperators/) — operadores, fusión nula y ternario.
- [Optional Chaining](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/optionalchaining/) — encadenamiento opcional frente a desempaquetado forzado.
- [Collection Types](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/collectiontypes/) — arrays, sets y diccionarios.
- [Control Flow](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/controlflow/) — condiciones, ciclos, `guard` y `switch`.
- [Functions](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/functions/) — firmas, etiquetas, variádicos e `inout`.
- [Structures and Classes](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/classesandstructures/) — semántica de valor y referencia.
- [Methods](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/methods/) — métodos de instancia, `self`, `mutating` y métodos de tipo.
- [Properties](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/properties/) — propiedades computadas, observadores y wrappers.
- [Closures](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/closures/) — sintaxis, captura, trailing, escaping y autoclosures.
- [Enumerations](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/enumerations/) — casos, valores asociados y raw values.
- [Inheritance](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/inheritance/) — subclases, `override`, `super` y `final`.
- [Protocols](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/protocols/) — requisitos, conformidad y extensiones.
- [Generics](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/generics/) — parámetros de tipo, restricciones, tipos asociados y `where`.
- [Extensions](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/extensions/) — capacidades y límites de las extensiones.
- [Access Control](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/accesscontrol/) — los seis niveles de acceso actuales.
- [Error Handling](https://docs.swift.org/swift-book/LanguageGuide/ErrorHandling.html) — lanzamiento, propagación y manejo de errores.
- [Type Casting](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/typecasting/) — `is`, `as`, downcasting, `Any` y `AnyObject`.
