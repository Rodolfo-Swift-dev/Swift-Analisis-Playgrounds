import UIKit

//Extensiones
//las extensiones nos permiten añadir funcionalidad a los tipos( Struct, Class y Enum), protocolos y tipos de datos(String, Folat, Int…)

//las extensiones en Seift no llevan nombres

//para crear una extensión debemos ocupar la keyword extension seguido por el tipo, tipo de dato o protocolo que vamos a extender


//creacion extensión de tipo de dato String que añade método de concatenar String a otro String

extension String {
    mutating func concatenateSwiftBeta() {
        self = self + " ¡Suscríbete a SwiftBeta! 🚀"
    }
}

//en este ejemplo podemos ver cómo hacemos uso de la extensión para ampliar el tipo de dato String y añadir la funcionalidad a través de un método de a un String le añadamos una cadena de caracteres



//creacion de variable de tipo de dato String y uso de método de extensión de tipo de dato

var myString = "User"
myString.concatenateSwiftBeta()
print(myString)

//esto es muy útil poder extender funcionalidad de tipos de datos que no tenemos el codigo



//creacion extensión de tipo de dato Int que añade método de  sumar Int a otro Int

extension Int {
    func add(b: Int) -> Int {
        return self + b
    }
}



//uso de método de extensión de tipo de dato

print(4.add(b: 10))

// RESULTADO 👇
// 14

//a través de notación de punto y tras crear la extensión con sus métodos es que podemos acceder estos métodos con nuevas funcionalidades





//extender tipos

//podemos extender tipos (Struct, Class y Enum) para añadirle funcionalidad extra, aunque hayan sido creado estos tipos por nosotros


//creacion de tipo

struct User {
    var name: String
    
    mutating func update(name: String) {
        self.name = name
    }
    
    mutating func reset() {
        self.name = ""
    }
}


//creacion de tipo sin método reset, el cual será añadido por una extensión

struct User {
    var name: String
    
    mutating func update(name: String) {
        self.name = name
    }
}

extension User {
    mutating func reset() {
        self.name = ""
    }
}


//ambos códigos anteriores tanto como con extensión como sin extensión serían equivalentes ya que en la extensión creamos un método reset y tal extensión se la asignamos al tipo que hemos creado


//instancia de objeto con extensión o sin extensión ya que serían equivalentes

var anotherUser = User(name: "SwiftBeta")
anotherUser.reset()





//Extension de tipos y propiedades computadas

//anteriormente hemos visto extensión pero incluyendo solo métodos, cabe señalar que también podemos incluir propiedades siempre y cuando sean propiedades computadas


//creacion de tipo

class Database {
    var name: String
    
    init(name: String) {
        self.name = name
    }
}


//creacion de extension de tipo que me añade propiedad computada

extension Database {
    var path: String {
        "/home/Desktop/"
    }
}


//instancia de objeto que accede a método de extensión de tipo

let database = Database(name: "Users")
print(database.path)


//tener presente que podemos extender tanto métodos como propiedades en nuestros tipos, las propiedades siempre y cuando sean computadas





//Extender tipos con métodos de tipos

//aquí veremos como podemos usar extensiones de tipo con métodos de tipo, los cuales se pueden llamar directamente sin necesidad de Instanciar el tipo


//creacion de tipo u objeto

struct User {
    var name: String
}


//creacion de extension de tipo con método de tipo

extension User {
    static func getUserDatabase() -> String {
        return "/path/database/user.sql"
    }
}


//uso métodos de tipo, los cuales se pueden llamar directamente sin necesidad de Instanciar el tipo

print(User.getUserDatabase())






//extender tipos con inicializadores

//veremos cómo extender un tipo con inicializadores


//creacion de tipo con propiedades

struct User {
    let name: String
    let youtubeChannel: String
    let twitter: String
}


//instancia de tipo con inicializadores

let swiftbeta = User(name: "SwiftBeta",
                     youtubeChannel: "@swiftbeta",
                     twitter: "swiftbeta_")


//aqui estamos instanciando un objeto con inicializadores por defecto pero podemos hacer inicializadores extra para nuestros tipos


//creacion de extensión de tipo con inicializador

extension User {
    init(swiftbetaName: String = "SwiftBeta",
         youtubeChannel: String = @swiftbeta",
         twitter: String = "swiftbeta_") {
        self.init(name: swiftbetaName, youtubeChannel: youtubeChannel,
                  twitter: twitter)
    }
}


//instancia de objeto que tiene extensión con inicializador

let newSwiftBeta = User()
print(newSwiftBeta)

// RESULTADO 👇
// User(name: "SwiftBeta", youtubeChannel: "@swiftbeta", twitter: "swiftbeta_")






//extender protocolos

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
//cabe señalar que en este ejemplo el valor de la propiedad del protocolo la debemos implementar en el tipo, no en la extension debido a que de


//instancia de objeto que conforma protocolo

let user = User()
user.printResult()

//en la extension del protocolo podemos implementar solo los métodos requeridos, no las propiedades, para implementar estas debemos implementarlas en el tipo.

//cabe señalar que si tenemos un método implementado en una extensión del protocolo y además el mismo método lo implementamos en el tipo, luego de Instanciar el tipo y acceder a sus métodos al método que accederá será el del tipo, no el de la extension(como que existiera una jerarquia)




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


