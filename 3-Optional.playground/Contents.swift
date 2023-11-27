import Foundation


//Opcionales
//creacion tipos de datos opcionales
var name: String? = nil
var anotherName: String?

// Tipos de la Librería Standard de Swift (cualquier tipo de datos en Swift puede ser opcional)
var myValue: Int? = nil
var myBool: Bool?
var myString: String?
var myDouble: Double?





var myStringNumber = "Rodolfo"
if let myNumber  = Int(myStringNumber){
    print(myNumber)
}else {
    print("\(myStringNumber) is not number")
}


var myInt = "2500"
if let myIntNumber = Int(myInt){
    print(myIntNumber)
}else {
    print("\(myInt) is not number")
}



//ENLACE OPCIONAL
// El bloque de codigo que desempaqueta  se ejecuta siempre y cuando no sea nulo y automáticamente desempaqueta el dato opcional. guardandolo dentro de una nueva constante la cual contiene el dato desempaquetado.
if let safeOptional = Int(myInt){
    print(safeOptional)
}else {
    print("nil value")
}


//DESENVOLVIMIENTO FORZADO
//optional!  no recomendable ya que nos puede dar error
if Int(myInt) != nil{
    print(Int(myInt)!)
}
//correcto pero de forma incorrecta ya que no hay verificacion
//print(myNumber!)//crash


//OPERADOR DE FUSION NULA
// si el valor no es opcional entonces arroja un dato desempaquetado el cual ocuparemos dentro de una variable o constante y si no es opcional entonces fijaremos un valor por defecto
var myNewNumber = Int(myInt) ?? 0
var myStringNum = "2500"
var myNewIntNumber = Int(myStringNum) ?? 0
print(myNewNumber)
print(myNewIntNumber)

//COMPROBACION DE VALORES NULOS
// El bloque de codigo que desempaqueta el valor opcional, se ejecuta siempre y cuando no sea nulo y para poder ocupar el dato tenemos que desempaquetarlo con !

var myOptionalInt = Int(myStringNum)
if myOptionalInt != nil{
    print(myOptionalInt!)
}


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
//ENCADENAMIENTO OPCIONAL

print(myCar?.color ?? Car(color: "blue"))
myCar = Car()

print(myCar!.color)//metodo erroneo ya que no hay verificacion y nos puede arrojar un error
if let color = myCar?.color {
    print(color)
}

if let safeColor = myCar?.convert(color: "1234"){
    print(safeColor)

}



//Guard let
//muy interesantes y muy comunes al crear lógica de la aplicacion
//podemos ocupar la sentencia Guard let para extraer el valor de un opcional de forma segura y almacenarlo en una constante
var myOptional: Int? = 2
func checkMyOptional() {
    guard let value = myOptional else {
        print("myOptional is nil!")
        return
    }
    print("myOptional value is \(value)!")
}
checkMyOptional()


//Extraer valor con un MAP
//myIntNumber?.map { print("value = \($0)")  }  CORREGIR EL LIBRO, NO SE PERMITE EL MAP
