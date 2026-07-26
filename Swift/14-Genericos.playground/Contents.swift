//Genéricos
//Error frecuente: suponer operaciones disponibles sobre T sin expresarlas en una
//restricción o implementar pop() como si la colección nunca estuviera vacía.

//Los genéricos son una característica en Swift bien potente ya que nos permite escribir código que no esté vinculado a ningún tipo de datos en especifico y así poder trabajar con cualquier tipo de datos y no está limitado, haciendo el código más flexible y reutilizable

//un ejemplo claro de genéricos son los Array, Set y Diccionarios. Estos no discriminan el tipo de datos a almacenar. No confundir con reglas de almacenamiento de varios tipos de datos dentro de colecciones

//creacion de método con parámetros inout
//función que toma dos valores tipo String y los invierte

func swapTwoStrings(a: inout String, b: inout String) {

  let tempA = a
  a = b
  b = tempA
}

//creacion variables de tipo String

var name = "Rodolfo"
var book = "The Swift Repository"

//resultado con valores actuales

print("name: \(name)\nbook: \(book)")
// name: Rodolfo
// book: The Swift Repository

//llamado a la función que invierte valores

swapTwoStrings(a: &name, b: &book)

//resultado con valores actuales luego del llamado a la función

print("name: \(name)\nbook: \(book)")
// name: The Swift Repository
// book: Rodolfo

//creacion de método con parámetros inout
//función que toma dos valores tipo Int y los invierte

func swapTwoInts(a: inout Int, b: inout Int) {
  let tempA = a
  a = b
  b = tempA
}

//creacion de método con parámetros inout
//función que toma dos valores tipo Int y los invierte

func swapTwoDoubles(a: inout Double, b: inout Double) {
  let tempA = a
  a = b
  b = tempA
}

var firstInteger = 1
var secondInteger = 2
swapTwoInts(a: &firstInteger, b: &secondInteger)
print(firstInteger, secondInteger)

var firstPrice = 19.9
var secondPrice = 29.9
swapTwoDoubles(a: &firstPrice, b: &secondPrice)
print(firstPrice, secondPrice)

//aqui podemos ver que hemos creado 3 métodos casi idénticos, salvo por el tipo de datos que reciben los parametros. Con los Genéricos podemos crear una única función que abarcará amplia variedad de tipo de datos como parámetros solicitados.

//Funciones genéricas

//para crear una función genérica debemos agregar el siguiente código placeholder después del nombre de la funcion <T> y además el placeholder T como parámetro

//creacion de método generico de un solo tipo de datos, con parámetros inout
//función que toma dos valores tipo Genericos y los invierte

func swapTwoValues<T>(a: inout T, b: inout T) {
  let tempA = a
  a = b
  b = tempA
}

//creacion variables de tipo String

var myName = "Rodolfo"
var myBrand = "Learn to code"

//llamado a la función que invierte valores

swapTwoValues(
  a: &myName,
  b: &myBrand)

//resultado con valores actualizados

print(myName)
print(myBrand)
// Learn to code
// Rodolfo

//creacion variables de tipo Int

var firstDayOfTheMonth = 1
var lastDayOfTheMonth = 30

//llamado a la función que invierte valores

swapTwoValues(
  a: &firstDayOfTheMonth,
  b: &lastDayOfTheMonth)

//resultado con valores actualizados

print(firstDayOfTheMonth)
print(lastDayOfTheMonth)
// 30
// 1

//aquí hemos creado un método genérico que recibe parámetros de un solo tipo, es decir cualquier tipo pero ambos deben ser del mismo tipo

//para poder ingresar parámetros de distintos tipos en un método genérico debemos añadir U, dentro de <T, U> y además pasamos como parámetro U

//creacion método genérico que acepta dos parámetros de distinto tipo

func printParameters<T, U>(valueA: T, valueB: U) {
  print(valueA)
  print(valueB)
}

printParameters(valueA: "Swift", valueB: 6)

//Nombre de los tipos genericos

//nuestros genéricos en los ejemplos anteriores solo se han llamado de forma básica pero pueden ser nombrados de forma descriptiva

func printParameter<AlphaNumeric, U>(numbers: AlphaNumeric, valueB: U) {
  print(numbers)
  print(valueB)
}

printParameter(numbers: 123, valueB: "ABC")

//otro buen ejemplo es el de los placeholders elements genéricos del Array, los placeholders genericos key y valué de los Dict

//con la tecla command y escribiendo Array o Dict podemos navegar en la estructura del componente

//Firmas simplificadas de la biblioteca estándar:
//Dictionary<Key, Value> exige que Key conforme Hashable.
//Array<Element> utiliza Element para representar el tipo almacenado.

//como podemos darnos cuenta en los Array con los Element y en los Dict con los Key y Valué, estos pueden ser de cualquier tipo de datos, siempre y cuando respete las reglas de tipos de datos de la colección

//Tipos genéricos en Swift

//aparte de tener métodos Genéricos en Swift también podemos tener tipos (Clase, Struct) genéricos

//para el próximo ejemplo crearemos un objeto stack de características LIFO(ingresar elementos al último índice del stack y eliminar elemento del último índice del stack)

//este stack será una estructura que tendrá una propiedad de tipo arreglo de String [String] y dos Metodos.
//un método se llamará push y me recibe un parametro de entrada el cual me agrega a mi arreglo
//el otro método se llamará pop y me elimina el último el elemento del arreglo

//creacion de objeto stack

struct StackOfString {
  var items = [String]()

  mutating func push(_ item: String) {
    items.append(item)
  }

  mutating func pop() -> String? {
    items.popLast()
  }
}

//instancia de objeto stack
var stackOfString = StackOfString()

//métodos de la instancia
stackOfString.push("Rodolfo")
stackOfString.push("Learn Swift Programming")
if let poppedString = stackOfString.pop() {
  print(poppedString)
}
print(stackOfString.items)

//ahora si quisiéramos implementar este mismo objeto con sus propiedades y sus métodos pero con otro tipo de datos, no podríamos a menos que ocupemos Genéricos en tipos de datos(class, Struct y Enum)

//creacion objeto stack Generico

struct Stack<Element> {
  var items = [Element]()

  mutating func push(_ item: Element) {
    items.append(item)
  }

  mutating func pop() -> Element? {
    items.popLast()
  }
}
//podemos ver que añadiendo el placeholder <Element> después del nombre del tipo y añadiendo el placeholder Element como tipo de dato cuando es requerido dentro del cuerpo de nuestro tipo.
//con esto nuestro objeto es genérico y puede trabajar con cualquier tipo de datos

//inicializacion de objeto genérico que recibe tipos Int

var stack = Stack<Int>()

//acceso a métodos del objeto

stack.push(1)
stack.push(2)
stack.push(3)
if let poppedNumber = stack.pop() {
  print(poppedNumber)
}

//inicializacion de objeto genérico que recibe tipos String

var genericStack = Stack<String>()

//acceso a métodos del objeto

genericStack.push("Rodolfo")
genericStack.push("Learn Swift")
genericStack.push("Learn to Build Apps")
if let poppedValue = genericStack.pop() {
  print(poppedValue)
}

//Cabe señalar que son muchas las ventajas de los genéricos como es el evitar escribir código extra, pero es importante no abusar de esto e incrementar la dificultad
//podriamos hablar de genéricos en sus usos entre reducir código duplicado vs aumentar la dificultad

//restricciones de tipo usando genericos

//Los genéricos también admiten restricciones. Para utilizar + no basta con un tipo
//T totalmente libre: el compilador necesita un protocolo que garantice esa operación.

//código erróneo de genérico
//struct Calculator<Value> {
//  func sum(a: Value, b: Value) -> Value {
//     a + b
// }
//}

//El código anterior no compila porque un Value sin restricciones no garantiza que
//exista el operador +.
//para poder aplicar estas restricciones a los genéricos debemos hacer lo siguiente

//creacion de objeto con genérico y restricciones de tipo

struct Calculator1<Value: AdditiveArithmetic> {
  func sum(a: Value, b: Value) -> Value {
    a + b
  }
}

let calculator1 = Calculator1<Int>()
print(calculator1.sum(a: 20, b: 30))

//Value debe conformar AdditiveArithmetic, protocolo que exige zero, suma y resta.
//No significa estrictamente “tipo numérico”: un tipo propio también puede conformarlo
//si implementa esos requisitos. Bool y String no conforman este protocolo.

//podríamos ocupar la keyword where y hacer más conciso nuestro código

struct Calculator2<Value> where Value: AdditiveArithmetic {
  func sum(a: Value, b: Value) -> Value {
    a + b
  }
}

//La cláusula where expresa la misma restricción de otra forma. Calculator2 acepta
//cualquier tipo que conforme AdditiveArithmetic, no solamente los tipos numéricos de
//la biblioteca estándar.

//instancia de objeto genérico con restricción de tipo de dato

let calculator2 = Calculator2<Int>()
print(calculator2.sum(a: 2000, b: 3000))

//codigo erroneo
//let calculator2 = Calculator2<String>()

//Tipos asociados

//Un protocolo declara un tipo asociado con la keyword associatedtype. Cada tipo que
//conforma el protocolo determina qué tipo concreto representa Element.

//creacion de protocolo genérico

protocol StackProtocol {

  associatedtype Element  // 1
  var items: [Element] { get set }  // 2
  mutating func push(_ item: Element)  // 3
  mutating func pop() -> Element?  // 4
}

//para implementar un protocolo con datos genéricos debemos agregar el placeholder associated types seguido por el nombre que en nuestro caso será Element
//Luego en cada propiedad o método donde sea requerido el tipo de datos debemos agregar el Element creado
//este protocolo trae una propiedad y dos métodos los cuales debemos implementar en el tipo que conforme el protocolo

//creacion de tipo que conforma protocolo genérico

struct StackOfStrings: StackProtocol {
  var items: [String]

  mutating func push(_ item: String) {
    items.append(item)
  }

  mutating func pop() -> String? {
    items.popLast()
  }
}

//creacion de instancia de objeto y utilización de métodos

var stackOfStrings = StackOfStrings(items: [])
stackOfStrings.push("Rodolfo")
stackOfStrings.push("Martin")
stackOfStrings.push("Nacho")
if let poppedString = stackOfStrings.pop() {
  print(poppedString)
}

//aquí vemos cómo creamos un protocolo genérico y el objeto que lo conforme puede con el tipo de datos deseado.
//En el objeto creado le indicamos que el tipo de datos a utilizar por el objeto será String pero si quisiéramos que la implementación de métodos y propiedades fuera de cualquier tipo de datos podríamos indicarle a nuestra estructura o nuestro tipo que sea genérica quedando asi

//creacion de objeto genérico que conforma protocolo genérico

struct Stack1<Element>: StackProtocol {
  var items: [Element]

  mutating func push(_ item: Element) {
    items.append(item)
  }

  mutating func pop() -> Element? {
    items.popLast()
  }
}

//instancia de objeto genérico que conforma protocolo genérico y utilización de métodos

var stack1 = Stack1<String>(items: [])
stack1.push("Rodolfo")
stack1.push("Nacho")
stack1.push("Martin")
if let poppedItem = stack1.pop() {
  print(poppedItem)
}

print(stack1.items)

//pop retorna Optional para representar de forma segura un stack vacío. Usar
//removeLast directamente impondría como precondición que existiera un elemento y
//provocaría un error de ejecución si esa precondición no se cumple.

//Como has podido ver, los genéricos ayudan a reducir código pero pueden añadir más complejidad y también pueden dificultar la comprensión del código. Hay que intentar buscar el equilibrio y saber cuándo es mejor usar genéricos dentro de tu aplicación.

//casos de uso
