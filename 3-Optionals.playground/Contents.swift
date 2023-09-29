import UIKit


//Opcionales
//creacion tipos de datos opcionales
var name: String? = nil
var anotherName: String?

// Tipos de la Librería Standard de Swift (cualquier tipo de datos en Swift puede ser opcional)
var myValue: Int? = nil
var myBool: Bool?
var myString: String?
var myDouble: Double?
// Tipos propios creados en tu aplicación
struct Car {
    var color : String = "black"
    func convert(color : String) -> Int {
        var safeColor : Int = 0
        if let colorNum = Int(color){
           safeColor = colorNum
        }
        return safeColor
    }
}
var myCar: Car?

struct User {
    var name : String
}
let follower: User?


//al trabajar con diccionarios siempre nos arroja un opcional que hay que verificar y desempaquetar para poder trabajar con el

//nil
var myStringNumber = "SwiftBeta"      // 1
var myNumber = Int(myStringNumber)
print(myNumber)
//correct
var myInt = "2500"
let myIntNumber = Int(myInt)
print(myIntNumber)


//ENLACE OPCIONAL
// El bloque de codigo que desempaqueta  se ejecuta siempre y cuando no sea nulo y automáticamente desempaqueta el dato opcional. guardandolo dentro de una nueva constante la cual contiene el dato desempaquetado.
if let safeOptional = myIntNumber{
    print(safeOptional)
}else {
    print("nil value")
}


//DESENVOLVIMIENTO FORZADO
//optional!  no recomendable ya que nos puede dar error
print(myIntNumber!)//correcto pero de forma incorrecta ya que no hay verificacion
//print(myNumber!)//crash


//OPERADOR DE FUSION NULA
// si el valor no es opcional entonces arroja un dato desempaquetado el cual ocuparemos dentro de una variable o consstante y si no es opcional entonces fijaremos un valor por defecto
var myNewNumber = myNumber ?? 0
var myNewIntNumber = myIntNumber ?? 0
print(myNewNumber)
print(myNewIntNumber)

//COMPROBACION DE VALORES NULOS
// El bloque de codigo que desempaqueta el valor opcional, se ejecuta siempre y cuando no sea nulo y para poder ocupar el dato tenemos que desempaquetarlo con !
if myIntNumber != nil{
    print(myIntNumber!)
}


//ENCADENAMIENTO OPCIONAL

print(myCar?.color)
myCar = Car()
print(myCar?.color)
print(myCar!.color)//metodo erroneo ya que no hay verificacion
print(myCar?.convert(color: "1234"))



//Extraer valor con un MAP
//myIntNumber?.map { print("value = \($0)")  }  CORREGIR EL LIBRO, NO SE PERMITE EL MAP
