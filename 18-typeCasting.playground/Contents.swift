import Foundation

//Type casting

class Animal{
    var name: String
    init(n : String){
        name = n
    }
}

class Human : Animal{
    func code(){
        print("puede hablar")
    }
}

class Fish : Animal{
    func respirarBajoAgua(){
        print("respirar bajo el agua")
    }
}

let nacho = Human(n: "Nacho")
let martin = Human(n: "Martin")

let nemo = Fish(n: "nemo")

let neighbors : [Any] = [nacho, martin, nemo,1]
// is
func findNemo(from animals : [Any]){
    for animal in animals{
        if animal is Fish{//TYPECHECKING
            let pez = animal as! Fish// DOWNCAST
            print(pez.name)
        }
    }
}
findNemo(from: neighbors)


//as!
func findinNemo(from animals : [Any]){
    for animal in animals{
        if animal is Fish{//TYPECHECKING
            let pececillo = animal as! Fish// DOWNCAST
            print(pececillo.name)
            print(pececillo.respirarBajoAgua())
           
            let animalFish = animal as Any// as UPCAST
            
        }
    }
}
print(findinNemo(from: neighbors))

//ERROR en tiempo de ejecucion por que el downcast no corresponde a la subclase
//let pescado = neighbors[0] as! fish

//as?
if let pescado = neighbors[2] as? Fish{//secure DOWNCAST
    print(pescado.respirarBajoAgua())
}else{
    print("Not fish")
}


//Type casting

//type casting en swift es una manera de comprobar el tipo de una instancia o cambiar el tipo de una instancia por alguna superclase o subclase, todo esto con la finalidad de continuar con el flujo de nuestro programa

//caracteristicas

//flexibilidad
//podemos manipular instancias de una clase o instancias de sus superclases o subclases

//polimorfismo
//principio clave en programación orientada a objetos
//a una instancia de clase podremos  comprobar el estado real de cada instancia ya que la instancia puede ser estado de superclase o subclase

//comprobacion de tipos en tiempo de ejecución
// una vez hemos dado un tipo a una variable, no podemos cambiar su tipo. Pero en ocasiones tendremos que hacer comprobaciones en el tiempo de ejecución de nuestro código para saber exactamente el tipo de una instancia.

//con las keyword is y as podremos comprobar el tipo de una instancia, hacer type casting



//is

//usamos el operador is para comprobar el tipo de una istancia, retornando un true si la instancia es del tipo que especificamos o false si no lo es

//creacion de variable tipo String

var message = "¡Suscríbete a SwiftBeta!"


//consulta con keyword is si variable es de tipo String

if message is String {
    print("Es de tipo String")
} else {
    print("NO es de tipo String")
}

// RESULTADO 👇
// message es de tipo String

//el operador o keyword is nos sirve para comprobar un tipo y dependiendo del resultado controlar el flujo del programa




//as?

//usamos el operador as para convertir una instancia de un tipo a otro, es decir cambiar el tipo.

//Este operador consulta si un tipo se puede convertir

var message = "¡Suscríbete a SwiftBeta!"

if let _ = message as? String {
    print("message es de tipo String")
} else {
    print("message NO es de tipo String")
}

//en el código anterior no tenemos problemas por que es un String pero si fuera una comprobación de si es un Int, ay veces que podremos convertir un String en dato Int(solo cuando tenga solo dígitos y punto o coma según la región)


var stringNumber = "100"

if let _ = stringNumber as? Int {
    print("stringNumber es de tipo String")
} else {
    print("stringNumber NO es de tipo String")
}


//Este operador intenta transformar una instancia al tipo que le especificamos, por eso as se suele usar con ?, de esta manera si no hemos podido transformar el tipo especificado obtenemos un nil

//para desempaquetar el opcional podemos usar el desempaquetamiento forzado pero si no estamos seguros de convertir el tipo de dato y nos arroja un nil tendremos un bloqueo y Error en la aplicación. La forma segura de desenvolver el opcional es con optional binding(if let), el cual asignará el valor a la constante creada para ocuparla en el código if, de lo contrario se ejecutará la sentencia else






//Polimorfismo y TypeCasting


//en Swift podemos ocupar el poliformismo con herencia de clases y typecasting
//ejemplo podemos tener una superclase animal que tiene propiedad de instancia ñame y subclases cat, dog y bird Que heredan de animal, cada subclase tendrá un método el cual será un sonido correspondiente al animal.
//si creáramos un arreglo de tipo animal en el cual incluyéramos una instancia de cat, dog y bird, no hay inconveniente ya que los 3 objetos son de tipo animal.
//si iteraramos sobre el arreglo animals y quisiéramos ocupar el método correspondiente de cada animal como podríamos saber si es cat, dog o bird, ya que dentro del arreglo son de tipo animal.
//as!
//con as! Podríamos afirmar que cierto tipo es de un tipo, pero si no verificamos previamente de que sea así podríamos obtener un Error al esperar un tipo y que no sea el correspondiente.
//as?
//con as? Podemos consultar si un tipo puede ser convertido a otro tipo y si se puede, entonces se convierte, funciona en conjunto con if let, si se puede convertir se ejecuta el código y desempaquetamos el dato, si no se puede se salta el código, según las reglas del if


//creacion de superclase

class Animal {
    var name: String
    init(name: String) {
        self.name = name
    }
}



//creacion de subclases

class Dog: Animal {
    func ladrido() {
        print("\(name) ladrido: Guau Guau!")
    }
}

class Cat: Animal {
    func maullido() {
        print("\(name) maullido: Miau Miau!")
    }
}

class Bird: Animal {
    func canto() {
        print("\(name) canto: Pio Pio!")
    }
}



//instancia de tipos que heredan de superclase Animal

let animals: [Animal] = [Dog(name: "Perro"),
                         Cat(name: "Gato"),
                         Bird(name: "Pájaro")]




//ocupar métodos de forma correcta con type casting

for animal in animals {
    if let dog = animal as? Dog {
        dog.ladrido()
    } else if let cat = animal as? Cat {
        cat.maullido()
    } else if let bird = animal as? Bird {
        bird.canto()
    }
}

// RESULTADO 👇
// Perro ladrido: Guau Guau!
// Gato maullido: Miau Miau!
// Pájaro canto: Pio Pio!


//En este caso, por cada elemento del Array comprobamos si se puede transformar en los tipos de la instancia que contiene el Array animal, y si es posible se ejecuta su scope
