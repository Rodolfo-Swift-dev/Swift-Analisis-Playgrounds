//Control Flow
//Error frecuente: crear un ciclo cuya condición nunca cambia o un switch que no
//cubre todos los casos posibles.

//If
//control de flujo en donde evaluamos una condición y si esta es verdadera  se ejecutará el código entre { }. Cabe señalar que si la condición a evaluar es falsa entonces podremos agregar o no, una cláusula else.
for condition in [true, false] {
  if condition {
    print("condition is true")
  } else {
    print("condition is false")
  }
}

//Else If
// la cláusula else If ejecuta el bloque de código dentro de las { }, siempre y cuando la condición del If sea falsa y la condición del actual Else If sea verdadera.
//si tuviera varios ELSE IF, se ejecuta por orden desde el principio y se activará el código de la primera condición Else If que sea true, y si no es true se saltará al siguiente bloque de código.
for numberOfSubscribers in [12, 8, 3] {
  if numberOfSubscribers > 10 {
    print("A lot of subscribers!")
  } else if numberOfSubscribers > 5 {
    print("We need more subscribers!")
  } else {
    print("Keep working!")
  }
}

//Else
// la cláusula else ejecuta el bloque de código dentro de las { }, siempre y cuando la condición del If sea falsa y si tuviera ELSE IF también tendrían que ser falsas.
//cabe señalar que el Else se ejecuta sin consultar ninguna condición, solo que no se cumplan condiciones anteriores.
//el bloque Else es opcional de nosotros si queremos ocuparlo ya que no es obligación
for isUserLoggedIn in [true, false] {
  if isUserLoggedIn {
    print("Muestra el contenido de la app")
  } else {
    print("Muestra el login")
  }
}

//Modo de uso
//siempre se comienza con un IF y solo uno ya que si hay más, cada If es independiente del otro
//luego de un If podemos agregar las cláusulas ELSE IF que nosotros queramos para evaluar distintas condiciones
//por último podemos agregar una condición ELSE que se ejecutará siempre y cuando no se haya activado un bloque If ni un bloque Else If, además este Else se ejecutará de forma automática sin evaluar condición.

//Guard
//este código nos permita salir de la EJECUCION de un bloque de código { } o un SCOPE cuando NO se cumple una condición y si se cumple la función se saltará el bloque de código  Else, de retorno y ejecutará el siguiente codigo
//utiles limpios y concisos
let myArray: [String] = []
func checkMyArray(_ values: [String]) {
  guard !values.isEmpty else {
    print("Array is empty!")
    return
  }
  print("Array is NOT empty!")
}
checkMyArray(myArray)

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

//Switch
//Un switch debe ser exhaustivo: todos los valores posibles deben quedar cubiertos.
//default es útil como caso restante, pero no es obligatorio cuando enumeramos todos
//los casos, como sucede con MessageStatus más abajo.
for subscriberCount in [100, 50] {
  switch subscriberCount {
  case 100:
    print("A bunch of subscribers! 🤓")
  default:
    print("Keep working!")
  }
}

//Where in Switch
//la Keyword Where se puede utilizar en Switch para filtrar datos, en If let, Guard let y Do catch, for, genéricos, protocolos y extensiones para filtrar tipos y también en funciones de orden superior como sorted, first, etc

//en el siguiente ejemplo añadiremos la Keyword where e incluiremos una condición y además creamos una constante en donde luego la podemos utilizar para añadir una condición extra.
for subscriberCount in [10, 3] {
  switch subscriberCount {
  case let count where count > 5:
    print("A bunch of subscribers! TOTAL: \(count)")
  default:
    print("Keep working!")
  }
}

//Switch your Enum
//creando un enum que tiene 3 posibles estados, los cuales podemos recorrer de forma segura el enum.
//Cabe señalar que la sentencia default, en este caso no es necesaria ya que tenemos todos los casos cubiertos.
enum MessageStatus {
  case sent
  case delivered
  case read
}
for status in [MessageStatus.sent, .delivered, .read] {
  switch status {
  case .sent:
    print("Message sent, add grey stick")
  case .delivered:
    print("Message delivered, add new stick")
  case .read:
    print("Message read, update double stick to blue")
  }
}

//For
//hacer un bucle a una coleccion, al ocupar un for podemos crear una variable que será el dato actual en la interacción de la colección que estemos recorriendo. También podemos no creas esta variable en caso de  que no la ocupemos con un _
let myCollection = ["1", "2", "3", "4", "5"]
for i in myCollection {
  print(i)
}

let myDictionary = ["name": "Rodolfo", "city": "Santiago"]
for (key, value) in myDictionary {
  print("Key \(key) with value: \(value)")
}

//For y Where
//podemos ocupar el For para poder iterar sobre una colección y además ocupar la Keyword Where que nos ayudará a filtrar con una condición los datos que vamos a iterar. Esto nos permite ser más concisos y claros y nos ahorra cláusulas if dentro del SCOPE
let languages = ["Swift", "Objective-C", "Javascript", "Kotlin"]
for language in languages where language.count < 7 {
  print(language)
}

//con el For podríamos recorrer arreglos, diccionarios, sets, string, etc.

//While
//seria pregunta y acción
//sirve para Manejar el flujo del código, este incluye una condición y mientras esta sea verdadera se puede ejecutará el código repetidamente, evaluando en cada interacción hasta que cuando la condición sea falsa se termine el ciclo While y avance al siguiente código.
//Debemos garantizar que la condición pueda llegar a ser falsa o salir con break.
//Un ciclo infinito puede mantener la CPU ocupada indefinidamente; no implica por sí
//solo que vaya a consumir toda la memoria.
let numbers = [1, 2, 3, 4, 5]
var counter = 0
while counter < numbers.count {
  print(numbers[counter])
  counter += 1
}

//Repeat While
//seria acción y pregunta
//sirve para Manejar el flujo del código, este incluye un bloque de código que se ejecuta automáticamente para luego evaluar la condición y mientras esta sea verdadera se puede ejecutar el código. Cada interacción se ejecuta el código y luego evalúa la condición de el while. Si esta es falsa se termina el ciclo y se continúa con el siguiente código
var counter2 = 0
repeat {
  print(numbers[counter2])
  counter2 += 1
} while counter2 < numbers.count

//casos de usos

//if y else

//verificacion y comprobacion de condiciones

//guard

//verificacion y comprobacion de condiciones, en caso de que la condicion no se cumple, nos permite salir de un bloque de codigo con las keywor return, break o throw

//switch

//realizar comprobaciones exhaustivas y elegantes en valores

//for

//iterar sobre un rango, conjunto, secuencia, generando un bucle con codigo personalizado

//while

//preguntar y despues hacer
//cuando la condicion se cumpla ejecutara un bloque de codigo en repetidas ocasiones, de lo contrario si no se cumple la condicion el bucle se detendra

//repeat while

//hacer y despues preguntar
//ejecutara un bloque de codigo en repetidas ocasiones, verificando despues de la ejecucion del codigo si es que la condicion se cumple, para luego ejecutar nuevamente el codigo y volver a preguntar ka condicion. cuando la condicion no se cumpla se detendra el bucle
