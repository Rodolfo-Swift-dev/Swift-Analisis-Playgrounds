import Foundation

//Clases y Estructuras


//Al crear una instancia, todas sus propiedades almacenadas deben tener un valor.
//Ese valor puede venir de una declaración, un inicializador propio, un inicializador
//sintetizado por Swift o, en ciertas clases, un inicializador heredado.
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
//Memoria = una estructura no está obligada a vivir en el Stack. El compilador puede
//almacenar u optimizar un valor en Stack, Heap o registros. Esa decisión de
//implementación no define la semántica del tipo.
//Por valor = al asignar o pasar una estructura se obtiene un valor independiente.
//Swift puede usar copy-on-write internamente sin cambiar este comportamiento visible.
//Init = Swift sintetiza un memberwise initializer para las propiedades de la
//estructura. Declarar un init dentro del tipo elimina ese memberwise init; declararlo
//en una extensión permite conservarlo. Las estructuras no tienen convenience init.
//Mutating = una estructura guardada en var puede cambiar. Un método que modifica sus
//propiedades o reemplaza self debe declararse mutating. Si la instancia está en let,
//no se puede mutar.
//Herencia = Las structs no tienen Herencia, ni type casting ni métodos deinit.
//Entonces, ¿cómo pueden añadirse super-poderes a las structs si no se puede utilizar la Herencia? Mediante composición, utilizando protocolos.

//Class
//Memoria = las instancias tienen identidad y normalmente se administran mediante
//referencias y ARC. No debemos depender de una ubicación concreta Stack/Heap como
//parte del comportamiento del lenguaje.
//Por referencia = asignar una instancia copia la referencia; ambas variables apuntan
//al mismo objeto y observan sus cambios.
//Init = no siempre debemos escribir un inicializador. Una clase puede recibir un
//inicializador por defecto cuando todas sus propiedades tienen valores iniciales y
//también puede heredar inicializadores bajo reglas específicas. convenience declara
//un inicializador secundario que debe delegar finalmente a uno designado.
//Mutating = En el caso de las clases, aunque declares un objeto como constante (con let), puedes modificar sus propiedades si estas están declaradas como var.
//Herencia = una clase puede tener cero o una superclase. También puede participar en
//type casting. Se puede declarar deinit para liberar recursos justo antes de que ARC
//destruya la instancia; no es un método que se llame manualmente.






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
remoteDatabase.nameBase = "💻 RemoteDatabase"
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
