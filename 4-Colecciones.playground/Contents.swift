import UIKit


//Arreglo
//conjunto de datos ordenados que se pueden repetir, de un mismo tipo y se accede a ellos a través de su índice. El índice empieza en la posición cero

//Inicializar arreglo vacio
var numbers1 = [Int]()
var words: [String] = []
var numbers3: [Float] = .init()
var numbers4: Array<Int> = []

//Inicializar arreglo con valores
var strings = Array(["Swift", "Xcode", "SwiftUI"])
var numbers = [1, 2, 7]

//Acceder a un valor de un arreglo
//recomendable ver cuántos datos tiene el arreglo y luego podemos acceder al índice de forma segura si no nos arroja error.
var newNumber = numbers[0]

//Modificar o crear valor del arreglo
//automáticamente se agregan los valores a la última posición del arreglo
myNewSkills += ["UITableView", "UICollectionView"]
numbers[0] = 6


//Ejemplos de algunos métodos comunes en arreglos

//Count
//retorna número con cantidad de elementos dentro del arreglo
var myNewSkills = ["Combine", "TDD", "SnapshotTests", "Swift Package Manager"]
print(myNewSkills.count)

//IsEmpty
//retorna Booleano que indica si un arreglo contiene o no contiene elementos
myNewSkills.isEmpty

//método comúnmente ocupado con IF
if myNewSkills.isEmpty {
    print("myNewSkills isEmpty")
} else {
    print("myNewSkills isn't Empty")
}

//First y Last
//retorna primer o último elemento de un arreglo respectivamente. Cabe señalar que el dato devuelto por estos métodos es un tipo opcionales por que puede que no existan.
print(myNewSkills.first!)
print(myNewSkills.last!)

//Append
//añadir valores dentro de un arreglo, de forma automática se agrega en la última posición
myNewSkills.append("Tests")

//Insert
//añadir valores dentro de un arreglo, este método acepta 2 parametros, el Parametro a insertar y posición donde queremos añadirlo
myNewSkills.insert("SwiftBeta", at: 2)
print(myNewSkills)

//Contains
//retorna Booleano que indica si un arreglo contiene o no contiene un elemento.  Indicamos como parámetro que estamos buscando.
let containsCombine = myNewSkills.contains(where: { $0 == "Combine"} )
print(containsCombine)

//Remove all
//con este método borramos todos los elementos de un arreglo
myNewSkills.removeAll()

//crear un Array que contenga N veces un elemento que nosostros ingresemos como parametro
let fiveZs = Array(repeating: "Z", count: 5)

//cabe señalar que existen más métodos para los arreglos.




//Sets
//conjunto de datos desordenados que no se pueden repetir, los datos tienen que ser de un mismo tipo. Para crear, modificar o acceder a los datos del Set, es a través de métodos.
//los sets ocupan el protocolo Hasheable para saber cuando un tipo de dato en su interior está repetido para luego eliminar la copia y dejar solo 1. Por lo que los datos que no cumplan ese protocolo(estructuras y otros), tenemos que adoptar ese protocolo

//Inicializar Set vacio
var setNumbers = Set<Int>()
var setNumbers2: Set<Int> = []
var setNumbers3: Set<Int> = .init()

//Inicializar Set con valores
var studentID : Set = [112, 114, 116, 118, 115]
var myDevices = Set(["Monitor", "Keyboard", "Laptop", "Mobile"])
var myDevices2: Set<String> = ["Monitor", "Keyboard", "Laptop", "Mobile"]
var myDevices3 = Set.init(["Monitor", "Keyboard", "Laptop", "Mobile"])
//si engrasamos valores repetidos en nuestro set no se bloque, solo deja 1 dato y elimina las copias


//Ejemplos de algunos métodos comunes en Sets

//Para crear, modificar o acceder a los datos del Set, es a través de métodos.

//Count
//retorna número con cantidad de elementos dentro de un Set
print(setNumbers.count)

//IsEmpty
//retorna Booleano que indica si un Set contiene o no contiene elementos.
//como mencionábamos anteriormente, es recomendable usar este método en verificaciones if.
if setNumbers.isEmpty {
    print("mySetNumbers isEmpty")
} else {
    print("mySetNumbers isn't Empty")
}

//First
//en los set se puede ocupar este método, pero no me arroja el primer valor si no que retorna cualquier valor dentro de la colección pero Opcional. Los set no tienen orden.
print(setNumbers.first!)

//Insert
//añadir valores dentro del set, este método acepta un parametro que es el valor a insertar.
setNumbers.insert(8)
print(setNumbers)
//cabe señalar que si insertamos un valor ya existente, este se sobreescribira pero no se repetirá

//Contains
////retorna Booleano que indica si un Set contiene o no contiene un elemento.  Indicamos como parámetro que estamos buscando.
var containsNumberSix = setNumbers.contains(where: { $0 == 6 } )
print(containsNumberSix)

//RemoveAll
//con este método borramos todos los elementos de un arreglo
setNumbers.removeAll()
print(setNumbers)


//En los Set no se puede ocupar el método Append, tampoco Last y el Insert en Los Set recibe solo un parametro.

//cabe señalar que existen más métodos para los Sets, incluidos métodos particulares para trabajar entre Sets.

//Union
//colección que incluye todos  los elementos entre 2 sets, con datos sin repetirse.
//setA.union(setB))

//Intersection
//colección que incluye todos  los elementos en común entre 2 sets, con datos sin repetirse.
//setA.intersection(setB))

//Subtracting
//colección que incluye elementos del conjunto A, que no están presentes en el conjunto B, con datos sin repetirse.
//setA.subtracting(setB))

//SymmetricDifference
//colección que incluye todos  los elementos No en común entre 2 sets, con datos sin repetirse.
//setA.symmetricDifference(setB))

//IsSubset
//retorna dato booleano que indica si un Set es Subset de otro Set
//setB.isSubset(of: setA))




//Diccionario
//conjunto de datos desordenados que consisten en Key y Valué. Cada valor está asociado a una clave y los key tienen que ser de un mismo tipo y los Valué pueden ser deferente a los Key pero con mismo tipo entre ellos. Para acceder a un Valué tenemos que acceder a través de su Key. Se pueden repetir los Valué, pero no los Key.
//cabe señalar que al momentos de recuperar u obtener el valor correspondiente a una clave en el diccionario, este valor será un dato de tipo opcional.

//Inicializar Diccionario vacío
var myDictionary = [String: Int]()
var myDictionary2: [String: String] = .init()
var myDictionary3: [String: String] = [:]

//Inicializar Diccionario con valores
var myDictionaryInfo = ["name": 1, "city": 2, "skills": 0]

//crear o modificar datos en un diccionario
myDictionaryInfo["city"] = 3
print(myDictionaryInfo)

//acceder al dato de un diccionario
var myCyty = myDictionaryInfo["city"]

//eliminar clave y valor de diccionario
myDictionaryInfo["skills"] = nil
print(myDictionaryInfo)
//Ejemplos de algunos métodos comunes en Diccionarios

//Count
//retorna número con cantidad de elementos dentro de un Diccionario, también cantidad de Keys o cantidad de Values.
print(myDictionaryInfo.count)

//IsEmpty
//retorna Booleano que indica si un Diccionario contiene o no contiene elementos.
//como mencionábamos anteriormente, es recomendable usar este método en verificaciones if.
if myDictionaryInfo.isEmpty {
    print("myDictionaryInfo isEmpty")
} else {
    print("myDictionaryInfo isn't Empty")
}

//UpdateValue
//añadir nueva clave y nuevo valor a diccionario
myDictionaryInfo.updateValue(5, forKey: "twitter")
print(myDictionaryInfo)
//modificar el valor de una clave de nuestro diccionario
myDictionaryInfo.updateValue(10, forKey: "twitter")

//RemoveValue
//eliminar clave y valor de un diccionario, este método nos pedirá un parámetro que será la clave correspondiente al valor que queremos eliminar
myDictionaryInfo.removeValue(forKey: "twitter")
print(myDictionaryInfo)
