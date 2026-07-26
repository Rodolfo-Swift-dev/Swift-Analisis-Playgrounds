# Swift: keywords, behavior and limits

## How to use this guide

Complete guide based on the 20 numbered playgrounds of this project.

Each chapter answers three questions:

1. What keyword or syntax should I recognize?
2. What behavior does it produce?
3. What is your limit, risk or rule?

English names marked as **Official nomenclature** correspond to the terms used by *The Swift Programming Language*. It is advisable to learn them because they are the ones that appear in the documentation, in the compiler diagnostics and in technical conversations.

## 0. Basic

[Open playground](Swift/0-Basic.playground/Contents.swift)

**Objective:** recognize how Swift declares data, infers types, performs operations, and constructs text.

### Official nomenclature

- **Constants and Variables** — constants and variables.
- **Type Annotations** — type annotations.
- **Type Safety and Type Inference** — type safety and inference.
- **Numeric Type Conversion** — explicit conversion between numeric types.
- **String Interpolation** — string interpolation.
- **Arithmetic, Comparison and Logical Operators** — arithmetic, comparison and logical operators.

### Output and comments

- **`print(valor)`**
  - **Behavior:** Write a value to the console.
  - **Limit or caution:** It is a debug output; does not modify the value.

- **`//`**
  - **Behavior:** Comment until the end of the line.
  - **Limit or caution:** The compiler ignores that text.

- **`/* ... */`**
  - **Behavior:** Comment a block.
  - **Limit or caution:** It must close correctly.

### Variables, constants and types

- **`let nombre = valor`**
  - **Behavior:** Create a constant.
  - **Limit or caution:** It cannot receive another value afterwards.

- **`var nombre = valor`**
  - **Behavior:** Create a variable.
  - **Limit or caution:** It can change value, but retains its type.

- **`nombre: Tipo`**
  - **Behavior:** Declare the type explicitly.
  - **Limit or caution:** The assigned value must be compatible.

- **Type inference**
  - **Behavior:** Swift infers the type from the initial value.
  - **Limit or caution:** Inferring the type does not mean it can change later.

- **`Int`**
  - **Behavior:** Represents integers.
  - **Limit or caution:** A division between `Int` remove the decimal part.

- **`Float`**
  - **Behavior:** Represents decimals with lower precision.
  - **Limit or caution:** Does not automatically mix with `Double`.

- **`Double`**
  - **Behavior:** Represents decimals more accurately.
  - **Limit or caution:** It is not implicitly converted to `Int`.

- **`String`**
  - **Behavior:** Represents text.
  - **Limit or caution:** Concatenation requires values compatible with `String`.

- **`Bool`**
  - **Behavior:** It can only be `true` or `false`.
  - **Limit or caution:** Swift does not try `0`, `1` or strings as booleans.

### Operators

- **`+ - * /`**
  - **Behavior:** They perform arithmetic operations.
  - **Limit or caution:** The operands must support the operation.

- **`%`**
  - **Behavior:** Gets the remainder of a division.
  - **Limit or caution:** It does not represent a percentage.

- **`== != < > <= >=`**
  - **Behavior:** They compare two values and produce `Bool`.
  - **Limit or caution:** The types must be comparable to each other.

- **`+= -= *= /=`**
  - **Behavior:** Operate and reassign the variable.
  - **Limit or caution:** Cannot be applied to a constant `let`.

- **`&&`**
  - **Behavior:** It is true if both conditions are true.
  - **Limit or caution:** Use short circuit: may not evaluate the second condition.

- **`||` — logical OR**
  - **Behavior:** It is written with two vertical bars and accepts a true condition.
  - **Limit or caution:** It also uses short circuit.

- **`!valor`**
  - **Behavior:** Inverts a boolean.
  - **Limit or caution:** Here `!` does not mean unwrapping an optional; its meaning depends on context.

### Text construction

- **`"\(valor)"`**
  - **Behavior:** Interpolates a value within a `String`.
  - **Limit or caution:** The expression must be valid.

- **`textoA + textoB`**
  - **Behavior:** Concatenate strings.
  - **Limit or caution:** For other types it is convenient to interpolate or convert.


Keys to the chapter: `print`, `let`, `var`, `Int`, `Float`, `Double`, `String`, `Bool`, operators and interpolation.

### Common mistake

- Expecting implicit numeric conversions or confusing integer division with decimal division. Swift requires compatible types: `5 / 2` produces `2`, while `5.0 / 2.0` produces `2.5`.

---

## 1. TypeAlias

[Open playground](Swift/1-TypeAlias.playground/Contents.swift)

**Objective:** use alternative names to better express the intent of a type without creating a new type.

### Official nomenclature

- **Type Alias** — alternative name for an existing type.
- **Type Alias Declaration** — statement made with `typealias`.

### Standard and custom type aliases

- **`typealias Celsius = Double`**
  - **Behavior:** Give an alternative name to `Double`.
  - **Limit or caution:** It does not create a new type or avoid mixing it with others `Double`.

- **`typealias CharacterName = String`**
  - **Behavior:** Better expresses the meaning of a data.
  - **Limit or caution:** Maintain all rules and operations `String`.

- **`typealias Client = User`**
  - **Behavior:** Allows you to refer to your own type with another name.
  - **Limit or caution:** `Client` and `User` are still exactly the same type.

- **Complex type aliases**
  - **Behavior:** Reduces noise in long signatures.
  - **Limit or caution:** An unclear name can hide useful information.


Essential behavior:

```swift
typealias Celsius = Double
let temperature: Celsius = 12.2
```

Essential limit: `typealias` improves readability, but does not add additional validation, identity, or type safety. For this you need to create a `struct`, `class` or `enum`.

### Common mistake

- Believing that `typealias` creates a distinct type. `typealias UserID = String` only adds another name: a `UserID` still accepts any `String`.

---

## 2. Tuples

[Open playground](Swift/2-Tuplas.playground/Contents.swift)

**Objective:** group and decompose small amounts of related values, even when they have different types.

### Official nomenclature

- **Tuples** — groupings of several values into a single composite value.
- **Tuple Decomposition** — decomposition of a tuple into constants or variables.
- **Named Tuple Elements** — elements identified by names.
- **Ignoring Parts of a Tuple** — discarding elements by `_`.
- **Multiple Return Values** — return multiple values from a function.

### Declaration and access

- **`(String, Int, Bool)`**
  - **Behavior:** Groups values of different types and in a fixed order.
  - **Limit or caution:** The quantity, order, and types are part of the type of the tuple.

- **`tuple.0`, `tuple.1`**
  - **Behavior:** Access by position.
  - **Limit or caution:** Loses clarity when there are many elements.

- **`(name: String, age: Int)`**
  - **Behavior:** Assign names to elements.
  - **Limit or caution:** Names do not convert the tuple to a reusable nominal type.

- **`tuple.name`**
  - **Behavior:** Access through the element label.
  - **Limit or caution:** The tag must exist in that tuple.

### Decomposition

- **`let (name, age) = tuple`**
  - **Behavior:** Decomposes all values.
  - **Limit or caution:** The pattern structure must match the tuple.

- **`let (name, _) = tuple`**
  - **Behavior:** Ignore unnecessary elements.
  - **Limit or caution:** `_` discard that value.

### Composition and returns

- **`((...), (...))`**
  - **Behavior:** Allows nesting tuples.
  - **Limit or caution:** Access becomes difficult to read quickly.

- **`func f() -> (A, B)`**
  - **Behavior:** Returns several values.
  - **Limit or caution:** For large or stable models, a separate type is preferable.

- **`(resultado: Int?, error: String?)`**
  - **Behavior:** Model two related outcomes.
  - **Limit or caution:** May represent invalid states; `Result` or throwable errors are safer.


Present uses: group related data, return multiple values, decompose results and handle small temporary groups.

Essential limit: a tuple is of fixed size and is not a dynamic collection. When the model needs methods, validations or a clear identity, it should be preferred `struct`.

### Common mistake

- Treating a tuple as though it conformed to `Sequence` or were a collection. Operations such as `sorted()` cannot be applied directly; a pair of optionals for success and failure can also represent invalid states.

---

## 3. Optional

[Open playground](Swift/3-Optional.playground/Contents.swift)

**Objective:** represent absence of value and choose a safe strategy for accessing optional data.

### Official nomenclature

- **Optionals** — values that may contain a piece of data or `nil`.
- **Optional Binding** — conditional extraction using `if let` or `guard let`.
- **Forced Unwrapping** — forced extraction through `!`.
- **Nil-Coalescing Operator** — alternative value using `??`.
- **Optional Chaining** — conditional access via `?.`.
- **Implicitly Unwrapped Optional** — an optional declared as `T!`; it is not the same as applying `!` to a `T?`.

### Representing absence

- **`T?`**
  - **Behavior:** Represents `Optional<T>`: may contain a `T` or `nil`.
  - **Limit or risk:** It cannot be used directly as a `T`.

- **`nil`**
  - **Behavior:** Indicates absence of value.
  - **Limit or risk:** It can only be assigned to an optional.

### Safe unpacking

- **Optional Binding `if let value = optional`**
  - **Behavior:** Unpack if a value exists.
  - **Limit or risk:** `value` lives only in the corresponding scope.

- **Optional Binding `guard let value = optional else { return }`**
  - **Behavior:** Validates and makes the value available in the rest of the scope.
  - **Limit or risk:** The `else` block must exit with `return`, `break`, `continue`, or `throw`.

### Alternatives and risks

- **Forced Unwrapping `optional!`**
  - **Behavior:** Extract the value without checking it.
  - **Limit or risk:** Produces an error during execution if it contains `nil`.

- **Nil-Coalescing Operator — `optional ?? defaultValue`**
  - **Behavior:** Use the value or supply a default one.
  - **Limit or risk:** Both sides must produce compatible types.

- **Optional Chaining `optional?.member`**
  - **Behavior:** Accesses the member only if the value exists.
  - **Limit or risk:** If any step is `nil`, the entire chain produces `nil`.

- **`optional != nil`**
  - **Behavior:** It only checks for existence.
  - **Limit or risk:** Afterwards you still need to unpack to use the value.

### Operations and collections

- **`optional.map { ... }`**
  - **Behavior:** Transform the content only if it exists.
  - **Limit or risk:** The result remains optional.

- **`dictionary[key]`**
  - **Behavior:** Search for a value by key.
  - **Limit or risk:** It always returns an optional because the key might not exist.


Recommended safe flow:

```swift
guard let value = optional else {
    return
}
// value ya no es opcional aquí
```

Safety order:

1. prefer `if let`, `guard let`, `??` or `?.`.
2. Use `!` only when the existence of the value is guaranteed by a verifiable rule.

### Common mistake

- Force-unwrapping with `!` without a verifiable guarantee. If the value is `nil`, the program traps at runtime; a fallback with `??` should not silently hide a missing required value either.

---

## 4. Collections

[Open playground](Swift/4-Colecciones.playground/Contents.swift)

**Objective:** select and operate correctly with ordered, unique or key-based collections.

### Official nomenclature

- **Collection Types** — collection types.
- **Arrays** — ordered collections.
- **sets** — collections without duplicates and without defined order.
- **Dictionaries** — collections of key-value pairs.
- **Set Operations** — set operations.
- **Hashable** — requirement that allows values to be identified as keys or elements of a set.

### `Array<Element>`

- **`[T]` or `Array<T>`**
  - **Behavior:** Ordered collection of elements of the same type.
  - **Limit or risk:** Accept duplicates.

- **`array[index]`**
  - **Behavior:** Read or modify by position.
  - **Limit or risk:** An invalid index causes an error during execution.

- **`count`**
  - **Behavior:** Provide the number of elements.
  - **Limit or risk:** It does not indicate whether a specific index is valid without checking it.

- **`isEmpty`**
  - **Behavior:** Indicates if it contains no elements.
  - **Limit or risk:** Just come back `Bool`.

- **`first`, `last`**
  - **Behavior:** Gets the first or last element.
  - **Limit or risk:** The result is optional.

- **`append(value)`**
  - **Behavior:** Add at the end.
  - **Limit or risk:** The value must be of type `Element`.

- **`insert(value, at: i)`**
  - **Behavior:** Inserts into a position.
  - **Limit or risk:** The index must be valid.

- **`contains(value)`**
  - **Behavior:** Check existence.
  - **Limit or risk:** Perform search; does not provide the index.

- **`removeAll()`**
  - **Behavior:** Delete all elements.
  - **Limit or risk:** Modify the original collection.

- **`Array(repeating:count:)`**
  - **Behavior:** Repeats a value a certain amount.
  - **Limit or risk:** `count` cannot be negative.


### `Set<Element>`

- **`Set<T>`**
  - **Behavior:** Collection without stable order and without duplicates.
  - **Limit or risk:** `T` must conform `Hashable`.

- **`insert(value)`**
  - **Behavior:** Add the value if it was not present.
  - **Limit or risk:** Does not exist `append`; there is no final position.

- **`contains(value)`**
  - **Behavior:** Check membership.
  - **Limit or risk:** It does not deliver a position because it does not use integer indices.

- **`first`**
  - **Behavior:** Deliver some item.
  - **Limit or risk:** It is optional and does not mean “the first inserted”.

- **`union`**
  - **Behavior:** Gather the values of both sets.
  - **Limit or risk:** Eliminate duplicates.

- **`intersection`**
  - **Behavior:** Preserve common values.
  - **Limit or risk:** May produce an empty set.

- **`subtracting`**
  - **Behavior:** Preserves values from the first set that are not in the second.
  - **Limit or risk:** The order of the operands changes the result.

- **`symmetricDifference`**
  - **Behavior:** Preserves unshared values.
  - **Limit or risk:** Excludes the intersection.

- **`isSubset(of:)`**
  - **Behavior:** Check if all its elements are in another set.
  - **Limit or risk:** It does not check equality on its own.


### `Dictionary<Key, Value>`

- **`[Key: Value]`**
  - **Behavior:** Stores key-value pairs.
  - **Limit or risk:** `Key` must conform `Hashable`.

- **`dict[key]`**
  - **Behavior:** Read or modify the associated value.
  - **Limit or risk:** Reading returns `Value?`.

- **`dict[newKey] = value`**
  - **Behavior:** Add a couple.
  - **Limit or risk:** Overwrites if the key already exists.

- **`dict[key] = nil`**
  - **Behavior:** Eliminate the pair.
  - **Limit or risk:** It only acts if the key exists.

- **`updateValue(_:forKey:)`**
  - **Behavior:** Insert or update.
  - **Limit or risk:** Optionally returns the previous value.

- **`removeValue(forKey:)`**
  - **Behavior:** Delete by key.
  - **Limit or risk:** Optionally returns the removed value.

- **`keys`, `values`**
  - **Behavior:** Exposes views of keys or values.
  - **Limit or risk:** You should not depend on a fixed order.


Choice:

- Order, indexes or duplicates → `Array`.
- Uniqueness and set operations → `Set`.
- Password access → `Dictionary`.

### Common mistake

- Using indexes, `first!`, or `removeFirst()` without checking that the collection contains elements. Depending on a `Set` iteration order is also incorrect because that order is not stable.

---

## 5. ControlFlow

[Open playground](Swift/5-ControlFlow.playground/Contents.swift)

**Objective:** deciding what code is executed, repeating operations, and abandoning a flow when its conditions are not met.

### Official nomenclature

- **Conditional Statements** — conditional sentences.
- **If Statement** — sentence `if`.
- **Switch Statement** — sentence `switch`.
- **For-In Loops** — cycles `for-in`.
- **While Loops** — cycles `while` and `repeat-while`.
- **Early Exit** — early departure via `guard`.
- **Where Clause** — additional condition applied to a pattern or iteration.
- **Control Transfer Statements** — `continue`, `break`, `fallthrough`, `return` and `throw`.

### Conditions

- **`if condición`**
  - **Behavior:** Executes a block when the `Bool` is true.
  - **Limit or rule:** The condition must be `Bool`; Swift does not support “truthy” values.

- **`else if`**
  - **Behavior:** Evaluate another condition if the previous ones failed.
  - **Limit or rule:** Only the first true branch is executed.

- **`else`**
  - **Behavior:** Run the final alternative.
  - **Limit or rule:** It has no condition.

### Early exit

- **`guard condición else`**
  - **Behavior:** Requires the condition to be true to continue.
  - **Limit or rule:** The `else` must leave the scope.

- **`guard let`**
  - **Behavior:** Unpack an optional and allow it to be used later.
  - **Limit or rule:** Fails and exits when the value is `nil`.

### Selection by cases

- **`switch valor`**
  - **Behavior:** Compare a value with patterns or cases.
  - **Limit or rule:** It must be exhaustive.

- **`case`**
  - **Behavior:** Defines a pattern accepted by `switch`.
  - **Limit or rule:** There is no implicit fall to the following case.

- **`default`**
  - **Behavior:** Cover the remaining values.
  - **Limit or rule:** You can hide new instances of an enum; Skipping it helps detect changes.

- **`case ... where condición`**
  - **Behavior:** Add a filter to the pattern.
  - **Limit or rule:** The condition is evaluated after the pattern is matched.

- **`break`**
  - **Behavior:** Ends the current block or cycle.
  - **Limit or rule:** It does not automatically exit external scopes.

### Iteration

- **`for value in sequence`**
  - **Behavior:** Go through a sequence.
  - **Limit or rule:** The order depends on the collection.

- **`for value in sequence where ...`**
  - **Behavior:** Filter during the tour.
  - **Limit or rule:** It does not modify the original collection.

- **`_`**
  - **Behavior:** Ignores the current element.
  - **Limit or rule:** The value is not available within the block.

### Conditional loops

- **`while condición`**
  - **Behavior:** Check and then run repeatedly.
  - **Limit or rule:** It may never run or produce an infinite loop.

- **`repeat { ... } while condición`**
  - **Behavior:** Run and then check.
  - **Limit or rule:** It is always executed at least once.


Key comparison:

```text
while        = preguntar → ejecutar
repeat-while = ejecutar → preguntar
```

### Common mistake

- Writing a non-exhaustive `switch`, referring to a different variable inside `where`, or creating a loop whose condition never changes. The compiler catches some cases, but it cannot prove that every loop will terminate.

---

## 6. Functions

[Open playground](Swift/6-Funciones.playground/Contents.swift)

**Objective:** define reusable units of behavior and understand their parameters, labels, signatures and returns.

### Official nomenclature

- **Defining and Calling Functions** — definition and calling of functions.
- **Function Argument Labels and Parameter Names** — argument labels and parameter names.
- **Default Parameter Values** — default values.
- **Variadic Parameters** —variadic parameters.
- **In-Out Parameters** — input-output parameters.
- **Function Types** — function types or signatures.
- **Nested Functions** — nested functions.
- **Overloading** — several statements with the same name and distinguishable signatures.

### Declaration, return and signature

- **`func nombre(...)`**
  - **Behavior:** Declare a reusable function.
  - **Limit or rule:** The types of your parameters must be declared.

- **`-> ReturnType`**
  - **Behavior:** Declare the returned type.
  - **Limit or rule:** All valid routes must return that type.

- **`return`**
  - **Behavior:** Ends the function and returns a value.
  - **Limit or rule:** The value must match the declared return.

- **`(Int, Int) -> Int`**
  - **Behavior:** Represents the type of a function.
  - **Limit or rule:** Parameter names are not part of the type.

- **`let operation = function`**
  - **Behavior:** Save a function as a value.
  - **Limit or rule:** The signature must be compatible.

- **`func f() -> (A, B)`**
  - **Behavior:** Returns multiple values using a tuple.
  - **Limit or rule:** For complex results, a separate type is appropriate.

### Argument labels, overloading, and default values

- **`external internal: T`**
  - **Behavior:** Use one name when calling and another within the function.
  - **Limit or rule:** The external name is part of the call.

- **`_ value: T`**
  - **Behavior:** Skip the outer tag.
  - **Limit or rule:** Reduces context; should be used only if the call is still clear.

- **`parameter: T = value`**
  - **Behavior:** Defines a default value.
  - **Limit or rule:** The argument can be omitted, but its type does not change.

- **Overload**
  - **Behavior:** Allows the same name with different signatures.
  - **Limit or rule:** Signatures must be distinguishable without ambiguity.

### Special parameters

- **`values: T...`**
  - **Behavior:** Receives zero or more arguments as an array.
  - **Limit or rule:** It is a variadic parameter, not an array sent directly.

- **`value: inout T`**
  - **Behavior:** Allows you to modify the original argument.
  - **Limit or rule:** The call requires `&` and a variable, not a constant.

- **`&variable`**
  - **Behavior:** Provides modifiable access to `inout`.
  - **Limit or rule:** Swift applies exclusive access rules to avoid simultaneous modifications.

### Scope

- **Nested function**
  - **Behavior:** Limits one function to the scope of another.
  - **Limit or rule:** It cannot be called from outside the container scope.


Signature that you must know how to read:

```swift
func add(a: Int, b: Int) -> Int
// tipo: (Int, Int) -> Int
```

### Common mistake

- Treating a variadic parameter as fully equivalent to an array. It appears as a collection inside the function, but callers pass separate arguments; ignoring useful return values can also hide logic errors.

---

## 7. Classes and structures

[Open playground](Swift/7-ClasesyEstructuras.playground/Contents.swift)

**Objective:** distinguish value semantics and shared identity to choose between `struct` and `class`.

### Official nomenclature

- **Structures and Classes** — structures and classes.
- **Instances** — concrete values created from a type.
- **Value Types** — types with value semantics, such as `struct` and `enum`.
- **Reference Types** — types with shared identity and references, such as `class`.
- **Identity Operators** — `===` and `!==` to check class identity.
- **Initialization** — process that establishes the initial state.
- **Memberwise Initializers for Structure Types** — generated initializer for structures.
- **Deinitialization** — cleanup of a class instance using `deinit`.
- **Subscripts** — accesses with syntax `instance[index]`.

### Type construction

- **`struct`**
  - **Behavior:** Creates a type with value semantics.
  - **Limit or rule:** An assignment produces an independent value.
  - **rule with `let`:** A constant instance does not allow its variable properties to be modified.

- **`class`**
  - **Behavior:** Creates a type with reference semantics.
  - **Limit or rule:** Multiple variables can observe and modify the same instance.
  - **rule with `let`:** The reference cannot be reassigned, but its properties `var` yes they can change.

- **Property**
  - **Behavior:** Stores or calculates state of the type.
  - **Limit or rule:** Every stored property must be initialized.

- **Method**
  - **Behavior:** Defines behavior associated with the type.
  - **Limit or rule:** In a `struct`, modify state requires `mutating`.

### Initialization and life cycle

- **`init`**
  - **Behavior:** Sets the initial state.
  - **Limit or rule:** You cannot end with stored properties without value.

- **Memberwise init**
  - **Behavior:** Swift generates it for structures.
  - **Limit or rule:** Declare a `init` inside the `struct` you can hide the generated one.

- **`convenience init`**
  - **Behavior:** Adds a secondary initialization path to a class.
  - **Limit or rule:** You must finally delegate to a designated initializer.

- **`deinit`**
  - **Behavior:** It is executed before releasing a class instance.
  - **Limit or rule:** It does not exist in structures.

- **Subscript**
  - **Behavior:** Allows access through `instancia[indice]`.
  - **Limit or rule:** You must declare the input and result types.

### Shared capabilities

- **Inheritance**
  - **Behavior:** One class can inherit behavior from another.
  - **Limit or rule:** Swift supports only one superclass; `struct` does not inherit from classes.

- **Protocol**
  - **Behavior:** Add a contract for composition.
  - **Limit or rule:** The requirements must be implemented.

- **Extension**
  - **Behavior:** Adds functionality to the type.
  - **Limit or rule:** You cannot add stored properties.


### Behavior difference

```swift
// struct: copia independiente
var b = a
b.value = 2       // a no cambia

// class: referencia compartida
var b = a
b.value = 2       // a observa el cambio
```

Important conceptual limit: `struct` does not mean “always on the stack,” and `class` does not mean “always on the heap.” Swift can optimize memory. The difference that should guide the design is **value vs. shared identity**.

Choice:

- Independent data and simple models → `struct`.
- Shared identity, inheritance or Objective-C → `class`.

### Common mistake

- Presenting stack and heap as guarantees for `struct` and `class`, claiming that structures are immutable by default, or writing unnecessary initializers. The design decision should be based on value semantics or shared identity.

---

## 8. Methods

[Open playground](Swift/8-Metodos.playground/Contents.swift)

**Objective:** associate behavior with instances or types and control when a method can modify state.

### Official nomenclature

- **Instance Methods** — instance methods.
- **The self Property** — reference to the current instance.
- **Modifying Value Types from Within Instance Methods** — modification by `mutating`.
- **Type Methods** — methods associated with the type using `static` or `class`.

### Instance and mutation methods

- **instance method**
  - **Behavior:** It is executed on a specific instance.
  - **Limit or rule:** Requires having created the instance.

- **`self`**
  - **Behavior:** Represents the current instance.
  - **Limit or rule:** Its writing can usually be omitted, except when it is necessary to disambiguate names.

- **`mutating func`**
  - **Behavior:** Allows a method `struct` change `self` or its properties.
  - **Limit or rule:** The instance must be declared with `var`.

- **Normal class method**
  - **Behavior:** You can modify properties `var` of the instance.
  - **Limit or rule:** It is still subject to the access level of those properties.

### Encapsulation

- **`private func`**
  - **Behavior:** Hides the method outside its allowed scope.
  - **Limit or rule:** It cannot be called from external code.

### Type methods

- **`static func`**
  - **Behavior:** Create a method of the type, not the instance.
  - **Limit or rule:** It cannot be overridden in a subclass.

- **`class func`**
  - **Behavior:** Creates an overrideable type method in a class.
  - **Limit or rule:** It is only available in classes.


Comparison:

```text
instance.method() = método de instancia
Type.method()     = método de tipo
```

### Common mistake

- Writing `@mutating`, requiring `self` where it is unnecessary, or assuming a class can only use `class func`. The keyword is `mutating`; `static` prevents overriding, while `class` permits it.

---

## 9. Properties

[Open playground](Swift/9-Propiedades.playground/Contents.swift)

**Objective:** differentiate stored state, calculated values, observation of changes and reuse through wrappers.

### Official nomenclature

- **Stored Properties** — stored properties.
- **Computed Properties** — computed properties.
- **Read-Only Computed Properties** — computed read-only properties.
- **Property Observers** — observers `willSet` and `didSet`.
- **Property Wrappers** — wrappers declared with `@propertyWrapper`.
- **Type Properties** — properties associated with the type.
- **Wrapped Value** — value managed by the wrapper using `wrappedValue`.

### Stored and type properties

- **Stored property**
  - **Behavior:** Maintains one value per instance.
  - **Limit or rule:** Must be initialized before finishing `init`.

- **`static var`**
  - **Behavior:** Shares a property on the type.
  - **Limit or rule:** It requires no instance; shared mutable state must be isolated or synchronized to prevent data races.

- **`class var`**
  - **Behavior:** Overridable type property.
  - **Limit or rule:** Only in classes and must be computed.

### Computed properties

- **Computed property**
  - **Behavior:** Calculates the value upon access.
  - **Limit or rule:** It is declared with `var`; it does not store its own value.

- **`get`**
  - **Behavior:** Produces the value of a computed property.
  - **Limit or rule:** It must return the declared type.

- **`set`**
  - **Behavior:** Receives and processes a new value.
  - **Limit or rule:** It only exists if the property is writable.

- **`newValue`**
  - **Behavior:** Implicit name of the value received by `set` or `willSet`.
  - **Limit or rule:** It can be replaced by an explicit name.

### Observers

- **`willSet`**
  - **Behavior:** Executed before changing a stored property.
  - **Limit or rule:** It does not prevent change on its own.

- **`didSet`**
  - **Behavior:** It is executed after the change.
  - **Limit or rule:** It is not executed during the initial initialization of the instance itself.

- **`oldValue`**
  - **Behavior:** Exposes the previous value inside `didSet`.
  - **Limit or rule:** It is only available in that observer.

### Property wrappers

- **`@propertyWrapper`**
  - **Behavior:** Create reusable logic around a property.
  - **Limit or rule:** The wrapper must provide `wrappedValue`.

- **`wrappedValue`**
  - **Behavior:** Defines how to read and write the wrapped value.
  - **Limit or rule:** It must match the type expected by the property.

- **`@Wrapper var value`**
  - **Behavior:** Applies the wrapper to a property.
  - **Limit or rule:** Initialization must be compatible with the wrapper.


Relationship:

```text
almacenada = conserva estado
computada  = calcula estado
willSet    = observa antes
didSet     = observa después
wrapper    = reutiliza reglas de lectura/escritura
```

### Common mistake

- Confusing stored and computed properties, applying a property wrapper to the wrong instance, or reading `didSet` as though its parameter were the new value. Its implicit `oldValue` parameter contains the previous value.

---

## 10. Closures

[Open playground](Swift/10-Closures.playground/Contents.swift)

**Objective:** treat behavior blocks as values, simplify their syntax, and control capture and deferred execution.

### Official nomenclature

- **Closure Expressions** — anonymous closures written inline.
- **Inferring Type From Context** — type inference from context.
- **Implicit Returns from Single-Expression Closures** — implicit returns.
- **Shorthand Argument Names** — abbreviated arguments `$0`, `$1`, etc.
- **Operator Methods** — use of operators as functions.
- **Trailing Closures** — closures written after parentheses.
- **Capturing Values** — capture of context values.
- **Closures Are Reference Types** — Closures have reference semantics.
- **Escaping Closures** — closures marked with `@escaping`.
- **Autoclosures** — closures created automatically with `@autoclosure`.

### Syntax and simplification

- **`{ (value: T) -> U in ... }`**
  - **Behavior:** Create an anonymous function.
  - **Limit or rule:** Your signature must match the context where it is used.

- **`in`**
  - **Behavior:** Separate signature and body.
  - **Limit or rule:** It can be omitted with shortened syntax.

- **`() -> Void`**
  - **Behavior:** Closure without parameters or useful return.
  - **Limit or rule:** `Void` equivalent to `()`.

- **Inference**
  - **Behavior:** Ignores types known from context.
  - **Limit or rule:** Without enough context, you have to write them down.

- **Implicit return**
  - **Behavior:** Omit `return` in a single expression.
  - **Limit or rule:** With several statements you usually need `return`.

- **`$0`, `$1`**
  - **Behavior:** Abbreviated argument names.
  - **Limit or rule:** They reduce clarity in long closures.

- **`sorted(by: >)`**
  - **Behavior:** Use a supported operator as a function.
  - **Limit or rule:** The operator's signature must match.

### Higher order functions

- **`map(transform)`**
  - **Behavior:** Produces a transformed collection.
  - **Limit or rule:** It does not modify the original array.

### Trailing closures

- **Trailing closure**
  - **Behavior:** Write the last closure argument outside of parentheses.
  - **Limit or rule:** Only applies when the corresponding argument is a closure.

- **Multiple trailing closures**
  - **Behavior:** Tag additional closures after the first one.
  - **Limit or rule:** The names must match the parameters.

### Return and capture of values

- **Return `() -> T`**
  - **Behavior:** A function can return another function or closure.
  - **Limit or rule:** To execute it you need to invoke the returned value.

- **Value Capture**
  - **Behavior:** Retains access to context variables.
  - **Limit or rule:** It can prolong the life of the captured state.

- **Reference semantics**
  - **Behavior:** Copies of a closure share their captured state.
  - **Limit or rule:** Two variables can observe the same captured counter.

### Deferred execution

- **`@escaping`**
  - **Behavior:** Allows you to save or execute the closure after finishing the function.
  - **Limit or rule:** May require `self` explicit and careful with reference cycles.

- **`@autoclosure`**
  - **Behavior:** Converts an expression to a closure without braces.
  - **Limit or rule:** Hide deferred evaluation; should be used sparingly.


Syntactic optimization shown:

```swift
names.sorted(by: { (a: String, b: String) -> Bool in return a > b })
names.sorted { a, b in a > b }
names.sorted { $0 > $1 }
names.sorted(by: >)
```

Deferred execution:

```text
closure normal = se entrega código
@escaping      = el código puede sobrevivir a la función
@autoclosure   = una expresión se envuelve automáticamente como código diferido
```

### Common mistake

- Using an incompatible closure signature, applying trailing-closure syntax where it does not fit, or strongly capturing `self` in a stored closure without checking for a reference cycle. Use `weak` when the relationship can actually form a cycle, not by habit.

---

## 11. Enum

[Open playground](Swift/11-Enum.playground/Contents.swift)

**Objective:** model a finite set of states and associate information or behavior to each case.

### Official nomenclature

- **Enumeration Syntax** — declaration of a `enum` and their cases.
- **Matching Enumeration Values with a Switch Statement** — comprehensive evaluation with `switch`.
- **Associated Values** — variable data associated with a case.
- **Raw Values** — fixed values associated with cases.
- **Implicitly Assigned Raw Values** — raw values automatically assigned.
- **CaseIterable** — protocol that allows obtaining `allCases`.
- **Recursive Enumerations** — recursive enums; require `indirect` and they do not appear developed in the playground.

### Declaration and flow control

- **`enum Name`**
  - **Behavior:** Creates a type with a defined set of states.
  - **Limit or rule:** It only admits declared cases.

- **`case value`**
  - **Behavior:** Declare a possible state.
  - **Limit or rule:** The name must be unique within the enum.

- **`.value`**
  - **Behavior:** Use a case when Swift already knows the type.
  - **Limit or rule:** Without context it may be necessary to write `Enum.value`.

- **`switch enumValue`**
  - **Behavior:** Execute logic as appropriate.
  - **Limit or rule:** Should cover all cases or use `default`.

- **`break`**
  - **Behavior:** Allows one case without another operation.
  - **Limit or rule:** Only that case ends.

- **`default`**
  - **Behavior:** Covers remaining cases.
  - **Limit or rule:** You can prevent the compiler from warning when adding a new case.

### Properties and methods

- **Computed property**
  - **Behavior:** Derives information from the current case.
  - **Limit or rule:** An enum does not support stored instance properties.

- **instance method**
  - **Behavior:** Perform behavior on a case.
  - **Limit or rule:** Access the case through `self`.

- **`static func`**
  - **Behavior:** Add behavior of the type.
  - **Limit or rule:** It is called on the enum, not on a case.

### Iteration

- **`CaseIterable`**
  - **Behavior:** Synthesize `allCases`.
  - **Limit or rule:** It is only automatically synthesized when cases have no associated values.

### Associated values

- **`case field(value: T)`**
  - **Behavior:** Add different associated values in each instance.
  - **Limit or rule:** The data must be provided when creating that case.

- **`case .field(let value)`**
  - **Behavior:** Extracts an associated value in a pattern.
  - **Limit or rule:** The pattern must match the shape of the case.

### Raw values

- **`enum E: String`**
  - **Behavior:** Defines a common type of raw value.
  - **Limit or rule:** Each case has a unique raw value.

- **`.rawValue`**
  - **Behavior:** Gets the base value of the case.
  - **Limit or rule:** It is not the same as an associated value.

- **raw value `Int`**
  - **Behavior:** It can autoincrement subsequent cases.
  - **Limit or rule:** The increase starts from the previous explicit value.


Difference:

```text
valor asociado = dato variable entregado al crear el caso
raw value       = dato fijo definido junto al caso
```

Enums have value semantics: assigning them to another variable creates a separate copy.

### Common mistake

- Saying that a `case` is used “without initialization” or constructing enum values that are never used. Every `case` creates a valid value; an unnecessary `default` can also prevent the compiler from warning when new cases are added.

---

## 12. Inheritance

[Open playground](Swift/12-Herencia.playground/Contents.swift)

**Objective:** reuse and specialize behavior between classes, respecting initialization and overwriting restrictions.

### Official nomenclature

- **Base Class** — base class or superclass.
- **Subclassing** — creation of a subclass.
- **Overriding** — overriding methods or properties.
- **Accessing Superclass Methods, Properties, and Subscripts** — access via `super`.
- **Preventing Overrides** — use of `final` to prevent inheritance or overwriting.
- **Two-Phase Initialization** — two-phase initialization of classes.

### Class hierarchy

- **`class Child: Parent`**
  - **Behavior:** Inherits accessible members of a superclass.
  - **Limit or rule:** A class can only have one direct super class.

- **Superclass**
  - **Behavior:** Defines reusable behavior.
  - **Limit or rule:** Its private members are not directly accessible in the subclass.

- **Subclass**
  - **Behavior:** Add or specialize behavior.
  - **Limit or rule:** It must respect the parent's initialization rules.

### Initialization and access to the super class

- **`super.init(...)`**
  - **Behavior:** Initializes the inherited part.
  - **Limit or rule:** It must be called in the order required by two-phase initialization.

- **`super.method()`**
  - **Behavior:** Run the legacy implementation.
  - **Limit or rule:** It is only available within the subclass.

### Overriding

- **`override func`**
  - **Behavior:** Overrides an inherited method.
  - **Limit or rule:** You can only overwrite an existing, allowed member.

- **`override var`**
  - **Behavior:** Replaces an overridable property.
  - **Limit or rule:** You cannot convert an inherited read-write property to read-only.

- **`class func` / `class var`**
  - **Behavior:** Allow overwriting of type members.
  - **Limit or rule:** A `static` member cannot be overridden.

### Restrictions with `final`

- **`final class`**
  - **Behavior:** Prohibits creating subclasses.
  - **Limit or rule:** Ends the inheritance hierarchy.

- **`final func`**
  - **Behavior:** Prohibits overriding the method.
  - **Limit or rule:** The class can still be inherited if it is not `final`.

- **`final var`**
  - **Behavior:** Prohibits overwriting the property.
  - **Limit or rule:** The inherited property remains usable.


Hierarchy used as reference:

```text
UIButton → UIControl → UIView → UIResponder → NSObject
```

Essential limit: Swift allows implementation inheritance only between classes. Structures and enums extend behavior through protocols, composition, and extensions.

### Common mistake

- Using the wrong subclass to demonstrate `final`, treating `static` as exclusive to structures, or choosing inheritance only to reuse code. Inheritance should express a real relationship; composition is often better for combining capabilities.

---

## 13. Protocols

[Open playground](Swift/13-Protocolos.playground/Contents.swift)

**Objective:** define behavioral contracts that different types can adopt without sharing a superclass.

### Official nomenclature

- **Protocol Syntax** — declaration and adoption of protocols.
- **Property Requirements** — property requirements.
- **Method Requirements** — method requirements.
- **Initializer Requirements** — initialization requirements.
- **Protocols as Types** — use of a protocol as a type.
- **Protocol Conformance** — conformity of a type.
- **Protocol Extensions** — implementations and shared functionality.
- **Optional Protocol Requirements** — optional requirements limited to interoperability `@objc`.

### Declaration and conformance

- **`protocol Name`**
  - **Behavior:** Declare a contract.
  - **Limit or rule:** Does not store instance state.

- **`Type: Protocol`**
  - **Behavior:** Declares conformity.
  - **Limit or rule:** The type must implement all mandatory requirements.

- **`Type: P1, P2`**
  - **Behavior:** Adopts various protocols.
  - **Limit or rule:** There is no limit to a single conformity.

- **`Subclass: Superclass, P1`**
  - **Behavior:** Inherits and conforms protocols.
  - **Limit or rule:** The superclass must be written first.

### Requirements

- **`var value: T { get }`**
  - **Behavior:** Requires a readable property.
  - **Limit or rule:** The implementation can be stored or computed.

- **`var value: T { get set }`**
  - **Behavior:** Requires reading and writing.
  - **Limit or rule:** A read-only constant or property does not comply.

- **`static var` / `static func`**
  - **Behavior:** Demands members of the type.
  - **Limit or rule:** The concrete implementation must comply with the signature.

- **`func action()`**
  - **Behavior:** Requires an instance method.
  - **Limit or rule:** The protocol declares the signature, not the mandatory logic.

- **`init(...)`**
  - **Behavior:** Requires an initializer.
  - **Limit or rule:** A non-final class typically uses `required init`.

### Objective-C optional requirements

- **`@objc protocol`**
  - **Behavior:** Enables interoperability with Objective-C.
  - **Limit or rule:** It only supports types representable in Objective-C.

- **`@objc optional`**
  - **Behavior:** Makes an Objective-C requirement optional.
  - **Limit or rule:** It is limited to protocols `@objc` and compatible class types.

### Implementations with extensions

- **`extension Protocol`**
  - **Behavior:** Add default implementation.
  - **Limit or rule:** Does not add storage.

- **`extension ConformingType`**
  - **Behavior:** Separates the conformity from the main statement.
  - **Limit or rule:** You must continue to meet all requirements.


Three deployment locations:

```text
1. Dentro del tipo
2. En una extensión del tipo
3. Como implementación predeterminada en una extensión del protocolo
```

Essential resolution:

- A concrete implementation of the type takes precedence over the default implementation.
- A method existing only in the extension and not declared as a requirement can use static dispatch when the value is protocol-typed.

### Common mistake

- Claiming that a protocol extension cannot provide computed properties or assuming all extension methods use the same dispatch. Protocol requirements participate in dynamic dispatch; extension-only members may be resolved statically.

---

## 14. Generics

[Open playground](Swift/14-Genericos.playground/Contents.swift)

**Objective:** reuse an implementation with multiple types, explicitly declaring the capabilities you need.

### Official nomenclature

- **Generic Functions** — generic functions.
- **Type Parameters** — type parameters like `T`.
- **Naming Type Parameters** — names like `T`, `U`, `Element`, `Key` and `Value`.
- **Generic Types** — generic classes, structures or enums.
- **Type Constraints** — class or protocol restrictions.
- **Associated Types** — associated types declared with `associatedtype`.
- **Generic Where Clauses** — requirements expressed by `where`.
- **Concrete Type** — real type that replaces the generic parameter.

### Generic functions and parameters

- **`<T>`**
  - **Behavior:** Declares a placeholder of type.
  - **Limit or rule:** Every use of `T` within that specialization it represents the same type.

- **`func f<T>(value: T)`**
  - **Behavior:** Create a generic function.
  - **Limit or rule:** You can only perform operations known to any `T`.

- **`<T, U>`**
  - **Behavior:** Declare two independent types.
  - **Limit or rule:** `T` and `U` may be the same type, but they are not required to be.

- **`inout T`**
  - **Behavior:** Allows you to modify an original generic value.
  - **Limit or rule:** The call requires a variable with `&`.

### Generic types

- **`struct Stack<Element>`**
  - **Behavior:** Create a generic type.
  - **Limit or rule:** The concrete type is defined when instantiating or inferring it.

- **`push`**
  - **Behavior:** Add an element to the stack.
  - **Limit or rule:** Must be compatible with `Element`.

- **`pop`**
  - **Behavior:** Remove the last element: LIFO.
  - **Limit or rule:** The empty stack case must be handled.

### Restrictions

- **`<T: Protocol>`**
  - **Behavior:** Restricts `T` to types that make up a protocol.
  - **Limit or rule:** Only those types can specialize the generic.

- **`where T: Protocol`**
  - **Behavior:** Express restrictions in a separate clause.
  - **Limit or rule:** The restriction remains mandatory.

- **`AdditiveArithmetic`**
  - **Behavior:** Guarantees basic arithmetic operations such as `+`.
  - **Limit or rule:** It does not mean that the type is specifically `Int` or `Double`.

### Associated types

- **`associatedtype Element`**
  - **Behavior:** Declares a pending type within a protocol.
  - **Limit or rule:** Conformity must resolve this explicitly or implicitly.

- **Generic type + protocol**
  - **Behavior:** Allows a conformance for any `Element` valid.
  - **Limit or rule:** Protocol and type restrictions accumulate.


Problem they solve:

```text
función para String  ┐
función para Int     ├─→ una función genérica
función para Double  ┘
```

Essential limit: a generic does not allow using any operation on `T`. This capacity must first be guaranteed through a protocol restriction.

### Common mistake

- Mixing values of different generic types, introducing generic parameters that express no useful relationship, or implementing `pop()` as if an element always existed. An empty stack should return an optional or report failure safely.

---

## 15. Extensions

[Open playground](Swift/15-Extensiones.playground/Contents.swift)

**Objective:** add and organize functionality of existing types without modifying their original declaration.

### Official nomenclature

- **Extensions** — extensions to existing types.
- **Computed Properties** — computed properties added by an extension.
- **Initializers** — additional initializers.
- **Methods** — added instance or type methods.
- **Adding Protocol Conformance with an Extension** — declared compliance in an extension.
- **Protocol Extensions** — functionality shared by conforming types.
- **Extensions with a Generic Where Clause** — extensions available only under certain restrictions.

### Extend types

- **`extension Type`**
  - **Behavior:** Adds functionality to an existing type.
  - **Limit or rule:** The extension does not have its own name.

- **Extension of `String` or `Int`**
  - **Behavior:** Add methods to types we don't control.
  - **Limit or rule:** It does not modify the original source code.

- **instance method**
  - **Behavior:** It is available using dot notation.
  - **Limit or rule:** Respect access levels.

### Members and initializers

- **`static func`**
  - **Behavior:** Add a method of the type.
  - **Limit or rule:** Invoked without creating an instance.

- **Computed property**
  - **Behavior:** Add a derived value.
  - **Limit or rule:** You cannot add stored properties.

- **`init` in extension**
  - **Behavior:** Add initialization forms.
  - **Limit or rule:** You must completely initialize the instance.

### Protocols and conformance

- **`extension Protocol`**
  - **Behavior:** Delivers default behavior.
  - **Limit or rule:** You cannot contribute storage per instance.

- **`extension Type: Protocol`**
  - **Behavior:** Declare and organize a conformity.
  - **Limit or rule:** You must satisfy all requirements.


Uses:

- Separate responsibilities.
- Organize compliances.
- Add methods to standard types.
- Preserve the memberwise initializer of a `struct` by declaring additional initializers outside of its main body.

They do not allow:

- Add stored properties.
- Add a `deinit`.
- Freely override methods of a class as if they were a subclass.

### Common mistake

- Claiming that an extension can only implement protocol methods or trying to add stored properties. Extensions can add methods, initializers, computed properties, and conformances, but they cannot add storage.

---

## 16. Access Level

[Open playground](Swift/16-AccesLevel.playground/Contents.swift)

**Objective:** control which parts of the program can see or use each statement.

### Official nomenclature

- **Access Control** — visibility control by declaration, file, module and package.
- **Open Access** — open access.
- **Public Access** — public access.
- **Package Access** — access within the same package.
- **Internal Access** — access within the module.
- **File-Private Access** — access within the file.
- **Private Access** — access within the declaration and extensions allowed.
- **Guiding Principle of Access Levels** — an entity cannot expose another entity with more restrictive access.

### Access levels

- **`private`**
  - **Visibility:** Declaration and extensions of the same type within the file.
  - **Main limit:** It is the most restrictive level used in the playground.

- **`fileprivate`**
  - **Visibility:** Any code from the same Swift file.
  - **Main limit:** It does not cross over to another file.

- **`internal`**
  - **Visibility:** All current module.
  - **Main limit:** It is the default level if no other level is entered.

- **`package`**
  - **Visibility:** All modules that belong to the same package.
  - **Main limit:** It is not visible from code outside the package.
  - **Origin:** Added from current documentation; it does not appear in the original playground.

- **`public`**
  - **Visibility:** Other modules can use the API.
  - **Main limit:** Outside the module they cannot create subclasses or override public members.

- **`open`**
  - **Visibility:** Other modules can use, inherit and overwrite.
  - **Main limit:** Only applies to classes and class members.


### Practical application

- **`private var`:** Hides a property outside the allowed scope.

- **`private func`:** Prevents external calls to the method.

- **Private type:** It also limits the possible exposure of its members.

- **Public API + private implementation:** Exposes safe operations and hides internal details.


Essential rule: A declaration cannot publicly expose a type that has a more restrictive access level.

### Common mistake

- Teaching only `private`, omitting the `package` level, or declaring everything `public`. Swift has six access levels; expose only the API that the module or package needs and keep implementation details private.

---

## 17. Error handling

[Open playground](Swift/17-Gestion%20de%20errores.playground/Contents.swift)

**Objective:** represent, throw, propagate, and handle recoverable failures without confusing them with absence of value.

### Official nomenclature

- **Representing and Throwing Errors** — representing and throwing errors.
- **Throwing Functions** — functions declared with `throws`.
- **Propagating Errors Using Throwing Functions** — propagation to the caller.
- **Handling Errors Using Do-Catch** — handling with `do-catch`.
- **Converting Errors to Optional Values** — conversion to optional using `try?`.
- **Disabling Error Propagation** — asserting success with `try!`.
- **Typed Throws** — error restriction with `throws(ErrorType)`.
- **Cleanup Actions Using Defer** — cleanup guaranteed by `defer`.

### Represent errors

- **`Error`**
  - **Behavior:** Protocol that identifies usable types as errors.
  - **Limit or rule:** Conformance does not automatically throw the error.

- **`enum MyError: Error`**
  - **Behavior:** Groups known error cases.
  - **Limit or rule:** Each case must be explicitly thrown or handled where appropriate.

### Throwing and propagating

- **`throws`**
  - **Behavior:** Declares that a function can propagate an error.
  - **Limit or rule:** It doesn't mean it always fails; it forces the caller to recognize the possibility.

- **`throw error`**
  - **Behavior:** Interrupts the current path and throws a specific error.
  - **Limit or rule:** The thrown value must conform to `Error`.

### Trying and catching

- **`try operation()`**
  - **Behavior:** Marks a call to a throwing function.
  - **Limit or rule:** It must be handled in a valid context or propagated from another `throws` function.

- **`do { ... }`**
  - **Behavior:** Defines the block where an operation is attempted.
  - **Limit or rule:** It doesn't capture anything on its own.

- **`catch { ... }`**
  - **Behavior:** Captures an error thrown from the `do`.
  - **Limit or rule:** It should cover errors not handled by previous catches.

- **`catch MyError.case`**
  - **Behavior:** Handle a specific case.
  - **Limit or rule:** The pattern must correspond to the error received.

- **`catch let error`**
  - **Behavior:** Captures the error as a value.
  - **Limit or rule:** If it is the final catch, catch any remaining errors.

### Variants of `try` and cleanup

- **`try? operation()`**
  - **Behavior:** Converts success to optional value and failure to `nil`.
  - **Limit or rule:** It discards the error's identity and details.

- **`try! operation()`**
  - **Official name:** Disabling Error Propagation.
  - **Behavior:** It claims that the operation will not fail and extracts its result.
  - **Limit or rule:** It traps at runtime if the operation throws.

- **`throws(MyError)`**
  - **Official name:** Typed Throws.
  - **Behavior:** Declare the specific type of error that can propagate.
  - **Limit or rule:** The function cannot throw any other type of error.

- **`defer { ... }`**
  - **Official name:** Cleanup Actions.
  - **Behavior:** Executes actions before leaving the scope, whether an error exists or not.
  - **Limit or rule:** It is executed when leaving scope and not immediately where it is declared.

- **Propagation**
  - **Behavior:** A `throws` function can propagate the error to its caller.
  - **Limit or rule:** The error must be handled at some level of the flow.


Complete flow:

```text
enum Error          identifica los fallos posibles
throws              declara que una función puede fallar
throw               produce el fallo concreto
try                 intenta ejecutar la función
do                  contiene el intento
catch               recibe y maneja el error
```

Integrated example:

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

Fundamental difference:

```text
try  + do/catch = conserva y maneja el error
try?            = solo entrega valor o nil; pierde el detalle del error
```

### Common mistake

- Believing that a `do` block does not start when an error is later thrown, using `try?` when the cause matters, or using `try!` without an absolute guarantee. `do` runs until `throw`, then control moves to a matching `catch`.

---

## 18. Type Casting

[Open playground](Swift/18-typeCasting.playground/Contents.swift)

**Objective:** check the dynamic type of an instance and safely retrieve a more specific type.

### Official nomenclature

- **Type Casting** — checking or treating an instance as another compatible type.
- **Checking Type / Type-Checking Operator** — check with `is`.
- **Upcasting** — treatment of a subclass as its superclass by `as`.
- **Downcasting** — attempt to retrieve a more specific type.
- **Conditional Downcast** — safe downcast using `as?`.
- **Forced Downcast** — forced downcast using `as!`.
- **Type Casting for Any and AnyObject** — retrieval of specific types stored as `Any` or `AnyObject`.

### Checking and casting types

- **`is` — Type-Checking Operator**
  - **Behavior:** Check the type and return `Bool`.
  - **Limit or risk:** It does not convert or deliver the typed instance.

- **`as` — Upcasting**
  - **Behavior:** Treats a subclass instance as its superclass or performs another guaranteed cast.
  - **Limit or risk:** Exclusive subclass members are temporarily lost.

- **`as?` —Conditional Downcast**
  - **Behavior:** Attempts a downcast and returns an optional.
  - **Limit or risk:** It must be unwrapped and returns `nil` if the cast fails.

- **`as!` — Forced Downcast**
  - **Behavior:** Asserts that the downcast will succeed.
  - **Limit or risk:** It traps at runtime if the actual type does not match.


Safe pattern:

```swift
if let fish = animal as? Fish {
    fish.respirarBajoAgua()
}
```

Polymorphism:

```text
[Animal] puede contener Dog, Cat y Bird
          ↓
as? recupera el subtipo concreto
          ↓
permite usar el método específico
```

Rules:

- `is` checks a type.
- `as` upcasts to a more general type.
- `as?` attempts a safe downcast.
- `as!` forces a downcast and can trap at runtime.
- Type casting changes the typed view of an instance; it does not create another object.

### Common mistake

- Confusing type casting with value conversion. `as?` cannot turn `"123"` into an `Int`; use `Int("123")`. A forced downcast with `as!` traps when the runtime type does not match, and printing a `Void`-returning function only displays `()`.

---

## 19. Ternary operator

[Open playground](Swift/19-Operador%20ternario.playground/Contents.swift)

**Objective:** select one of two expressions when the decision is short and produces a value.

### Official nomenclature

- **Ternary Conditional Operator** — ternary conditional operator.
- **Condition** — evaluated boolean expression.
- **True Expression** — expression chosen when the condition is true.
- **False Expression** — expression chosen when the condition is false.

### Syntax and decisions

- **`condition ? A : B`**
  - **Behavior:** Evaluate `condition` and execute only one of the expressions.
  - **Limit or risk:** The condition must be `Bool`.

- **`let value = condition ? A : B`**
  - **Behavior:** Produces a value for an assignment.
  - **Limit or risk:** `A` and `B` must have compatible types.

- **nested ternary**
  - **Behavior:** Evaluates another condition within a branch.
  - **Limit or risk:** Loses readability quickly.

- **`condition ? action() : ()`**
  - **Behavior:** Use `()` as a branch without useful action.
  - **Limit or risk:** An `if` usually expresses an action without an alternative more clearly.

- **Assignments in the branches**
  - **Behavior:** Modifies a variable based on the condition.
  - **Limit or risk:** The side effects within the ternary are difficult to read.


Recommended way:

```swift
let status = isConnected ? "Conectado" : "Desconectado"
```

Use ternary to choose short values. Use `if-else` for multiple instructions, nested ternaries, or state changes.

### Common mistake

- Using the ternary operator for side effects or nesting decisions until the expression becomes unreadable. It should choose between two short values; use `if-else` for actions or complex logic.

---

## Official documentation consulted

- [The Basics](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/thebasics/) — basic, variable, tuple and optional types.
- [Basic Operators](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/basicoperators/) — operators, null fusion and ternary.
- [Optional Chaining](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/optionalchaining/) — optional chaining vs. forced unpacking.
- [Collection Types](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/collectiontypes/) — arrays, sets and dictionaries.
- [Control Flow](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/controlflow/) — conditions, cycles, `guard` and `switch`.
- [functions](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/functions/) — signatures, labels, variadic and `inout`.
- [Structures and Classes](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/classesandstructures/) — value and reference semantics.
- [Methods](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/methods/) — instance methods, `self`, `mutating` and type methods.
- [Properties](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/properties/) — computed properties, observers and wrappers.
- [Closures](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/closures/) — syntax, capture, trailing, escaping and autoclosures.
- [Enumerations](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/enumerations/) — cases, associated values and raw values.
- [Inheritance](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/inheritance/) — subclasses, `override`, `super` and `final`.
- [Protocols](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/protocols/) — requirements, conformance and extensions.
- [Generics](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/generics/) — type parameters, constraints, associated types and `where`.
- [Extensions](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/extensions/) — capabilities and limits of extensions.
- [Access Control](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/accesscontrol/) — the six current access levels.
- [Error Handling](https://docs.swift.org/swift-book/LanguageGuide/ErrorHandling.html) — throwing, propagation, and error handling.
- [Type Casting](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/typecasting/) — `is`, `as`, downcasting, `Any` and `AnyObject`.
