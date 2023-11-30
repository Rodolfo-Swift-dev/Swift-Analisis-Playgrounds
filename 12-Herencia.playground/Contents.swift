import Foundation

//Herencia

//La herencia nos permite heredar propiedades y método de una clase a otra, sin necesidad de estar creando código repetidas veces.
//con la herencia tratamos de encapsular código en tipos bien definidos, con lo que conseguimos código reutilizable, más limpio y fácil de entender




//superclase o clase padre
//es la clase de donde se toman propiedades a heredar para las otras clases.


//subclase o clase hija
//es la clase que hereda las propiedades de otra clase llamada





//creacion de superclase
class Animal {
    var name: String
    var age: Int
    
    init(name: String, age: Int) {
        self.name = name
        self.age = age
    }

    func sound() {
        print("Animals Sounds")
    }
}


//creacion de subclase
//aquí heredamos las propiedades de la superclase, además de crear nuevos métodos o propiedades exclusivos de esta clase. Además tenemos que incluir la debida inicialicar las propiedades de instancia.


//creacion de subclase
class Dog: Animal {
    var legs: Int
    
    init(legs: Int, name: String, age: Int ) {
        self.legs = legs
       //super.init(name: "Felipe", age: 10)  con este codigo podrimas inicializar estos valores y al momento de instanciar no seran solicitados
        super.init(name: name, age: age)
    }

    func eat() {
        print("Eat meat")
    }
}

//cabe señalar que en el ejemplo de código anterior como heredamos propiedades de una superclase y estas son de Instancia es que debemos inicializar las propiedades de la clase hija y además con la palabra súper.init debemos inicializar la superclase

//primero debemos asignar un valor a todas las propiedades de la Class Dog y luego debemos llamar al inicializador de la superclase


//instancia de objeto que hereda

let dog = Dog(legs: 4, name: "Felipe", age: 20)
dog.eat()

// RESULTADO 👇
// Eat meat


//creacion de objeto que hereda

class Cat: Animal {
    func drink() {
        print("Milk")

    }
}


//creacion de objeto que hereda

class Chihuahua: Dog {
    
    
}

//instancia de objeto que hereda

let chihuahua = Chihuahua(legs: 4, name: "Puppy", age: 2)
chihuahua.name
chihuahua.eat()


//Estamos heredando las propiedades y métodos de Dog, y a la vez estamos heredando las propiedades y métodos de Animal y ¡todo esto sin duplicar código








//Override métodos de la Superclase

//en ocasiones heredamos métodos de una superclase, pero también existe la capacidad de sobreescribir métodos mediante la Keyword Override antes del nombre de método heredado a sobrescribir en la subclase de su implementación, luego unas llaves con bloque de código editado que me tomé y modifiqué método original añadiendo código personalizado según las necesidades





//creacion de objeto que hereda y además sobreescribe método original de superclase

class Dog1: Animal {
    var legs: Int

    init(legs: Int) {
        self.legs = legs
        super.init(name: "Rodolfo", age: 10)
    }

    override func sound() {

        print("Gruauuuuur")
    }

    func eat() {
        print("Eat meat")
    }
}


//instancia de objeto que hereda y tiene método override)

let myDog = Dog1(legs: 4)
myDog.sound()





//creacion de clase que hereda e incluye método de tipo(sleep)

class Dog2: Animal {
    var legs: Int
    
    init(legs: Int) {
        self.legs = legs
        super.init(name: "Nacho", age: 10)
    }
    
    override func sound() {
        print("Gruauuuuur")
    }

    func eat() {
        print("Eat meat")
    }
    
    class func sleep() {
        print("Sleep 8 hours")
    }
}

//en el código anterior debimos anteponer la keyword class antes del nombre del método de Tipo, como es una clase debe ser así, si fuera una estructura sería la keyword static


//creacion de subclase que hereda y además hace Owerride sobre método de tipo

class Chihuahua1: Dog2 {
    override class func sleep() {
        print("Sleep 16 hours")
    }
}


Chihuahua1.sleep()
//con esto ya podríamos el nuevo valor que modificamos el método de tipo con la keyword class y override








//Override propiedades de la superclase


//creacion de superclase con propiedad

class Dog3: Animal {
    var legs: Int
    var description: String { "Dog" }

    init(name: String, age: Int, legs: Int) {
        self.legs = legs
        super.init(name: name, age: age)
    }

    func eat() {
        print("Eat meat")
    }
}

//creacion de subclase con Override en propiedad

class Chihuahua2: Dog3 {
    override var description: String {
        "Chihuahua 🐶"
    }
}


//instancia de objeto que hereda y sobreescribe propiedad

let chihuahua2 = Chihuahua2(name: "Rodolfo", age: 20, legs: 5)
chihuahua2.description

// RESULTADO 👇
// Chihuahua 🐶






//creacion de superclase con propiedad  de tipo

class Dog4: Animal {
    var legs: Int
    var description: String { "Dog"
}
    class var size: String { "medium" }
    
    init(legs: Int) {
        self.legs = legs
        super.init(name: "SwiftBeta", age: 10)
    }
}

//para indicar en una clase si un método o propiedad es de tipo debemos indicarlo mediante la keyword class anteponiéndose a la propiedad o metodo


//creacion de subclase con Override de una propiedad de tipo

class Chihuahua3: Dog4 {
    override var description: String { "Chihuahua 🐶" }
    override class var size: String { "small" }
}


//instancia de un objeto con sobreescribimiento de propiedades y propiedades de tipo

print(Chihuahua3.size)







//Evitar heredar de una clase

//tenemos como opción también el restringir la herencia de una clase, para lograr esto debemos usar la keyword final delante de nuestra class  a la cual queremos quitarle su capacidad para heredar


//creacion de clase que no hereda

final class Animals {
    var name: String
    var age: Int
    
    init(name: String, age: Int) {

        self.name = name
        self.age = age
    }

    func sound() {
        print("Animals Sounds")
    }
}


//código error implementación herencia de una clase final
//class Dog5: Animals {

//}







//evitar Override de Los métodos de la superclase

//tenemos como opción también el restringir el poder sobreescribir (Override) un método o propiedad de una superclase, para lograr esto debemos usar la keyword final delante de nuestro método o propiedad  a la cual queremos quitarle su capacidad de sobreescribir



//creacion de clase con método que no se puede sobreescribir

class Dog6: Animal {
    var legs: Int
    var description: String { "Dog" }
    init(legs: Int, name: String, age: Int) {
        self.legs = legs
        super.init(name: name, age: age)
    }
    final func eat() {
        print("Eat meat")
    }
}


//código error implementación herencia de una clase con un método que no se puede sobreescribir

class Chihuahua4: Dog6 {
    //codigo erroneo
    //override func eat() {
        //print("Eat Chocolate")
   // }
}




 


//evitar Override de las propiedades de la superclase

//tenemos como opción también el restringir el poder sobreescribir (Override) un método o propiedad de una superclase, para lograr esto debemos usar la keyword final delante de nuestro método o propiedad  a la cual queremos quitarle su capacidad de sobreescribir

//creacion de clase con propiedad que no se puede sobreescribir

class Dog7: Animal {
    var legs: Int
    final var description: String { "Dog" }
    
    init(name: String, age: Int, legs: Int) {
        self.legs = legs
        super.init(name: name, age: age)
    }

    func eat() {
        print("Eat meat")
    }
}

//código error implementación herencia de una clase con una propiedad que no se puede sobreescribir

class Chihuahua5: Dog {
    //codigo erroneo
   // override var description: String { "Chihuahua" }
}


//El poder inhabilitar la capacidad de reescribir un método o propiedad nos permite asegurarnos que hay cierto código que no se va a alterar aunque usemos herencia. Eso nos garantiza mayor seguridad.






//Herencia Frameworks de Apple

//La herencia juega un rol importante en los frameworks de Apple, ejemplo de un button que hereda de Uicontrol que a la vez hereda  de un UiRewponder que hereda de un NsObject, objeto base de Apple
//mapa de herencia componente UiButton

//.   UIButton -> UIControl -> UIView -> UIResponser -> NSObject

