import Foundation

//Type alias es como un sinonimo y sirve para la claridad del codigo (sintaxis mas acorde)

//var temperature: Double = 12.2
typealias Celsius = Double
var temperature: Celsius = 12.2

typealias character = String
var name : character = "rodolfo"

typealias cantidadCerrada = Int
var frutas : cantidadCerrada = 5


//El uso del typeAlias es util cuando deseas proporcionar un nombre mas descriptivo o conciso para un tipo existente, o cuando deseas abstractarizar ciertos detalles de implementacion al trabajar con tipos complejos


//Definicion de un tipo de dato
struct User {
    var name: String
    var age: Int
}

//Creacion de un alias para el tipo User
typealias Client = User

//Uso del alias para crear una instancia
let newClient = Client(name: "Rodolfo", age: 36)

//Acceso a los miembros utilizando el alias
print("Name: \(newClient.name), Age: \(newClient.age)")
