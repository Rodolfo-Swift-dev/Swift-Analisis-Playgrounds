import Foundation

//Tuplas
//conjunto de elementos que tienen un orden y se puede acceder a ellos a traves de su indice. pueden ser de diferentes tipos de datos.
//es frecuente usar las tuplas como constantes aunque tambien pueden ser variables.

//las tuplas no incluyen metodos Sorted() comom el Array, pero si se pueden aplicar metodos o funciones de orden superior como el Sorted({closure}), en donde agregas la logica a traves de un closure


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
let (name1, apellido1, apellido2, _, _ ) = myUser

//extraer todos los datos de una tupla
var (name2, apellidoA, apellidoB, years,  married) = myUser

//tuplas nombradas
let (name, learn, language, score, isProUser) = ("Rodolfo", "Gonzalez", "Hernandez", 36, true)

//acceder a elementos de tupla segun su nombre
print(name)
print(learn)
print(language)
print(score)
print(isProUser)

// RESULTADO 👇
// Rodolfo
// Gonzalez
// Hernadez
// 36
// true

//tuplas con tuplas en su interior
let (names, age, phones) = (("martin", "ignacio"), 25, (92423423, 458393))



//casos de usos
//se recomienda usar con datos que esten relacionados emtre ellos
//Retorno multiple de funciones

func getData()-> (String, Int, Bool){
    //logica obtener datos
    return("Rodolfo", 36, true)
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

func sendMessage(destinatario: String, mensaje: String) {
    //logica para enviar mensaje
}

sendMessage(destinatario: "Rodolfo", mensaje: "Hola")


//valores relacionados

let coordenada = (latitud: 37.7, longitude: 38.4)


//Manejo de errores

func realizarOperacion() -> (resultado: Int?, error: String?) {
    //Logica de la operacion
    return (resultado: 36, error: nil)
}

let operacion = realizarOperacion()

if let resultado = operacion.resultado {
    print("Resultado: \(resultado)")
} else if let error = operacion.error {
    print("Error: \(error)")
}




