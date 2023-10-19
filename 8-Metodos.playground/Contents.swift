import UIKit

//Métodos

//son funciones que se encuentran dentro de un tipo( Struct o Class) equivalente a estár asociados
//cuando




//Metodos de instancia Clase
//metodos que creamos dentro de un tipo (Struct o Class) y para poder ocuparlos debemos Instanciar previamente.
class Game {
    var score = 0
    func increaseScore() {
        score += 1
    }
    func reset() {
        score = 0
    }
}
//en el código previo creamos 2 métodos de instancia y para poder acceder a ellos debemos Instanciarlos.

let game = Game()
game.increaseScore()
game.increaseScore()

//en el código anterior creamos métodos que modifican una propiedad, no hay problema ya que es una clase y es mutable pero en una propiedad tendríamos que anteponer la keyword @mutating antes del método y así podríamos modificar propiedades dentro de una estructura.


//medodo de instancia Struct
//una estructura es inmutable por lo que para modificar sus propiadades a través de métodos, debemos anteponer la Keyword @mutating antes del método que va a modificar la propiedad.
struct User {
    var name: String
    mutating func update(name: String) {
        self.name = name
    }
}

//ahora para poder acceder y usar el método, debemos Instanciar el tipo(Class o Struct) creado
var user = User(name: "SwiftBeta")
user.update(name: "Swift")
print(user.name)


//Self
//una analogía para definir self sería cuando estamos dentro de un método es como estar un nivel más adentro o más arriba dentro de nuestro tipo(Class o Struct) y para poder acceder a las propiedades de la estructura tenemos que indicar con self seguido por un punto y el nombre de la propiedad o el método al cual acceder.
//el self en el ejemplo anterior se refiere al tipo (Class o Struct) que almacena la propiedad o método la cual queremos acceder.

class Game {
    var score = 0
    func increaseScore() {
        self.score += 1
        self.printScore()
    }
    func reset() {
        self.score = 0
    }
    func printScore() {
        print("Score Incremented! \(score)")
    }
}

//Instanciar la clase
var game = Game()
game.increaseScore()




//Metodos de tipo en Swift
//los métodos de tipo son métodos que podemos llamar directamente desde una Struct o Class sin la necesidad de ser inastanciados, pero obligatoriamente debe ocuparse la Keyword static. Al igual que las propiedades de tipo
//para indicar que un método es de tipo, debemos anteponer la keyword static antes del método, al momento de crear nuestro tipo(Struct o Class)
class Car {
    var passengers = 0
    static func startEngine() {
        print("Start engine...")
    }
    func addPassenger() {
        passengers += 1
    }
    func stopEngine() {
        passengers = 0
    }
}

//ahora para poder ocuparlos podemos recurrir directamente al tipo (clase o estructura) y a su método, sin la necesidad de Instanciar previamente para poder ocuparlo.
Car.startEngine()

//cabe señalar que cuando queremos crear propiedades o métodos de tipo, si el tipo es una Struct debemos ocupar la Keyword static y si el tipo es una class debemos ocupar la keyword Class
