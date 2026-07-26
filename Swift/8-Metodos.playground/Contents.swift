//Métodos
//Error frecuente: escribir @mutating o confundir static con class. La keyword es
//mutating; class permite sobrescritura y static la impide.

//son funciones que se encuentran dentro de un tipo( Struct o Class) equivalente a estár asociados
//cuando

//Metodos de instancia Clase
//metodos que creamos dentro de un tipo (Struct o Class) y para poder ocuparlos debemos Instanciar previamente.
class Games {
  var score = 10

  func increaseScore() {
    self.score += 1
  }
  func reset() {
    self.score = 0
  }

}
//en el código previo creamos 2 métodos de instancia y para poder acceder a ellos debemos Instanciarlos.

let games = Games()
games.increaseScore()
games.reset()

//Una referencia declarada con let sigue permitiendo modificar propiedades var de la
//instancia de clase. En una estructura, el método debe usar la keyword mutating
//cuando modifica una propiedad o reemplaza self. mutating no lleva @.

//Método de instancia en una Struct
//Una estructura guardada en var es mutable. Para que uno de sus métodos modifique el
//valor, debemos anteponer la keyword mutating.
struct User {
  var name: String

  mutating func update(name: String) {
    self.name = name
    printName()
  }

  private func printName() {
    print("the name is \(name)")
  }
}

//ahora para poder acceder y usar el método, debemos Instanciar el tipo(Class o Struct) creado
var user = User(name: "Rodolfo")
user.update(name: "RodDev")
print(user.name)
//user.printName() codigo erroneo ya que no podemos acceder al metodo desde fuera del tipo ya que es privado

//self
//self representa la instancia actual. Normalmente Swift permite omitirlo; es
//obligatorio cuando necesitamos distinguir una propiedad de un parámetro con el
//mismo nombre y resulta útil para hacer explícita la captura dentro de closures.

class Game {
  var score = 0
  func increaseScore() {
    self.score += 1
    self.printScore()
  }
  func reset() {
    self.score = 0
    self.printScore()
  }
  private func printScore() {
    print("Score Total! \(score)")
  }
}

//Instanciar la clase
let game = Game()
game.increaseScore()
game.reset()
//game.printScore() codigo erroneo ya que no podemos acceder al metodo desde fuera del tipo ya que es privado

//Métodos de tipo en Swift
//Se llaman sobre el tipo y no sobre una instancia. static funciona en Struct, Enum y
//Class. Dentro de una clase también puede usarse class para permitir que una
//subclase sobrescriba el método; un método static no puede sobrescribirse.
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

let car = Car()
car.addPassenger()
print(car.passengers)
car.stopEngine()

//Car.startEngine usa static aunque Car sea una clase. Usaríamos class func solamente
//si necesitáramos personalizar el comportamiento mediante override en una subclase.

struct NewUser {
  var name: String

  static func start() {
    print("Utilizar metodo sin previa instancia")
  }
}

NewUser.start()

//casos de usos
