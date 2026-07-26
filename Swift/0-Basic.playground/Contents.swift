//Error frecuente: Swift no convierte números implícitamente y la división entre
//Int descarta la parte decimal. Convierte de forma explícita cuando corresponda.

//ejecucion funcion print me imprime en consola
print("Hello, playground")

//comentar bloque de codigo de una sola linea
//print("Hello, playground")

//comentar bloque de codigo de varias lineas
/* print("Hello, playground")
 print("Hello, playground")
 print("Hello, playground")*/

//operaciones aritmeticas
print(1 + 1)
print(1 - 1)
print(1 * 3)
print(6 / 3)  //division
print(9 % 4)  //resto

//operadores de comparacion
print(1 == 1)  //igual que
print(1 != 1)  //distinto que
print(1 < 1)  //menor que
print(1 > 1)  //mayor que
print(1 <= 1)  //menor o igual que
print(1 >= 1)  //mayor o igual que

//operadores compuestos
//+=
//-=
//*=
// /=

//operadores logicos
//and &&
//or ||
//not !

//tipos basicos de datos indicando el tipo de datos
let numInt: Int = 2
let numFloat: Float = 2.0
let word: String = "word"
let female: Bool = true
print(numInt, numFloat, word, female)

//inferencia de tipo
var myInt = 1
var myString = "Hello, Developer!"
var myDouble = 2.0
var myBoolean = true
print(myInt, myString, myDouble, myBoolean)

//interpolacion
let newWord = "The \(word) \(word) repeats \(numInt) times"

//concatenacion
let phrase = newWord + word
print(phrase)

//variables
var myName = "Rodolfo Gonzalez"
myName = "Greetings, Rodolfo"
//se puede modificar la variable pero siempre respetando el tipo de datos
var myNum = 5
myNum = 7

//constantes
let numberPi = 3.14
print(numberPi)
//este valor no cambia nunca en el transcurso del programa

//es recomendable en variables y constantes que el nombre sea descriptivo y claro de su uso
