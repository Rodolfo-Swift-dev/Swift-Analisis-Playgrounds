import UIKit

//Funciones

//Bloque de código que se puede llamar en diferentes partes de nuestro programa.
//estas llevan nombre, parámetros o no, y puede retornar datos o no.
//si es que nuestra función recibe parámetros, tenemos por obligación indicarle el tipo de datos que van a ser cada parámetro.
//si es que nuestra función retorna datos, tenemos por obligación indicarle el tipo de datos que va a retornar

//crear una función
func add(a: Int, b: Int) -> Int {
    return a + b
}


//Mandar a llamar una funcion
add(a: 10, b: 2)

//o mandarla a llamar desde otra funcion o método
print(add(a: 10, b: 2))



//tipos de una función
//el tipo de una función es el tipo de datos de los parámetros y los tipos de datos de retorno
//(Int, Int) -> Int

//Funciones dentro de Variables o constantes
let math = add(a:b:)

//ahora podemos ocupar esa variable o constante  como una función
print(math(2,3))

func show(message : String, name: String)-> String {
    return message + " " + name + "!"
}
let message = show(message: "Hello", name: "SwiftBeta")
print(message)



//Funcion retorno de tuplas
//recomendable para el retorno de pocos valores, cuando son muchos valores se recomienda estructuras o clases
func getTuple ()-> (String, String) {
    let channel = "SwiftBeta"
    let action = "Suscríbete"
    return (channel, action)
}
let (channel, action) = getTuple()
print(channel)
print(action)



//Nombres de parámetros en funciones


//Funciones con parámetros internos y parámetros externos
//el primer nombre corresponde al parametro externo y se usará cuando sea llamada la función
//el segundo nombre corresponde al parametro interno que se usará dentro de la función, al momento de crearla.
func login(withUsername username: String,
           withPassword password: String) -> Bool {
          if username.count > 10 {
        return true
    } else {
        return false
    }
}
let isLogged = login(withUsername: "SwiftBeta", withPassword: "123456789")





//Omitir un nombre de parametro
//dentro de los parámetros podemos crear parámetros dentro de la función y si quisiéramos sin nombre externo tan solo escribiendo un guion bajo _ como parámetro externo

func validateUser(_ value: String) -> Bool {
    return value.count > 5
}
//luego al momento de llamar a la función se escribe directamente el parámetro sin su nombre
validateUser("SwiftBeta")




//Funciones con mismo nombre
//se puede tener 2 funciones con el mismo nombre en Swift, pero estas deben tener distinto tipo(tipos de datos de  parámetros)->tipo dato retorno

//func getTwoValues() -> (String, String)
//func getTwoValues(paramOne name: String, paramTwo surname: String) -> (String, String)




//valores por defecto parámetros de funciones
//en una función podemos crear parámetros con valores por defecto que en el momento de llamar la función no se ingresen datos al parametro, este tendrá valor por defecto que no puede ser modificado
func createDatabase(name: String, path: String = "/") {
    print(path)
}

//dos ejemplos de llamado a la función  con uno sin indicar valor de parámetro por lo que se ocupará valor por defecto y el otro ejemplo indicando valor de parámetro

createDatabase(name: "SwiftBeta")
createDatabase(name: "SwiftBeta", path: "/users/root")




//Parametros Variadic en funciones
//usamos estos parámetros cuando queremos ingresar como valor a un parametro en el llamado de la función, más de 1 valor
func validate(names: String...) {
    print("Names \(names)")
}

validate(names: "SwiftBeta", "Suscríbete al Canal", "Youtube")

//señalando que el parametro sea de tipo arreglo de datos sería el equivalente a un parametro varíadic
print(validate())

func validates(names: [String]) {
    print("Names \(names)")
}
validates(names: ["SwiftBeta", "Suscríbete al Canal", "Youtube"])



//parametros InOut en funciones
//podemos modificar el dato de parámetro que ingresemos siempre y cuando ocupemos la siguiente sintaxis de inout y &
func validate(names: inout [String]) {
    names = ["SwiftBeta", "SwiftUI", "Swift"]
    print("Names \(names)")
}
var arrayOfNames = ["UIKit"]
validate(names: &arrayOfNames)

//Ocupando la Keyword input andes del tipo de dato en el parametro cuando estamos creando la función
//Ocupando el signo & antes del parametro cuando estamos llamando a la funcion
//con esto podemos acceder al valor de un parametro dentro de una función y poder modificarlo




//Funciones dentro de funciones
//podemos crear funciones dentro de funciones, las cuales solo podrán ser llamada dentro de la misma función,  no fuera

func validate(password: String) {
    if password.count > 5 {
        printSuccess()
    } else {
        printError()
    }
    func printSuccess() {
        print("Valid Password")
    }
    func printError() {
        print("Error")
    }
}
validate(password: "SwiftBeta")
//este es un ejemplo para ver lo flexibles que son las funciones en Swift, pero no es muy recomendable ya que es mejor crear tipos para mejorar la lógica del programa y clases y estructuras para organizar mejor el código
