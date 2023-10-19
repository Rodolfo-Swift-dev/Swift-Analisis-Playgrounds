import UIKit

//un clousure es como una función con sus mismo contenido, la única diferencia es que sería anónima, sin nombre

//caracteristicas
//Inferir tipos de parámetros y valores de retorno a partir del contexto
//Retornos implícitos de cierres de expresión única
//Nombres abreviados de argumentos
//Sintaxis de cierre final

//Sintaxis clousure
let myClosure: { (parameter: Int) -> Int in    // 1
    print("Value \(parameter)")    // 2
    return parameter            // 3
}                                // 4

//1-Para crear un closure abrimos llaves { y creamos su scope. Al abrir las llaves especificamos si nuestro closure acepta parámetros de entrada, y también especificamos si retorna un valor.En nuestro ejemplo, el closure acepta un parámetro de entrada de tipo Int y retorna un valor de tipo Int.
//2-Dentro del scope de nuestro closure añadimos la lógica que queremos realizar. En nuestro caso solo queremos mostrar un mensaje por consola.
//3-Retornamos el valor de tipo Int. En este caso retornamos el mismo parámetro de entrada que le pasamos al closure.
//4-Cerramos las llaves } indicando que aquí acaba nuestro closure.


//los closure son limpios y claros y pueden implementarse optimizaciones para una sintaxis breve y ordenada
//los closure deben asignarse a una variable o constante siempre y cuando retornen un valor. Con esto ya podremos llamar nuestro Closure otorgándole un parametro de entrada del tipo de dato correspondiente.

myClosure(2)




//Optimizacion del closure
//crear closure sin parámetros y sin datos de retorno
//al no retornar datos podríamos indicarle con la keyword Void que no retorna datos pero en este caso se puede omitir sin problemas
let myEmptyClosure = { () in
    print("¡Suscríbete a SwiftBeta!")
}

//al no tener parámetros podríamos optimizarlo aún más nuestro closure
let myEmptyClosure = {
    print("¡Suscríbete a SwiftBeta!")
}

//para ejecutar su implementación solo basta con llamarlo
myEmptyCosure



//Optimizacion
reversedNames = names.sorted(by: { (s1: String, s2: String) -> Bool in return s1 > s2 } )


//inferir tipo a partir del contexto

reversedNames = names.sorted(by: { s1, s2 in return s1 > s2 } )
//en este caso como pasamos nuestro closure como argumento a un método o una función , es que es capaz de inferir que tipo de datos son los parámetros y también infiere en que tipo de datos es el que retorna. Por lo tanto podemos omitir esas líneas de código extra.


//Rendimientos implícitos de cierre de expresión única

reversedNames = names.sorted(by: { s1, s2 in s1 > s2 } )
//aqui la keyword return se puede omitir ya que el método o función sabe que tiene que retornar un dato y debido a que el código del closure no es ambiguo no tendrá problema en devolver el dato.


//Nombres abreviados de argumentos

reversedNames = names.sorted(by: { $0 > $1 } )
//aqui podemos ver ocupamos nombres de argumentos abreviados que ocupan el signo$ seguido por un número que será la posición del elemento sobre la coleccion que estamos ocupando, por lo que podemos omitir los parámetros.
//además podemos omitir la keyword in


//Metodos del operador

reversedNames = names.sorted(by: >)
//en este ejemplo no tenemos problema en esta implementación ya que el tipo string define su implementación de > como compatible con el método que guarda al closure






//sustistuir closures por funciones
//cuando la logia de un closure es requerida en más de un lugar en nuestro código y con la finalidad de hacerlo más modular y reutilizable es que podemos hacer un equivalente de nuestro clousure en función o método.

//tipo de firma de clousure
(Int, Int) -> Int
//para reusar un closure y hacer una función equivalente es necesario que tenga los mismos tipos de datos en parámetros y retorne mismo tipo de dato

//tipo de firma función
(Int)  -> Int

//código función
func doble(_ num : Int) -> Int{
        return num * 2
}


//llamado a la función dentro de un método
var numbers = [ 2, 4, 6]
var newNumbers = numbers.map ( by : doble)
// en este ejemplo hemos remplazado el closure por una función con firma(tipo de dato) equivalente





//Trailling closure
//al crear funciones podemos agregar parámetros de los cuales pueden ser Closure. Si el último parámetro de una función es de tipo Closure, ese parámetro es un Trailling Closure.
//el uso de Trailling closure hace que sea más fácil de leer

//crear función con Trailling closure

func createUser(name: String, closure: (String, String) -> Void) {
    print("Create User: \(name)")
    closure(name, "Suscríbete")
    print("Completed")
}
//Cuando llamemos a la función podemos implementar la lógica que queramos dentro del closure”

createUser(name: "SwiftBeta") { username, action in
    print("Track Event \(username) with \(action)")
}
//en este ejemplo al llamar a la función tomamos el closure y le indicamos que el parámetro de entrada de la función sea un parámetro en el clousure y el otro parámetro del clousure es un string definido


//crear función con único closure
func removeAllUsers(closure: (String, String) -> Void) {
    print("Remove All Users")
    closure("Users", "Database")
    print("Completed")
}


//llamada la función con único parámetro closure
removeAllUsers { name, location in
    print("Removing table \(name) in \(location)")
}
//como se puede ver con un único parámetro en la funcion como closure, al momento de llamar a la función se pueden omitir los parentesis() aunque como curiosidad si los dejas funciona de la misma forma




//múltiples closures en una funcion
//como mencionábamos las funciones pueden llevar closure como parámetro
Y múltiples closure.

//creacion de función con múltiples closure
func getDataFromBackend(status: String,
       onSuccess: () -> Void, onFailure : (String) -> Void) {
    if status == "OK" {
        onSuccess()
    } else {
        onFailure(status)
    }
}

//llamada a la función con múltiple closure
getDataFromBackend(status: "OK") {
    print("Success")
} onFailure: { status in
    print("Error: \(status)")
}
//al llamar a la funcion es donde establecemos la lógica de código de nuestros closure como parametros




//funciones que pueden retornar funciones o closure

//como sabemos podemos pasar como parámetro de una función closure o funciones pero también podemos  hacer que las funciones retornen funciones o closure


//creacion de función que retorna función

func makeCounter(withValue value: Int) -> () -> Int {
    var counter = value
    func increment() -> Int {
        counter += 1
        return counter
    }
    return increment
}
//aqui creamos na función que retorna una función la cual tiene un tipo de datos.
//la función que retorna tiene que corresponder con el tipo de dato que sale en el retorno de la funcion


//creacion de función que retorna closure

func makeCounter(withValue value: Int) -> () -> Int {
    var counter = value
    return {
        counter += 1
        return counter
    }
}
//este código es equivalente al que retorna una función
//en este ejemplo tanto como cuando retorna una función o cuando retorna un closure el llamado a la función que los contiene es el mismo

//llamado a la función que retorna closure o función

makeCounter(withValue: 10)
//este código nos retornará el tipo de dato de la función o closure

//para poder ejecutar la función o closure que nos retorna la función que lo contiene, debemos agregar paréntesis () al Ejemplo del llamado anterior a la función

makeCounter(withValue: 10)()
//esto ejecutará el código de la función o closure de retorno



//closure y funciones de tipo por referencia
//al igual que las clases, los closure y funciones son de tipo por referencia, es decir un cambio a alguna copia de un closure o función, afectará ese cambio a cada copia que exista.

var counterA = makeCounter(withValue: 10)
var counterB = counterA
var counterC = counterB
//almacenamos el valor de nuestro closure o función en una variable, para luego tomar esta variable y copiar su valor a otras variables

print(counterA())
//aqui llamamos a ejecutar al closure o función, agregando los () con la finalidad que se ejecute el closure o función

print(counterB())
//si ejecutamos este código como es por referencia, afecta a cada una de sus copias, si en la primera interacción el counter se incrementa a 11, la segunda ejecución en vez de partir en 10 comienza en 11 después de verse afectada




//Escaping closure
