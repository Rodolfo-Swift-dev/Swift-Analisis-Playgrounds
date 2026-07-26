//Closures
//Error frecuente: capturar self fuertemente en un closure almacenado sin revisar
//si la relación forma un ciclo de referencias.

//Un closure es un bloque de código que puede almacenarse y pasarse como valor.
//Puede ser anónimo, capturar valores de su contexto y compartir el mismo tipo de
//función que una función declarada con func cuando sus firmas coinciden.

//caracteristicas
//Inferir tipos de parámetros y valores de retorno a partir del contexto
//Retornos implícitos de cierres de expresión única
//Nombres abreviados de argumentos
//Sintaxis de cierre final

//Sintaxis clousure
let myClosure =
  { (parameter: Int) -> Int in  // 1
    print("Value \(parameter)")  // 2
    return parameter  // 3
  }  // 4

//1-Para crear un closure abrimos llaves { y creamos su scope. Al abrir las llaves especificamos si nuestro closure acepta parámetros de entrada, y también especificamos si retorna un valor.En nuestro ejemplo, el closure acepta un parámetro de entrada de tipo Int y retorna un valor de tipo Int.
//2-Dentro del scope de nuestro closure añadimos la lógica que queremos realizar. En nuestro caso solo queremos mostrar un mensaje por consola.
//3-Retornamos el valor de tipo Int. En este caso retornamos el mismo parámetro de entrada que le pasamos al closure.
//4-Cerramos las llaves } indicando que aquí acaba nuestro closure.

//los closure son limpios y claros y pueden implementarse optimizaciones para una sintaxis breve y ordenada
//Un closure puede almacenarse, pasarse como argumento, retornarse o ejecutarse
//directamente. Si retorna un valor, debemos utilizarlo o descartarlo explícitamente.

let closureResult = myClosure(2)
print(closureResult)

//Optimizacion del closure
//crear closure sin parámetros y sin datos de retorno
//al no retornar datos podríamos indicarle con la keyword Void que no retorna datos pero en este caso se puede omitir sin problemas
let myEmptyClosure = { () in
  print("¡Hola")
}

//al no tener parámetros podríamos optimizarlo aún más nuestro closure
let emptyClosure = {
  print("¡Hola Rodolfo!")
}

//Para ejecutar su implementación debemos incluir los paréntesis.
myEmptyClosure()
emptyClosure()

var names = ["Rodolfo", "Martin", "Nacho"]
//Optimizacion
var reversedNames = names.sorted(by: { (s1: String, s2: String) -> Bool in return s1 > s2 })

//inferir tipo a partir del contexto

reversedNames = names.sorted(by: { s1, s2 in return s1 > s2 })
//en este caso como pasamos nuestro closure como argumento a un método o una función , es que es capaz de inferir que tipo de datos son los parámetros y también infiere en que tipo de datos es el que retorna. Por lo tanto podemos omitir esas líneas de código extra.

//Rendimientos implícitos de cierre de expresión única

reversedNames = names.sorted(by: { s1, s2 in s1 > s2 })
//aqui la keyword return se puede omitir ya que el método o función sabe que tiene que retornar un dato y debido a que el código del closure no es ambiguo no tendrá problema en devolver el dato.

//Nombres abreviados de argumentos

reversedNames = names.sorted(by: { $0 > $1 })
//aqui podemos ver ocupamos nombres de argumentos abreviados que ocupan el signo$ seguido por un número que será la posición del elemento sobre la coleccion que estamos ocupando, por lo que podemos omitir los parámetros.
//además podemos omitir la keyword in

//Metodos del operador

reversedNames = names.sorted(by: >)
//en este ejemplo no tenemos problema en esta implementación ya que el tipo string define su implementación de > como compatible con el método que guarda al closure

//sustistuir closures por funciones
//cuando la logia de un closure es requerida en más de un lugar en nuestro código y con la finalidad de hacerlo más modular y reutilizable es que podemos hacer un equivalente de nuestro clousure en función o método.

//tipo de firma de clousure
//(Int, Int) -> Int
//para reusar un closure y hacer una función equivalente es necesario que tenga los mismos tipos de datos en parámetros y retorne mismo tipo de dato

//tipo de firma función
//(Int)  -> Int

//código función
func doble(_ num: Int) -> Int {
  return num * 2
}

//llamado a la función dentro de un método
// en este ejemplo hemos remplazado el closure por una función con firma(tipo de dato) equivalente
var numbers = [2, 4, 6]
var newNumbers = numbers.map(doble)

//equivalencia con closure
newNumbers = numbers.map { $0 * 2 }

//Trailling closure
//al crear funciones podemos agregar parámetros de los cuales pueden ser Closure. Si el último parámetro de una función es de tipo Closure, ese parámetro es un Trailling Closure.
//el uso de Trailling closure hace que sea más fácil de leer

//crear función con Trailling closure

func createUser(name: String, closure: (String, String) -> Void) {
  print("Create User: \(name)")
  closure(name, "Swift")
  print("Completed")
}
//Cuando llamemos a la función podemos implementar la lógica que queramos dentro del closure”

createUser(name: "Rodolfo") { username, action in
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

removeAllUsers { print("Removing table \($0) in \($1)") }
//como se puede ver con un único parámetro en la funcion como closure, al momento de llamar a la función se pueden omitir los parentesis() aunque como curiosidad si los dejas funciona de la misma forma

//múltiples closures en una funcion
//como mencionábamos las funciones pueden llevar closure como parámetro Y múltiples closure.

//creacion de función con múltiples closure
func getDataFromBackend(
  status: String,
  onSuccess: () -> Void, onFailure: (String) -> Void
) {
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

getDataFromBackend(
  status: "OK", onSuccess: { print("Succes") }, onFailure: { print("Error: \($0)") })

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

func makeCounter2(withValue value: Int) -> () -> Int {
  var counter = value
  return {
    counter += 1
    return counter
  }
}
//este código es equivalente al que retorna una función
//en este ejemplo tanto como cuando retorna una función o cuando retorna un closure el llamado a la función que los contiene es el mismo

//Llamado a una función que retorna otra función. La primera llamada crea y retorna
//el contador; la segunda ejecuta la función retornada.
let returnedCounter = makeCounter(withValue: 10)
print(returnedCounter())

let returnedClosureCounter = makeCounter2(withValue: 10)
print(returnedClosureCounter())

//También podemos crear el contador y ejecutarlo inmediatamente.
print(makeCounter(withValue: 10)())

//Captura y estado compartido
//No debemos describir todos los closures como clases o como simples copias por
//referencia. En este ejemplo, las variables almacenan el mismo closure y este
//mantiene un contexto capturado compartido donde vive counter.

var counterA = makeCounter(withValue: 10)
var counterB = counterA
//almacenamos el valor de nuestro closure o función en una variable, para luego tomar esta variable y copiar su valor a otras variables

print(counterA())
//aqui llamamos a ejecutar al closure o función, agregando los () con la finalidad que se ejecute el closure o función

print(counterB())
//counterA y counterB ejecutan el mismo contexto capturado: la primera llamada
//incrementa a 11 y la segunda continúa desde ese estado hasta 12.

//Escaping closure

//Un parámetro closure es escaping cuando puede almacenarse o ejecutarse después de
//que la función que lo recibió haya retornado. @escaping permite esa posibilidad;
//no garantiza cuándo ni cuántas veces se llamará. Las operaciones asíncronas son un
//caso habitual.

final class BackendLoader {
  private var pendingCompletion: (() -> Void)?

  func load(completion: @escaping () -> Void) {
    pendingCompletion = completion
  }

  func finishLoading() {
    pendingCompletion?()
    pendingCompletion = nil
  }
}

//llamar a la función con @escaping

let backendLoader = BackendLoader()
backendLoader.load {
  print("Data received!")
}
backendLoader.finishLoading()

//Autoclousure en Swift

//crear función que acepte un clousure como parametro de entrada

func remove(
  arrayOfNumbers: [Int],
  removeFirstNumber: () -> Int
) {
  if arrayOfNumbers.count == 6 {
    print("Numbers OK!")
  } else {
    print("Number Removed \(removeFirstNumber())!")
  }
}

//llamar a la función
var arrayNumbers = [1, 2, 3, 4, 5, 6, 7]
remove(
  arrayOfNumbers: arrayNumbers,
  removeFirstNumber: { arrayNumbers.remove(at: 0) })

// RESULTADO 👇
// Number Removed 1!

//Pero en lugar de enviarle como parámetro un closure explícito, podríamos utilizar @autoclosure para evitar añadir las llaves{} y así enviarle solo la expresión

func remove2(
  arrayOfNumbers: [Int],
  removeFirstNumber: @autoclosure () -> Int
) {
  if arrayOfNumbers.count == 6 {
    print("Numbers OK!")
  } else {
    print("Number Removed \(removeFirstNumber())!")
  }
}

//llamar a la función

remove2(
  arrayOfNumbers: arrayNumbers,
  removeFirstNumber: arrayNumbers.remove(at: 0))

// RESULTADO 👇
// Numbers OK!
//arrayNumbers tiene 6 elementos, por lo que el @autoclosure no se evalúa. Esta
//evaluación diferida es la característica importante; @autoclosure debe reservarse
//para APIs donde haga más legible la llamada.

//casos de usos
