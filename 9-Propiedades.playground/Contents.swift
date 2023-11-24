import UIKit

//Propiedades

//las propiedades son variables o constantes que creamos en una Struct o Class. En estas podemos guardar valores o acceder a ellos durante el transcurso de nuestro programa




//Propiedades de instancia
//una vez Instanciar a una clase o estructura es donde podemos acceder y modificar las propiedades. Este tipo de propiedad son de instancia por que para acceder a ellas deben estar instanciadas

//creamos clase
class Database {
    var name: String
    init(name: String) {
        self.name = name
    }
}

//Creacion de instancia clase
var database = Database(name: "Chat")

//acceso propiedades
print(database.name)

//modificar sus propiedades
database.name = "chatBot"



//creamos Struct
struct Coworker {
    var name: String
}

//Creacion de instancia Struct
var coworker = Coworker(name: "iOS Developer")

//acceder a su propiedades
print(coworker.name)

//modificar sus propiedades
coworker.name = "iOS "




//Propiedades de tipo
//pueden estar en Struct, Class o Enum
//las propiedades de tipo no necesita Instanciarse previamente para poder ocuparlas, se crean de la misma forma que las propiedades de tipo con la diferencia que se antepone la keyword Static en el caso de las Struct y Class en el caso de las estructuras
//las propiedades de tipo permiten su uso sin necesidad de Instanciar la estructura o Clase

//Creacion del tipo
struct MathUtility {
    static let pi = 3.14159265359
    static var version = 1.0
}

//Uso sin necesidad de Instanciar
print(MathUtility.pi)

//modificar propiedad de tipo sin necesidad de instanciar
MathUtility.version = 2.0

//KeyWords
//Static
//Class




//Propiedades computadas
//las propiedades de tipo y propidades de Instancia almacenan valores, pero las propiedades computadas no almacenan valores y calculan su valor cada vez que llamamos a la propiedad.
//para utilizar estas propiedades utilizamos la palabra var(o sea variable) y { } en donde irá nuestra logica
//opcional podemos añadir un getter y setter

//el getter se llama cuando queremos obtener el valor de la propiedad
//el setter se llama cuando asignamos un nuevo valor a una propiedad
struct Square {
    var side : Double
    var area : Double {
        get {
            return side * side
        }
         set (newArea){
             side = sqrt (newArea)
        }
    }
}
var square = Square(side: 20)

//en el código anterior podemos llamar directamente al método getter con un objeto previamente Instanciado y accedemos a su propiedad computada de la siguiente forma
print(square.area)

//para acceder al método setter tenemos que previamente asignar un valor a la propiedad área y no calcular un área como explicamos en el siguiente código
square.area = 200

//con asignar un nuevo valor a una propiedad computada ya podemos ver que el método setter se manda a llamar y se ejecuta el código de forma automática, que en el ejemplo nuestro modifica el valor del side
print(square.area)
print(square.side)


//Si pretendes utilizarlas solamente para leer datos puedes eliminar completamente la parte del get y del set
struct Person {
    var age: Int
var ageInDogYears: Int {
            return age * 7
    }
}
var fan = Person(age: 25)




//Observadores de propiedad
//estos observadores se aplican a las propiedades de instancias más {willset y didset }.
//Esta propiedad es muy útil para saber cuándo asignamos un nuevo valor a una propiedad.
//Son métodos especiales willSet y didSet que se pueden agregar a una propiedad almacenada para observar y reaccionar a los cambios en su valor. Se utilizan para realizar acciones antes o después de que la propiedad cambie


//willset = willSet se llamará un instante antes de asignarse un valor nuevo a una propiedad. Fíjate que recibimos el nuevo valor como parámetro, en el código anterior aparece como newName.
//didset = didSet se llamará justo después de asignar un nuevo valor a una propiedad.
struct DataBase {
    var name: String {
        willSet(newName) {
            print("Will update name \(newName)")
        }
        didSet {
            print("Changed name \(name)")
        }
    }
}
//vamos a instanciar la clase o Struct y vamos a dar un nuevo valor a la propiedad. Con esto automáticamente se acciona el código willset un instante antes de cambiar el valor a la propiedad y didSet se llamará justo después de asignar un nuevo valor a una propiedad.
var dataBase = DataBase(name: "Users")
dataBase.name = "Students"
//modificada o cuándo ha sido modificada para lanzar lógica dentro de tu aplicación (por ejemplo para refrescar la información que estás mostrando en una vista).




//Property wrapper
//es muy similar a las propiedades computadas y con sus getter y setter, pero aquí se añade una capa de abstracción más al incluir la Keyword @propertyWrapper anteponiéndose a la Struct o class que será la encargada de almacenar nuestra propiedad wrapper, todo esto al momento de crearla.

//1-anotar keyword property wrapper anteponiéndose a Struct o Class, recordar el nombre que se la da al tipo (Struct o Class) por que luego sirve para su utilización.
//2-crear propiedad que almacene estado interno de nuestra property wrapper
//3-inicializar Struct o Class y dar valor a propiedad creada anteriormente, para nuestro ejemplo será la n String vacio
//4-creamos la variable wrapped value Que es muy similar a una propiedad computada, dentro de { } los getter y setter.
//el código del getter se activará al momento de acceder a su propiedad
//el setter se activa al momento de asignar un nuevo valor a nuestra propiedad

//creacion propertywrapper
@propertyWrapper                // 1
struct UserValidation {
    private var name: String    // 2
    init() { self.name = "" }    // 3
    var wrappedValue: String {  // 4
        get { name }
        set {
            if newValue.count > 5 {
                self.name = newValue
                print("Valid name")
            } else {
                print("Error")
            }
        }
    }
}
//con este código ya hemos creado nuestro propertywrapper

//lo siguiente es crear un tipo(Struct o Class) con propiedades y usamos nuestro propertywrapper sobre una propiedad.
//para usarlo debemos anteponer el @ junto al nombre de la Struct o Class que almacena el proppertyWrapper, todo esto anteponiéndose al nombre de la propiedad que vamos a asignarle esta característica.


//creamos una instancia de la structura o clase que almacena la propiedad con las características añadidas
struct UserForm {
    @UserValidation var userName: String
}
var usersForm = UserForm()
usersForm.userName = "SwiftBeta"
print(userForm.userName)
// Valid name
//debido a la lógica de nuestro ejemplo se ejecuta el setter y la cláusula if.

var userForm = UserForm()
userForm.userName = "Swift"
print(userForm.userName)
// Error
//debido a la lógica de nuestro ejemplo se ejecuta el setter y la cláusula else.
