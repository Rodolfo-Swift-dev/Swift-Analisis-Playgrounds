import UIKit

//Genéricos

Los genéricos son una característica en Swift bien potente ya que nos permite escribir código que no esté vinculado a ningún tipo de datos en especifico y así poder trabajar con cualquier tipo de datos y no está limitado, haciendo el código más flexible y reutilizable

//un ejemplo claro de genéricos son los Array, Set y Diccionarios. Estos no discriminan el tipo de datos a almacenar. No confundir con reglas de almacenamiento de varios tipos de datos dentro de colecciones


//creacion de método con parámetros inout
//función que toma dos valores tipo String y los invierte

func swapTwoStrings(a: inout String, b: inout String) {

String) {
    let tempA = a
    a = b
    b = tempA
}


//creacion variables de tipo String

var name = "SwiftBeta"
var book = "El Libro de Swift


//resultado con valores actuales

print("name: \(name)\nbook: \(book)")
// name: SwiftBeta
// book: El libro de Swift


//llamado a la función que invierte valores

swapTwoStrings(a: &name, b: &book)


//resultado con valores actuales luego del llamado a la función

print("name: \(name)\nbook: \(book)")
// name: El libro de Swift
// book: SwiftBeta



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

//aqui podemos ver que hemos creado 3 métodos casi idénticos, salvo por el tipo de datos que reciben los parametros. Con los Genéricos podemos crear una única función que abarcará amplia variedad de tipo de datos como parámetros solicitados.





//Funciones genéricas

//para crear una función genérica debemos agregar el siguiente código placeholder después del nombre de la funcion <T> y además el placeholder T como parámetro

//creacion de método con parámetros inout
//función que toma dos valores tipo Genericos y los invierte

func swapTwoValues<T> (a: inout T, b: inout T) {
    let tempA = a
    a = b
    b = tempA
}


//creacion variables de tipo String

var myName = "SwiftBeta"
var myBrand = "Aprende a programar en Swift"


//llamado a la función que invierte valores

swapTwoValues(a: &myName,
              b: &myBrand)


//resultado con valores actualizados

print(myName)
print(myBrand)
// Aprende a programar en Swift
// SwiftBeta


//creacion variables de tipo Int

var firstDayOfTheMonth = 1
var lastDayOfTheMonth = 30


//llamado a la función que invierte valores

swapTwoValues(a: &firstDayOfTheMonth,
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





//Nombre de los tipos genericos

//nuestros genéricos en los ejemplos anteriores solo se han llamado de forma básica pero pueden ser nombrados de forma descriptiva


func printParameters<StringTipes, U>(IntTipes: StringTipes, valueB: IntTipes) {
    print(valueA)
    print(valueB)
}


//otro buen ejemplo es el de los placeholders elements genéricos del Array, los placeholders genericos key y valué de los Dict


//con la tecla command y escribiendo Array o Dict podemos navegar en la estructura del componente


//Dict placeholders key and value

@frozen public struct Dictionary<Key, Value> where Key : Hashable


//Array placeholders Elements

@frozen public struct Array<Element>
 

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
    
    mutating func pop() -> String {
        return items.removeLast()
    }
}

//instancia de objeto stack
var stackOfString = StackOfString()

//métodos de la instancia
stackOfString.push("SwiftBeta")
stackOfString.push("Aprender a Programar en Swift")
stackOfString.pop()
stackOfString.items


//ahora si quisiéramos implementar este mismo objeto con sus propiedades y sus métodos pero con otro tipo de datos, no podríamos a menos que ocupemos Genéricos en tipos de datos(class, Struct y Enum)



//creacion objeto stack Generico

struct Stack<Element> {
    var items = [Element]()
    
    mutating func push(_ item: Element) {
        items.append(item)
    }
    
    mutating func pop() -> Element {
        return items.removeLast()
    }

//podemos ver que añadiendo el placeholder <Element> después del nombre del tipo y añadiendo el placeholder Element como tipo de dato cuando es requerido dentro del cuerpo de nuestro tipo.
//con esto nuestro objeto es genérico y puede trabajar con cualquier tipo de datos


//inicializacion de objeto genérico que recibe tipos Int

var stack = Stack<Int>()

//acceso a métodos del objeto
stack.push(1)
stack.push(2)
stack.push(3)



//inicializacion de objeto genérico que recibe tipos Int

var genericStack = Stack<String>()


//acceso a métodos del objeto

genericStack.push("SwiftBeta")
genericStack.push("Aprende Swift")
genericStack.push("Aprende a Crear Apps")



//Cabe señalar que son muchas las ventajas de los genéricos como es el evitar escribir código extra, pero es importante no abusar de esto e incrementar la dificultad
//podriamos hablar de genéricos en sus usos entre reducir código duplicado vs aumentar la dificultad






//restricciones de tipo usando genericos

//la flexibilidad de los genéricos es impresionante pero podemos también añadir restricciones. Esto significa que podemos limitar el tipo de datos, ejemplo cuando queremos sumar y solo debemos trabajar con datos numericos

//código erróneo de genérico
struct Calculator<Value> {
    func sum(a: Value, b: Value) -> Value {
        a + b
    }
}

//como mencionábamos este código anterior tiene un método el cual no puede ejecutarse debido a que el dato ingresado pueda ser un valor no numérico como String o Bool.
//para poder aplicar estas restricciones a los genéricos debemos hacer lo siguiente


//creacion de objeto con genérico y restricciones de tipo

struct Calculator<Value: AdditiveArithmetic> {
    func sum(a: Value, b: Value) -> Value {
        a + b
    }
}

//en este ejemplo el <value :> le indicamos que sea de tipo que conforme el protocolo AdditiveArithmetic, el cual nos permite funciones aritméticas, entonces con esto le aplicamos restricción a nuestro objeto genérico trabaje solo con tipos de datos que se puedan sumar o hacer funciones aritméticas, de lo contrario si ingresamos datos no numéricos como Bool o String nos arrojará un error



//podríamos ocupar la keyword where y hacer más conciso nuestro código

struct Calculator<Value> where Value: AdditiveArithmetic {
    func sum(a: Value, b: Value) -> Value {
        a + b
    }
}

//aquí podemos ver un código más claro y conciso de un objeto genérico el cual tiene un placeholder <value> que deberá conformar el protocolo AdditiveArithmetic el cual nos permite sumar, en resumen solo nos pide tipos de datos numéricos para poder trabajar en el objeto


//instancia de objeto genérico con restricción de tipo de dato

let calculator = Calculator<Int>()
print(calculator.sum(a: 2000, b: 3000))





//tipos asociativos

//también podemos usar genéricos en protocolos y para hacerlo debemos ocupar como placeholder la keyword associated types dentro del protocolo  y luego el nombre. Puede ser el nombre T, U como anteriormente le llamamos pero para esta ocasión le daremos un nombre más descriptivo, lo llamaremos Element


//creacion de protocolo genérico

protocol Stackeable {

    associatedtype Element              // 1
    var items: [Element] { get set }    // 2
    mutating func push(_ item: Element) // 3
    mutating func pop() -> Element      // 4
}

//para implementar un protocolo con datos genéricos debemos agregar el placeholder associated types seguido por el nombre que en nuestro caso será Element
//Luego en cada propiedad o método donde sea requerido el tipo de datos debemos agregar el Element creado
//este protocolo trae una propiedad y dos métodos los cuales debemos implementar en el tipo que conforme el protocolo




//creacion de tipo que conforma protocolo genérico

struct StackOfString: Stackeable {
    var items: [String]
    
    mutating func push(_ item: String) {
        items.append(item)
    }
    
    mutating func pop() -> String {
        items.removeLast()
    }
}


//creacion de instancia de objeto y utilización de métodos

var stackOfString = StackOfString(items: [])
stackOfString("[StackOfString] SwiftBeta")
stackOfString("[StackOfString] Aprende Swift")

//aquí vemos cómo creamos un protocolo genérico y el objeto que lo conforme puede con el tipo de datos deseado.
//En el objeto creado le indicamos que el tipo de datos a utilizar por el objeto será String pero si quisiéramos que la implementación de métodos y propiedades fuera de cualquier tipo de datos podríamos indicarle a nuestra estructura o nuestro tipo que sea genérica quedando asi


//creacion de objeto genérico que conforma protocolo genérico

struct Stack<Element>: Stackeable {
    var items: [Element]
    
    mutating func push(_ item: Element) {
        items.append(item)
    }
    
    mutating func pop() -> Element {
        items.removeLast()
    }
}


//instancia de objeto genérico que conforma protocolo genérico y utilización de métodos

var stack = Stack<String>(items: [])
stack.push("[Stack] SwiftBeta")
stack.push("[Stack] Aprende Swift")

print(stack.items)

stack.pop()



//Como has podido ver, los genéricos ayudan a reducir código pero pueden añadir más complejidad y también pueden dificultar la comprensión del código. Hay que intentar buscar el equilibrio y saber cuándo es mejor usar genéricos dentro de tu aplicación.
