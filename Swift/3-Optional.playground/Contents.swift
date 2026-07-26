//Opcionales
//Error frecuente: usar ! sin una garantía verificable; nil provoca un trap.
//creacion tipos de datos opcionales
let name: String? = nil
let anotherName: String? = nil

// Tipos de la Librería Standard de Swift (cualquier tipo de datos en Swift puede ser opcional)
let myValue: Int? = nil
let myBool: Bool? = nil
let myString: String? = nil
let myDouble: Double? = nil
print(
  name as Any, anotherName as Any, myValue as Any, myBool as Any, myString as Any, myDouble as Any)

let myStringNumber = "Rodolfo"
if let myNumber = Int(myStringNumber) {
  print(myNumber)
} else {
  print("\(myStringNumber) is not number")
}

let myInt = "2500"
if let myIntNumber = Int(myInt) {
  print(myIntNumber)
} else {
  print("\(myInt) is not number")
}

//ENLACE OPCIONAL
// El bloque de codigo que desempaqueta  se ejecuta siempre y cuando no sea nulo y automáticamente desempaqueta el dato opcional. guardandolo dentro de una nueva constante la cual contiene el dato desempaquetado.
if let safeOptional = Int(myInt) {
  print(safeOptional)
} else {
  print("nil value")
}

//DESENVOLVIMIENTO FORZADO
//`optional!` afirma que existe un valor. Si el Optional contiene nil, el programa
//se detiene. En código normal, prefiere optional binding, guard o nil-coalescing.
//let unsafeNumber = Int(myInt)! // Compila, pero la afirmación puede ser falsa.
if let number = Int(myInt) {
  print(number)
}

//OPERADOR DE FUSIÓN NULA (nil-coalescing)
//a ?? b devuelve el valor desempaquetado de a cuando a no es nil. Si a es nil,
//devuelve el valor alternativo b. El resultado deja de ser opcional.
let myNewNumber = Int(myInt) ?? 0
let myStringNum = "2500"
let myNewIntNumber = Int(myStringNum) ?? 0
print(myNewNumber)
print(myNewIntNumber)

//COMPROBACION DE VALORES NULOS
//Optional binding comprueba y extrae el valor en una sola operación. Dentro del
//bloque se usa la constante no opcional sin aplicar `!`.

let myOptionalInt = Int(myStringNum)
if let myOptionalInt {
  print(myOptionalInt)
}

// Tipos propios creados en tu aplicación

struct Car {
  var color: String = "black"

  func colorCode(from value: String) -> Int? {
    Int(value)
  }
}
var myCar: Car?

//al trabajar con diccionarios siempre nos arroja un opcional que hay que verificar y desempaquetar para poder trabajar con el

//nil
//ENCADENAMIENTO OPCIONAL

print(myCar?.color ?? "blue")
myCar = Car()

//El encadenamiento opcional evita depender del orden de asignación o de un force unwrap.
print(myCar?.color ?? "Color desconocido")
if let color = myCar?.color {
  print(color)
}

if let safeColor = myCar?.colorCode(from: "1234") {
  print(safeColor)

}

//Guard let
//muy interesantes y muy comunes al crear lógica de la aplicacion
//podemos ocupar la sentencia Guard let para extraer el valor de un opcional de forma segura y almacenarlo en una constante
let myOptional: Int? = 2
func checkMyOptional(_ optional: Int?) {
  guard let value = optional else {
    print("myOptional is nil!")
    return
  }
  print("myOptional value is \(value)!")
}
checkMyOptional(myOptional)

//Transformar o consumir un Optional con map
//Optional sí implementa map. Se escribe .map, no ?.map: map opera sobre el
//contenedor Optional y ejecuta el closure solamente cuando existe un valor.
let parsedNumber = Int(myInt)
let doubledNumber = parsedNumber.map { $0 * 2 }
parsedNumber.map { print("value = \($0)") }
print(doubledNumber ?? 0)
