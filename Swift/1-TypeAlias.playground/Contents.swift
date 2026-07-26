//Typealias crea un nombre alternativo para un tipo existente y ayuda a expresar
//mejor la intención del código. No crea un tipo nuevo ni agrega seguridad de tipos:
//Celsius continúa siendo exactamente el mismo tipo que Double.
//Error frecuente: usar typealias esperando validación o una identidad distinta.

//var temperature: Double = 12.2
typealias Celsius = Double
var temperature: Celsius = 12.2

typealias CharacterName = String
var name: CharacterName = "Rodolfo"

typealias ClosedQuantity = Int
var fruits: ClosedQuantity = 5

//Los alias siguen la convención de nombres de los tipos: UpperCamelCase.
//Son especialmente útiles para firmas complejas o para expresar unidades y dominio,
//pero Celsius y Double se pueden asignar entre sí porque representan el mismo tipo.
temperature = 18.5
print(temperature, name, fruits)

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
