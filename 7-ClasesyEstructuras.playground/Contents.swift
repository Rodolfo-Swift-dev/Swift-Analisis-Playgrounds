import Foundation

//Clases y Estructuras


//Al crear una instancia de nuestros tipos es obligatorio dar un estado inicial a todas sus propedades(en clases es obligatorio el init y en struct es opcional ya que se inicializa por defecto
//subScript
//Los subscripts son otra forma de acceder a los elementos de una Clase, Estructura, enum, array, Dict, son atajos para actualizar o obtener su valor.

//Podemos crear nuestros propios tipos de datos co Struct y Class
//dentro de una Clase o Struct podemos crear propiedades y métodos
//Las propiedades son variables o constantes que usamos dentro de las Struct y Class donde podemos almacenar un valor.
//los métodos son funciones dentro de una Struct o Class, los cuales nos permiten modificar el estado de nuestras propiedades o realizar alguna tarea.
//cuando creamos un Struct o una Class, estamos creando un tipo y también podemos crear los métodos y propiedades necesarios.
//cabe señalar que al momento de crear una Struct o Class, esta deben ser creadas agrupándolos según una mismos responsabilidad(=principio responsabilidad única SOLID). Así mantenemos una clara organizacion y separación de propiedades y metodos
//en una Struct o Class las propiedades nos sirven para guardar un estado y tenemos métodos para modificar el estado.


//Analogia entre Clases y Estructuras
//En común
//Crear propiedades para almacenar valores
//Crear métodos para crear lógica
//Crear subscripts para poder acceder a sus valores usando la sintaxis de los subscripts
//Crear inicializadores para dar un estado inicial a nuestro tipo
//Conformar protocolos para añadir más funcionalidad
//Crear extensiones para añadir más funcionalidad

//Caracteristicas

//Struct
//Stack = En el caso del Stack (o pila de llamadas) cabe destacar que su ejecución es inmediata, controlada por la CPU. Es muy eficiente y rápido. Funciona bajo el concepto de LIFO (last in first out), de ahí su rapidez y eficiencia.
//por Valor = se crea una nueva copia lo que la hace independiente frente a algún cambio de una de sus copias, no afecta al resto.
//Init = crean un método init por defecto (MEMBERWISE Init) con tantos parámetros como propiedades tenga. ¡Ojo!, porque en el momento que nosotros creemos un init, el que se crea por defecto desaparece y tendríamos que añadirlo manualmente. si en un Struct añades los inits dentro de una extensión, el init por defecto no se destruye y no tenemos que añadirlo de nuevo. las estructuras no tienen inits de conveniencia.
//Mutating = En las structs TODO es inmutable por defecto. Para poder modificar un struct, hay que poner la palabra mutating delante de la firma de la función. Curiosidad: la palabra mutating, en realidad, reemplaza el value type anterior por el nuevo. Es decir, en realidad no se modifica, sino que se crea uno nuevo con los datos modificados que sustituye al anterior.
//Herencia = Las structs no tienen Herencia, ni type casting ni métodos deinit.
//Entonces, ¿cómo pueden añadirse super-poderes a las structs si no se puede utilizar la Herencia? Mediante composición, utilizando protocolos.

//Class
//Heap = (o almacenamiento libre) es una enorme pieza de memoria que el sistema puede soliciar reservar un trocito para su uso (mediante alloc). Añadir o borrar memoria del heap es un proceso más costoso y pesado.
//por Referencia = se crea una nueva referencia que apunta a un mismo objeto, lo que lo hace dependiente frente a algún cambio de una de sus copias, afecta al resto.
//Init = tenemos que definir nosotros mismos el inicializador. Siempre. las clases tienen inits de conveniencia, marcados con la palabra convenience delante.
//Mutating = En el caso de las clases, aunque declares un objeto como constante (con let), puedes modificar sus propiedades si estas están declaradas como var.
//Herencia = Las Classes tienen herencia, es decir, puede tener cero o una superclase. Por ello, también se puede utilizar type casting con las clases. Como las classes se crean en el Heap, y es memoria que hay que crear y liberar, todas ellas tienen un método deinit que se ejecuta justo antes de liberarse de memoria.






//Creacion vacía
class MyClass {
    // Class implementation
}

struct MyStruct {
    // Struct implementation
}


//Creacion
//al momento de crear la clase o estructuras, estas se crean con la primera letra en mayúscula.
//Al crear un tipo, ya sea Class o Struct, creamos una abstracción para poder trabajar en nuestro código
//ABSTRACCION = La abstracción hace referencia al uso de conceptos o categorías abstractas. El concepto supone asociar una sola respuesta (palabra o acción) a diversos estímulos distinguibles (objetos o acontecimientos). Por ejemplo el concepto perro.
struct User {
    let name: String
    let city: String
func createUser() {
        print("Create User")
    }
    func removeUser() {
        print("Remove User")
    }
}

class Singer {
    var name: String
    var age: Int
    init(name: String, age: Int) {
        self.name = name
        self.age = age
    }
    func sing() {
        print("La la la la")
    }
}
//con este ejemplo de código acabamos de crear un tipo te dato, el cual tiene propiedades y métodos.
//este es solo la creación, para poder ocuparlo tendríamos que instanciarlo





//Instanciar
//Instanciar es un objeto concreto de una Class o Struct. Cuando creas una instancia, se asigna espacio en memoria para almacenar los datos de esa Class o Struct y se inicializan con sus valores iniciales. Al crear la instancia puedes usar las propiedades y métodos del tipo.
let user = User(name: "Rodolfo", city: "Santiago")
let singer = Singer(name: "Rodolfo", age: 36)
//let singer = Singer()
//El código anterior nos arrojaría error porque al momento de Instanciar tenemos que inicializar con sus propiedades.
//como norma Swift exige que al crear una instancia de tipo (Struct o Class), todas sus propiedades deben tener un valor. Por eso necesitamos el init
//Una vez tenemos la instancia de nuestro tipo podemos acceder a sus propiedades y métodos
//Al crear una instancia de nuestros tipos es obligatorio dar un estado inicial a todas sus propiedades. Para dar un estado inicial se suele utilizar un inicializador.


//Inicializador
//como una función que recibe valores para asignarlos a las propiedades de tu tipo, de esta manera pueden tener un valor y se puede crear la instancia de un tipo correctamente.

//Crear Inicializador Class
//necesitamos agregar la palabra init e incluir tantos parametros como propiedades tengamos en una Struct o Class
class Database {
    var nameData: String
    init(nameData: String) {
        self.nameData = nameData
    }
}
//este init es como una función que recibe un parametro el cual al momento de Instanciar la Clase es requerido y asignado a la propiedad.

//Creacion de instancia clase
let database = Database( nameData: "Rodolfo")

//con este código ya podríamos acceder a la instancia que está almacenada en una variable y podríamos acceder a su propiedades
print(database.nameData)


//Inicializador Struct
//Al usar una Struct nos ahorramos escribir el inicializador, es lo que se conocer como memberwise init. Al usar Struct no necesitamos crear el inicializador.
struct Coworker {
    var nameWorker: String
}

//Creacion de instancia Struct
//en una Struct, al momento de Instanciar, automáticamente nos aparecerán las propiedades a las cuales tenemos que asignarle valor, todo esto sin necesidad de inicializar al momento de crear la estructura, a diferencia de las clases.
let coworker = Coworker(nameWorker: "iOS Developer")

//con este código ya podríamos acceder a la instancia que está almacenada en una variable y podríamos acceder a su propiedades
print(coworker.nameWorker)




//por Referencia(Class)
//las Clases son por referencia, que significa esto que creamos varias instancias a una misma clase y luego al modificar alguna propiedad de alguna copia, este cambio afectará a todas las demás copias de clase.

//Crearemos la clase
class CentralBase{
    var nameBase: String
    init(nameBase: String) {
        self.nameBase = nameBase
    }
}

//Instanciamos la clase
var chatDatabase = CentralBase(nameBase: "Apple DataBase")

//creamos dos variables mas y asignamos el valor de la instancia
var appDatabase = chatDatabase
var remoteDatabase = chatDatabase

//cambiemos el valor de una propiedad de una instancia y podremos darnos cuenta que este cambio se verá reflejado en las demás instancias.
remoteDatabase.nameBase = "💻 AmazonBetaDatabase"
print(chatDatabase.nameBase)
print(appDatabase.nameBase)
print(remoteDatabase.nameBase)





//por Valor(Struct)
//las Struct son por valor, que significa esto que creamos varias instancias a una misma Struct y luego al modificar alguna propiedad de alguna copia, este cambio NO afectará a todas las demás copias de clase. será independiente

//Crearemos la Struct
struct Cowork {
    var nameCo: String
}

//Instancios la estructura
var timCook = Cowork(nameCo: "Tim Cook")

//creamos dos variables mas y asignamos el valor de la instancia
var boss = timCook
var friend = timCook

//cambiemos el valor de una propiedad de una instancia y podremos darnos cuenta que este cambio NO se verá reflejado en las demás instancias.
friend.nameCo = "Rodolfo"
print(timCook.nameCo)
print(boss.nameCo)
print(friend.nameCo)



//casos de usos
//Cuando usar Class o Struct

//Usa Struct por defecto
//Usa Struct para representar todo tipo de datos simples: modelos, datamodels, etc.
//Usa Class para representar datos más complejos que pueden ser compartidos y modificados por diferentes partes de tu código.
//Usa Class cuando tengas que controlar la identidad de los datos que estas modelando
//Usa Class si necesitas modificar la misma referencia en memoria durante la ejecución de tu app.
//Usa Class cuando necesites interoperabilidad con Objective-C
