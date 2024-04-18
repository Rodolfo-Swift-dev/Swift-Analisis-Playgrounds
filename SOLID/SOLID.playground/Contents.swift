import Foundation


// MARK:  SOLID

//1.    Principio de Responsabilidad Única (SRP):
//    •    Un ejemplo en Swift podría ser tener una clase que gestiona la lógica de presentación y la lógica de red en una aplicación. Sería preferible dividir estas responsabilidades en clases separadas.
//funciones y finalidades unicas no multiples.

// MARK:  S- Principio de responsabilidad unica(SRP).

// Bad
class FoodOrder {
    func processOrder() {
    }
}

// Good
class Order {
    func selectOrder() {
    }
    func payOrder() {
    }
    func processOrder() {
    }
}

//    2.    Principio de Abierto/Cerrado (OCP):
//    •    Imagina una clase en Swift que maneja la generación de informes. En lugar de modificar la clase existente para admitir un nuevo formato de informe, podríamos extenderla creando una nueva clase que implemente la misma interfaz.
//abierta para extenderse pero cerrada para modificarse.

// MARK:  O- Principio abierto/cerrado(OCP)

// Bad
enum ShapeType {
    case circle
    case rectangle
    //case triangle
}
//funcion que limita a no poder usar un caso triangulo, por su altura.
func takeArea(shape: ShapeType, dimension: Double) -> Double {
    switch shape {
    case .circle:
        return (dimension * dimension) * Double.pi
    case .rectangle:
        return dimension * dimension
    //case .triangle:
    }
}

// Good
protocol GeometricShape {
    func calculateFigureArea() -> Double
}

struct rectangle: GeometricShape {
    let base: Double
    let height: Double
    
    init(base: Double, height: Double) {
        self.base = base
        self.height = height
    }
    func calculateFigureArea() -> Double {
        return base * height
    }
}

struct triangle: GeometricShape {
    let base: Double
    let height: Double
    
    init(base: Double, height: Double) {
        self.base = base
        self.height = height
    }
    func calculateFigureArea() -> Double {
        return (base * height) / 2
    }
}


struct circumference: GeometricShape {
    let ratio: Double
    let phi = Double.pi
    init(ratio: Double) {
        self.ratio = ratio
    }
    func calculateFigureArea() -> Double {
        return (ratio * ratio) * phi
    }
}

//    3.    Principio de Sustitución de Liskov (LSP):
//    •    Supongamos que tenemos una jerarquía de clases en Swift donde una subclase no puede ser utilizada de manera intercambiable con su clase base sin alterar el comportamiento esperado del programa. Este incumplimiento del principio de Liskov podría llevar a errores sutiles y dificultades en el mantenimiento.
//polimorfismo, aqui nos colaboran los protocolos que nos permite adoptar metodos iguales pero con distinta implementacion segun sean los requerimientos.

// MARK:  L- Principio de sustitucion de Liskov(LSP)

// Bad
class AllBirdsAnimal {
    func wings() {
    }
    func fly() {
    }
}
class penguin: AllBirdsAnimal {
    override func fly() {
    }
}

// Good
protocol CanFly {
    func canFly()
}
class Bird {
    func haveWings() {
    }
    func canHaveWings() {
    }
}
class penguins: Bird {
    func canSwiming() {
    }
}
class Eagle: Bird, CanFly {
    func canFly() {
    }
    func attack() {
    }
}

let eagle = Eagle()


//    4.    Principio de Segregación de Interfaces (ISP):
//    •    Si tienes un protocolo en Swift que incluye muchos métodos, pero una clase solo necesita implementar algunos de esos métodos, podrías estar violando el ISP. Dividir el protocolo en protocolos más específicos podría ser una solución.
//relacionado con el primer principio de responsabilidad unica.


// MARK:  I- Principio de segregacion de interfaces(ISP)

// Bad
protocol AllAnimal {
    func eat()
    func sleep()
    func swim()
    func fly()
}
class Hawk: AllAnimal {
    func eat() {
    }
    func sleep() {
    }
    func swim() {
        //  Anormal
    }
    func fly() {
    }
}

// Good
protocol AirAnimal {
    func canFly()
}
protocol WaterAnimal {
    func canSwim()
}
class Animal {
    func canEat() {
    }
    func canSleep() {
    }
}

class fish: Animal, WaterAnimal {
    func canSwim() {
    }
    
    
}
/*
 //Bad
 protocol Work {
     func worked()
     func braked()
 }

 class ProgrammingWork: Work {
     func worked() {
     }
     func braked() {
     }
 }

 // Good
 protocol Worker {
     func work()
 }

 protocol LazyWork {
     func rest()
     func moreRest()
 }

 class Programmer: Worker {
     func work() {
     }
 }

 class employee: Worker, LazyWork {
     func work() {
     }
     func rest() {
     }
     func moreRest() {
     }
 }
 */

//    5.    Principio de Inversión de Dependencias (DIP):
//    •    Un ejemplo en Swift podría ser cambiar de depender directamente de una implementación concreta a depender de un protocolo. Si una clase depende de un protocolo, se vuelve más fácil intercambiar implementaciones y hacer que el código sea más flexible para futuros cambios.
//relacionado con el principio Liskov en donde con protocolos flexibilizamos nuestro codigo sin necesidad de modificar una clase o estructura con cada requerimiento nuevo


// MARK:  D- Principio de inversion de dependencia(DIP)

// Bad
class ElectricEngine {
    func turnOn() {
    }
}

class Boat {
    let electricEngine = ElectricEngine()
    func go() {
        electricEngine.turnOn()
    }
}

// Good
protocol Switched {
    func SwitchedOn()
    func SwitchedOff()
}
class combustionMotor: Switched {
    func SwitchedOn() {
    }
    func SwitchedOff() {
    }
    
    
}
class ElectricMotor: Switched {
    func SwitchedOn() {
    }
    func SwitchedOff() {
    }
}
class Car {
    let motor: Switched
    init(motor: Switched) {
        self.motor = motor
    }
    func starting() {
        motor.SwitchedOn()
    }
    func stop() {
        motor.SwitchedOff()
    }
}
