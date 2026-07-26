//Arreglo
//Error frecuente: usar índices o force unwrap sin comprobar que hay elementos.
//conjunto de datos ordenados que se pueden repetir, de un mismo tipo y se accede a ellos a través de su índice. El índice empieza en la posición cero

//Inicializar arreglo vacio
let numbers1 = [Int]()
let words: [String] = []
let numbers3: [Float] = .init()
let numbers4: [Int] = []
print(numbers1.count, words.count, numbers3.count, numbers4.count)

//Inicializar arreglo con valores
let strings = Array(["Rodolfo", "Martin", "Naxo"])
var numbers = [1, 2, 7]
print(strings)

//Acceder a un valor de un arreglo
//El subíndice no es opcional: usar un índice fuera de numbers.indices provoca
//un error en ejecución. Podemos comprobar numbers.indices.contains(index).
let newNumber = numbers[0]
print(newNumber)

var myNewSkills = ["Swift", "Uikit", "SwiftUI", "CocoaPods"]
//Modificar o crear valor del arreglo
//automáticamente se agregan los valores a la última posición del arreglo
myNewSkills += ["ArKit", "RealityKit"]
numbers[0] = 6

//Ejemplos de algunos métodos comunes en arreglos

//Count
//retorna número con cantidad de elementos dentro del arreglo

print(myNewSkills.count)

//IsEmpty
//retorna Booleano que indica si un arreglo contiene o no contiene elementos
print(myNewSkills.isEmpty)

//método comúnmente ocupado con IF
if myNewSkills.isEmpty {
  print("myNewSkills isEmpty")
} else {
  print("myNewSkills isn't Empty")
}

//First y Last
//Retornan opcionales porque la colección podría estar vacía.
if let firstSkill = myNewSkills.first, let lastSkill = myNewSkills.last {
  print(firstSkill)
  print(lastSkill)
}

//Append
//añadir valores dentro de un arreglo, de forma automática se agrega en la última posición
myNewSkills.append("Tests")

//Insert
//añadir valores dentro de un arreglo, este método acepta 2 parametros, el Parametro a insertar y posición donde queremos añadirlo
myNewSkills.insert("GitHub", at: 2)
print(myNewSkills)

//Contains
//retorna Booleano que indica si un arreglo contiene o no contiene un elemento.  Indicamos como parámetro que estamos buscando.
let containsCombine = myNewSkills.contains(where: { $0 == "Combine" })
print(containsCombine)

//Remove all
//con este método borramos todos los elementos de un arreglo
myNewSkills.removeAll()

//crear un Array que contenga N veces un elemento que nosostros ingresemos como parametro
let fiveZs = Array(repeating: "Z", count: 5)
print(fiveZs)

//cabe señalar que existen más métodos para los arreglos.

//Sets
//conjunto de datos desordenados que no se pueden repetir, los datos tienen que ser de un mismo tipo. Para crear, modificar o acceder a los datos del Set, es a través de métodos.
//los sets ocupan el protocolo Hasheable para saber cuando un tipo de dato en su interior está repetido para luego eliminar la copia y dejar solo 1. Por lo que los datos que no cumplan ese protocolo(estructuras y otros), tenemos que adoptar ese protocolo

//Inicializar Set vacio
var setNumbers = Set<Int>()
let setNumbers2: Set<Int> = []
let setNumbers3: Set<Int> = .init()

//Inicializar Set con valores
let studentID: Set = [112, 114, 116, 118, 115]
let myDevices = Set(["Monitor", "Monitor", "Keyboard", "Laptop", "Mobile"])
let myDevices2: Set<String> = ["Monitor", "Keyboard", "Laptop", "Mobile"]
let myDevices3 = Set(["Monitor", "Keyboard", "Laptop", "Mobile"])
print(setNumbers2.count, setNumbers3.count, studentID.count)
print(myDevices, myDevices2, myDevices3)
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
//En un Set retorna un elemento cualquiera como Optional, porque el Set no tiene
//orden y también puede estar vacío. Nunca debemos forzar este resultado.
if let anyNumber = setNumbers.first {
  print(anyNumber)
} else {
  print("The set is empty")
}

//Insert
//añadir valores dentro del set, este método acepta un parametro que es el valor a insertar.
setNumbers.insert(8)
print(setNumbers)
//cabe señalar que si insertamos un valor ya existente, este se sobreescribira pero no se repetirá

//Contains
////retorna Booleano que indica si un Set contiene o no contiene un elemento.  Indicamos como parámetro que estamos buscando.
var containsNumberSix = setNumbers.contains(where: { $0 == 6 })
print(containsNumberSix)

//RemoveAll
//con este método borramos todos los elementos de un arreglo
setNumbers.removeAll()
print(setNumbers)

//En los Set no se puede ocupar el método Append, tampoco Last y el Insert en los Set reciben solo un parametro.

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
let myDictionary = [String: Int]()
let myDictionary2: [String: String] = .init()
let myDictionary3: [String: String] = [:]
print(myDictionary.count, myDictionary2.count, myDictionary3.count)

//Inicializar Diccionario con valores
var myDictionaryInfo = ["name": 1, "city": 2, "skills": 0]

//crear o modificar datos en un diccionario
myDictionaryInfo["city"] = 3
print(myDictionaryInfo)

//acceder al dato de un diccionario
if let cityValue = myDictionaryInfo["city"] {
  print(cityValue)
}

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

//Casos de uso

//Arreglo

//Almacenamiento de datos
//iteracion  a traves de elementos
//agregar y eliminar elementos
//acceder por indice
//numero de elementos
//verificacion de existencia
//filtrado de elementos
//transformacion de elementos
//ordenamiento
//matrices Bidimensionales

//Set

//eliminacion de duplicados
//operaciones de conjuntos
//verificacion de pertenencias
//filtrado de elementos unicos
//operacion de conjuntos con actualizacion
//eliminacion de elementos
//verificacion de conjunto vacio

//Dict

//almacenamiento de datos relacionados
//acceso valores por clave
//modificacion de valores
//añadir nuevos pares clave-valor
//eliminacion de pares clave-valor
//iteracion a traves de claves y valores
//verificacion de existencia de clave
//diccionario de tipo especifico
//uso de diccionario en funciones
//inicializacion vacia y agregado de elementos
//obtencion de claves y valores
