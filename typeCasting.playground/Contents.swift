import UIKit

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


