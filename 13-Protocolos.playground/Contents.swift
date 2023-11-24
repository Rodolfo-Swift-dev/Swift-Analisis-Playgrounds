import UIKit

//Protocolos

//Un protocolo en Swift define métodos y propiedades que deben ser implementados en una Class, Struct o Enum. Los protocolos también son llamados interfaces o contratos

//Un protocolo es un contrato que se debe cumplir, ¿quién debe cumplirlo? El tipo que conforma el protocolo.

//Sintaxis de un protocolo

//creacion de protocolo

protocol NameProtocol {
}

//con el protocolo ya creado es que podemos usarlo adoptándolo por un tipo después de su nombre seguido por : el nombre del protocolo


//creacion de un tipo que a adopta el n protocolo

struct User: MyProtocol {
    var age: Int
}

//aqui podemos ver que la Struct conforma el protocolo creado


//creacion de tipo que adopta varios protocolos

protocol AnotherProtocol { }

protocol SwiftBetaProtocol { }

struct Student: MyProtocol, AnotherProtocol, SwiftBetaProtocol {
    
}





//conformar protocolo en una subclase

//cuando tenemos una subclase que hereda de una superclase y además queremos adoptar protocolos, por obligación tenemos que adoptar la herencia y luego los protocolos si no nos ocasiona un error.

class Superclass { }
protocol MyProtocol { }
protocol AnotherProtocol { }

class Subclass: Superclass, MyProtocol, AnotherProtocol {

}


//cabe señalar que si los protocolos adoptados tienen métodos o propiedades, debemos implementarlos en nuestras clases que adoptan los protocolos cada uno que tenga sin omitir alguno, de lo contrario tendremos un error





//Protocolo con propiedades

//Dentro de nuestro protocolo podemos crear propiedades de instancia y propiedades de tipo, cabe señalar que es necesario implementar cada propiedad del protocolo en la clase que lo conforma.

//al crear una propiedad dentro del protocolo tenemos que especificar si la propiedad puede ser leida y escrita o solo leída a través de las keyword get y set

//cabe destacar que cuando se crea el protocolo y sus propiedades, en las propiedades tan solo debemos indicarle el nombre y el tipo de datos

//creacion de protocolo con propiedades de instancia

protocol MyProtocol {
    var propertyOne: String { get set }
    var propertyTwo: Int { get }
}


//creacion de protocolo con propiedades de tipo

protocol MyOtherProtocol {
    static var propertyOne: Int { get set }
}


//creacion de protocolo con propiedades de instancia que podemos escribir datos

protocol Shippeable {
    var street: String { get }
    var city: String { get }
    var zip: String { get }
}



//creacion de estructura que adopta protocolo creado

struct Product: Shippeable {
    var id: String
    var name: String
    var street: String
    var city: String
    var zip: String
}

//podemos darnos cuenta que la estructura creada contiene 2 propiedades y otras 3 propiedades que tomamos del protocolo y de las que estamos obligados a implementar al momento de adoptar el protocolo



//instancia de objeto que adopta protocolo

let product = Product(id: "1",
                      name: "SwiftBeta",
                      street: Apple Street",
                      city: "SwiftBetaLand",
                      zip: "0000")






//Protocolo con métodos

//Dentro de nuestro protocolo podemos crear métodos de instancia y métodos de tipo, cabe señalar que es necesario implementar cada método del protocolo en la clase que lo conforma.

//cabe destacar que cuando se crea el protocolo y sus metodos, en las método tan solo debemos indicarle  el tipo de datos y luego en el tipo que conforma el protocolo implementar la logica



//creacion de protocolo con método

protocol Calculable {
    func calculate() -> String
}


//creacion de estructura que conforme protocolo

struct Calculator: Calculable {
    func calculate() -> String {
        return "Some value..."
    }
}



//conformar protocolos con métodos que su implementación no sea obligatoria

//podemos crear métodos en protocolos y en donde se conforme el protocolo tenemos la opción de que algunos métodos no sea obligatoria su implementación. Para esto es necesario
//1. Solo funciona en las clases y no en las Struct
//2. Antes de crear el protocolo debemos agregar la keyword @objc
//3. Antes del método que no queremos que sea obligatoria su implementación debemos agregar las keywords @objc optional



//creacion de protocolo que tiene métodos que no es obligatoria su implementación en el tipo que lo conforme

@objc
protocol Printable {
    @objc optional func printResult() -> String
}


//creacion de tipo que conforme protocolo con métodos sin implementación obligatoria

class Logger: Printable {

}


//instancia de objeto que adopta protocolo

let logger = Logger()



//cabe señalar que los parámetros dentro de los métodos de nuestro protocolo solo puede llevar el nombre y el tipo de datos que ingresa y retorna pero nunca valores o valores por defecto






//Protocolo con inicializadores

//los protocolos también pueden especificar la implementación de inicializadores


//creacion protocolo con inicializadores

protocol Initializable {
    init(parameterOne: String, parameterTwo: Int)
}


//creacion objeto que conforma protocolo

struct User: Initializable {
    init(parameterOne: String,
parameterTwo: Int) {
        // Create initializer
    }
}


//instancia de objeto que conforma protocolo con inicializadores

let user = User(parameterOne: "SwiftBeta",
                parameterTwo: 10)





//Extensiones

//un protocolo puede tener propiedades o métodos, los cuales deben implementarse de forma obligatoria. Existen 3 formas de implementación

//1. Implementación del tipo que conforma el protocolo
//aqui implementamos métodos y propiedades en la clase o Struct que conforma el protocolo

//2. Implementacion dentro de una extensión del tipo que conforma el protocolo

//3. Implementacion dentro de una extensión del propio protocolo




//Extensiones

//en Swift podemos crear extensiones de un tipo y mover allí su lógica de implementacion


//tipo sin extensión

class Database {
    func connect() {
        print("Connected")
    }

    func addData() {
        print("Add Data")
    }

    func removeData() {
        print("Remove Data")
    }
}


//tipo con extensión

class Database {

}

extension Database {
    func connect() {
        print("Connected")
    }

    func addData() {
        print("Add Data")
    }

    func removeData() {
        print("Remove Data")
    }
}

//aqui podemos ver que la lógica de nuestro tipo la hemos trasladado hacia nuestra extensión creada, además del nombre del tipo que es esta extensión


//instancia de objeto con funcionalidades extendidas

let database = Database()

database.connect()
database.addData()
database.removeData()






//extensiones con protocolos

//a la hora de usar protocolos y extensions, tenemos 3 opciones. Una es añadir las implementaciones del protocolo al interior de un extensión directamente del protocolo (por defecto), añadir implementación del protocolo directamente en el tipo o añadir implementaciones del protocolo al interior de una extensión del tipo que conforma el protocolo





//extensiones en protocolos

//De esta manera no tendremos que crear la misma implementación en cada tipo que conforme el protocolo

//creacion protocolo

protocol Printable {
    var information: String { get }
    func printResult()
}

//creacion extension de protocolo

extension Printable {
    func printResult() {
        print("Message from Protocolo Extension \(information)")
    }
}

//creacion objeto que conforma el protocolo

struct User: Printable {
    var information: String { "SwiftBeta" }
}
//cabe señalar que en este ejemplo el valor de la propiedad del protocolo la debemos implementar en el tipo, no en la extension


//instancia de objeto que conforma protocolo

let user = User()
user.printResult()





//Extension en tipos que conforman protocolos

//creacion protocolo

protocol Printa {
    var information: String { get }
    func printResult()
}


//creacion objeto que conforma el protocolo

struct User1: Printa {
    var information: String { "SwiftBeta" }
}

//cabe señalar que en este ejemplo el valor de la propiedad del protocolo la debemos implementar en el tipo, no en la extension


//creacion extensión de tipo que conforma protocolo

extension User1 {
    func printResult() {
        print("Message from Protocolo Extension \(information)")
    }
}

//instancia de objeto que conforma protocolo

let user1 = User1()
user.printResult()

