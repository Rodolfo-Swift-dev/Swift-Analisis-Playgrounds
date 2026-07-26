//Tuplas
//conjunto de elementos que tienen un orden y se puede acceder a ellos a traves de su indice. pueden ser de diferentes tipos de datos.
//es frecuente usar las tuplas como constantes aunque tambien pueden ser variables.

//Una tupla agrupa una cantidad fija de valores, pero no conforma Sequence ni
//Collection. Por eso no se puede llamar sorted, map o filter directamente sobre
//ella. Si necesitamos recorrer u ordenar elementos homogéneos, debemos usar Array.
//Error frecuente: intentar aplicar sorted, map o filter directamente a una tupla.

//acceder a elementos de tupla segun su posicion
let myUser = ("Rodolfo", "Gonzalez", "Hernandez", 36, true)

print(myUser.0)
print(myUser.1)
print(myUser.2)
print(myUser.3)
print(myUser.4)

// RESULTADO 👇
// Rodolfo
// Gonzalez
// Hernadez
// 36
// true

//extraer ciertos datos de una tupla
let (firstName, firstSurname, secondSurname, _, _) = myUser
print(firstName, firstSurname, secondSurname)

//extraer todos los datos de una tupla
let (givenName, paternalSurname, maternalSurname, years, married) = myUser
print(givenName, paternalSurname, maternalSurname, years, married)

//tuplas nombradas
let (profileName, familyName, secondFamilyName, score, isProUser) =
  ("Rodolfo", "Gonzalez", "Hernandez", 36, true)

//acceder a elementos de tupla segun su nombre
print(profileName)
print(familyName)
print(secondFamilyName)
print(score)
print(isProUser)

// RESULTADO 👇
// Rodolfo
// Gonzalez
// Hernadez
// 36
// true

//tuplas con tuplas en su interior
let (names, age, phones) = (("martin", "ignacio"), 25, (92_423_423, 458393))
print(names, age, phones)

//casos de usos
//se recomienda usar con datos que esten relacionados emtre ellos
//Retorno multiple de funciones

func getData() -> (String, Int, Bool) {
  //logica obtener datos
  return ("Rodolfo", 36, true)
}

let results = getData()
print(results.0)
print(results.1)
print(results.2)

//Inicializacion compacta de objetos

let point = (x: 10, y: 20)
print(point.x)
print(point.y)

//Parametros etiquetados en funciones

func sendMessage(to recipient: String, message: String) {
  print("To \(recipient): \(message)")
}

sendMessage(to: "Rodolfo", message: "Hello")

//valores relacionados

let coordinate = (latitude: 37.7, longitude: 38.4)
print(coordinate.latitude, coordinate.longitude)

//Las tuplas son útiles para retornar varios valores relacionados, pero no es
//recomendable representar errores con una tupla (resultado: T?, error: Error?).
//Ese diseño permite estados inválidos: ambos valores podrían ser nil o no nil.
//Para errores recuperables usamos throws; Result es otra alternativa cuando
//necesitamos almacenar o transportar el resultado.

enum OperationError: Error {
  case divisionByZero
}

func performDivision(_ dividend: Int, by divisor: Int) throws -> (quotient: Int, remainder: Int) {
  guard divisor != 0 else {
    throw OperationError.divisionByZero
  }
  return (dividend / divisor, dividend % divisor)
}

do {
  let operation = try performDivision(36, by: 5)
  print("Quotient: \(operation.quotient), remainder: \(operation.remainder)")
} catch OperationError.divisionByZero {
  print("Cannot divide by zero")
}
