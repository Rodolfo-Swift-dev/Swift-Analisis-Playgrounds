import Foundation




//Type casting

//Type casting comprueba o trata una instancia como otro tipo compatible dentro de
//una jerarquía, protocolo o tipo existencial. No convierte el contenido de un valor:
//para transformar "123" en Int se utiliza Int("123"), no as?.

//caracteristicas

//flexibilidad
//podemos manipular instancias de una clase o instancias de sus superclases o subclases

//polimorfismo
//principio clave en programación orientada a objetos
//a una instancia de clase podremos  comprobar el estado real de cada instancia ya que la instancia puede ser estado de superclase o subclase

//comprobacion de tipos en tiempo de ejecución
// una vez hemos dado un tipo a una variable, no podemos cambiar su tipo. Pero en ocasiones tendremos que hacer comprobaciones en el tiempo de ejecución de nuestro código para saber exactamente el tipo de una instancia.

//is comprueba el tipo. as realiza un upcast o coerción conocida por el compilador;
//as? intenta un downcast seguro y retorna Optional; as! fuerza el downcast y provoca
//un error de ejecución si el tipo no coincide.


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




//is devuelve true cuando una instancia es compatible con el tipo consultado.
func findNemo(from animals : [Any]){
    for animal in animals{
        if animal is Fish{//TYPECHECKING
            print("Encontramos una instancia de Fish")
        }
    }
}
findNemo(from: neighbors)








//as realiza una conversión de tipo garantizada, como subir desde Fish hacia Animal.
//El objeto no cambia; cambia el tipo estático desde el que lo observamos.
let aquaticAnimal = nemo as Animal
print(aquaticAnimal.name)

//as! fuerza un downcast. Después de comprobar is, este cast concreto es seguro,
//pero normalmente as? evita depender de que ambas operaciones permanezcan juntas.
func findinNemo1(from animals : [Any]){
    for animal in animals{
        if animal is Fish{//TYPECHECKING
            let pececillo = animal as! Fish// DOWNCAST
            print(pececillo.name)
            pececillo.respirarBajoAgua()
            
        }
    }
}
findinNemo1(from: neighbors)

//ERROR en tiempo de ejecucion por que el downcast no corresponde a la subclase
//let pescado = neighbors[0] as! Fish

//as?
if let pescado = neighbors[2] as? Fish{//secure DOWNCAST
    
    pescado.respirarBajoAgua()
    
}else{
    print("Not fish")
}








//as? combina la comprobación y el downcast en una sola operación segura.
func findinNemo2(from animals : [Any]){
    for animal in animals{
        if let pescado = animal as? Fish {
            print(pescado.name)
            pescado.respirarBajoAgua()
        }
    }
}

findinNemo2(from: neighbors)


let numericText = "123"
if let convertedNumber = Int(numericText) {
    print("Conversión de contenido: \(convertedNumber)")
}

//as? no analiza ni modifica el contenido. Solo verifica en tiempo de ejecución si
//la instancia ya es compatible con el tipo solicitado y devuelve ese valor o nil.

//El resultado de as? se consume normalmente con optional binding. Forzar ese
//Optional elimina la seguridad obtenida y puede cerrar la aplicación cuando es nil.






//Polimorfismo y TypeCasting


//en Swift podemos ocupar el poliformismo con herencia de clases y typecasting
//ejemplo podemos tener una superclase animal que tiene propiedad de instancia name y subclases cat, dog y bird Que heredan de animal, cada subclase tendrá un método el cual será un sonido correspondiente al animal.
//si creáramos un arreglo de tipo animal en el cual incluyéramos una instancia de cat, dog y bird, no hay inconveniente ya que los 3 objetos son de tipo animal.
//si iteraramos sobre el arreglo animals y quisiéramos ocupar el método correspondiente de cada animal como podríamos saber si es cat, dog o bird, ya que dentro del arreglo son de tipo animal.
//as!
//as! afirma que el valor es del subtipo solicitado. Si la afirmación es falsa, el
//programa se detiene en ejecución.
//as?
//as? intenta tratar el valor como el subtipo y retorna un Optional. Con if let
//ejecutamos el bloque solamente cuando el downcast es válido.





//creacion de superclase

class Animal1 {
    var name: String
    init(name: String) {
        self.name = name
    }
}



//creacion de subclases

class Dog1: Animal1 {
    func ladrido() {
        print("\(name) ladrido: Guau Guau!")
    }
}

class Cat1: Animal1 {
    func maullido() {
        print("\(name) maullido: Miau Miau!")
    }
}

class Bird1: Animal1 {
    func canto() {
        print("\(name) canto: Pio Pio!")
    }
}



//instancia de tipos que heredan de superclase Animal

let animals: [Animal1] = [Dog1(name: "Perro"),
                         Cat1(name: "Gato"),
                         Bird1(name: "Pájaro")]




//ocupar métodos de forma correcta con type casting

func SoundAnimals(from animals : [Animal1]){
    for animal in animals {
        if let dog = animal as? Dog1 {
            dog.ladrido()
        } else if let cat = animal as? Cat1 {
            cat.maullido()
        } else if let bird = animal as? Bird1 {
            bird.canto()
        }
    }
}
SoundAnimals(from: animals)



// RESULTADO 👇
// Perro ladrido: Guau Guau!
// Gato maullido: Miau Miau!
// Pájaro canto: Pio Pio!


//En este caso, por cada elemento del Array comprobamos si se puede transformar en los tipos de la instancia que contiene el Array animal, y si es posible se ejecuta su scope




//-is (TYPECHECKING)
//-as (UPCAST)
//-as! (DOWNCAST)
//-as? (secure DOWNCAST)
