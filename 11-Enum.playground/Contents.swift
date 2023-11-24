import UIKit

//Enums

//Aparte de crear tipos en Swift con Struct y Class también podemos crear tipos con Enums






//Sintaxis

enum clima {
case sol
case lluvia
case nublado
}

//Dentro del Enum podemos definir diferentes estados que queremos usar dentro de nuestro nuevo tipo y se llamarán case.
//con esto podemos aplicar distintas lógicas de código en distintos cases.
//es altamente recomendable utilizar los enum en conjunto con switch





//Instancia de un enum

let climaStatus = clima.sol



//Instancia de  un enum señalando su tipo

Let climaStatus1 : clima = .sol

//con este último ejemplo lo instanciamos indicando su tipo, lo que nos permite asignarle cualquier clase dentro de este tipo


//Enum con inicializador

enum clima {
case sol
case lluvia
case nublado
init (isRain: Bool){
        If isRain {
self = .lluvia
}else {
self = .sol
}
}
}

let clima = clima( isRain : true)
print ( clima)

// RESULTADO 👇
// lluvia

//un enum a pesar de ser un tipo como Class o Struct no necesita inicializacion para poder utilizar el enum, podemos asignar directamente el case de un Enum a una constante o variable




//Enum con Switch

enum clima {
case sol
case lluvia
case nublado
}

let climaActual = clima.sol

switch climaActual {

case .sol :
      print("Lindo dia")
case .lluvia :
      print("Húmedo y mojado")
case .nublado :
      print("frío y viento")

}

En ocasiones también podemos agrupar distintos case dentro de un bloque de codigo

let climaActual1 = clima.sol

switch climaActual1 {

case .sol :
     break
case .lluvia, case .nublado:
      print("Húmedo y mojado")

}


//También podríamos ocupar la keyword break dentro de un case, así indicándole que no queremos implementar ningún tipo de lógica de codigo. En este caso si se llegara a ejecutar el case .sol se ejecutará el break y salimos del scope del código y continuamos con el resto de control de flujo.

//en vez de un switch también podríamos  ver los valores del enum con sentencia if y de esta forma podríamos ver el valor o los valores como nosotros queramos, a diferencia  del switch, que me evalúa el total de posibles valores del enum.

if messageStatus == .sent {
    print("Message Sent (If Statement)")
}





//Enum y Default Case

//como mencionábamos anteriormente el switch evalúa todos los posibles valores, pero además podemos implementar un case que es por defecto. Cuando aplicamos el case por defecto podemos incluir algunos cases con posibles valores y en el case por defecto cubrirá todos los cases que no hayan sido cubiertos.

//ejemplo de implementación de Enum con Switch con case default

enum MessageStatus {
    case sent
    case received
    case read
}

let messageStatus = MessageStatus.sent

switch messageStatus {
    case .received:
        print("Message Received")
    default:
        print("Other value")
}






//Metodos y propiedades dentro de un Enum

//al crear un Enum podemos crear métodos de instancia, métodos de tipo y propiedades computadas

//creacion de Enum con método de tipo, método de instancia y propiedad computada

enum CompassPoint {
    case north
    case south
    case east
    case west
    
    // Propiedad
    var owner: String { "SwiftBeta" }

    // Método de Instancia
    func printValue() -> String {
        "Value: Método de Instancia"
    }
    
    // Método de Tipo
    static func printMessage() -> String {
        "Message: Método de tipo"
    }
}

//Ahora podemos crear una constante con el valor de un case de nuestro Enum. De esta manera podemos llamar a la propiedad computada y al método de instancia y además podemos llamar al método de tipo

let compassPoint: CompassPoint = .north
compassPoint.owner
compassPoint.printValue()

// RESULTADO 👇
// SwiftBeta
// Value: Método de Instancia


“CompassPoint.printMessage()
// RESULTADO 👇
// Message: Método de tipo”





//Enum con tipo de valor

//los Enum son de tipo de valor, es decir los cambios realizados en una de sus copias no se ve reflejado en las demás.

enum Move {
    case top
    case right
    case bottom
    case left
}

//instancia del enum
var firstMove = Move.top

//creamos variables y asignamos valor firstMove
var secondMove = firstMove
var thirdMove = firstMove

//cambiamos valor de una variable
secondMove = .right

//si verificamos con un print podremos darnos cuenta que el cambio no afecta a las demás copias. si fuera una clase el cambio se vería reflejado en las demás copias.





//Iterar sobre los cases de un Enum

//como Enum es un tipo podemos también adoptar protocolos y uno utilizado especialmente en los Enum es CaseIterable, el cual de muchas funcionalidades y propiedades como el código a continuación donde accedemos a allCases

//Enum con protocolo CaseIterable
enum Week: CaseIterable {
    case monday
    case tuesday
    case wednesday
    case thursday
    case friday
    case saturday
    case sunday
}

//sin inicializar
Week.allCases.forEach { print($0) }

//Con inicializacion
let numberOfDays = Week.allCases.count
print("Week days: \(numberOfDays)")





//Enum con Valores asociados

//a veces por necesidad en nuestros Enum debemos agregar parámetros de entrada(puedan recibir valores) al interior de nuestros case, similar a los parámetros de funciones

//Enum con valores asociados y nombres(number, digits, cvv
enum Field {
    case name(String)
    case street(String)
    case phone(number: String)
    case creditCard(digits: String, cvv: Int)
}


//Inicializacion de Enum con valores asociados

let creditCardField = Field.creditCard(digits: "1234 5678 9012", cvv: 123)


//Implementacion Switch y Enum con valores asociados

switch creditCardField {
case .creditCard(digits: let digits, cvv: _):
    print("Credit Card: \(digits)")
default:
    print("Do nothing...")
}

//en el ejemplo anterior tomamos un valor de parámetro y lo guardamos dentro de una constante la cual ocupamos en el print y también omitimos capturar un valor asociado con el signo _





//Enum con Raw Value

//también podemos dentro de nuestros Enum, agregar case con valores por defecto.
//para poder hacer RawValue, es necesario que el tipo de dato de todos los cases deben ser del mismo tipo

//Enum con RawValue

enum Parameter: String {
    case query = "El Libro de Swift"
    case limit = "50"
    case author = "SwiftBeta"
}


//Inicializacion de Enum con RawValue

let parameter = Parameter.query.rawValue
let limit = Parameter.limit.rawValue
let author = Parameter.author.rawValue

print(parameter)
print(limit)
print(author)

// RESULTADO 👇
// Libro swift
// 50
// SwiftBeta”

//para poder acceder a un Enum con propiedades RawValue, es necesario que todos los cases sean del mismo tipo de datos


enum Planet: Int {
    case mercury = 1, venus, earth, mars, jupiter, saturn, uranus, neptune
}

//en este código podemos ver como como fijando 1 solo valor por defecto, el resto de los cases asumirán un valor incrementado en 1 para cada 1

let mercury = Planet.mercury.rawValue
let earth = Planet.earth.rawValue
let neptune = Planet.neptune.rawValue

print(mercury)
print(earth)
print(neptune)

// RESULTADO 👇
// 1
// 3
// 8
