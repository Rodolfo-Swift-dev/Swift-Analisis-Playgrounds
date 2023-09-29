import UIKit

//Tuplas
//conjunto de elementos que tienen un orden y se puede acceder a ellos a traves de su indice. pueden ser de diferentes tipos de datos

let myUser = ("SwiftBeta", "Aprende", "Swift", 10, true)

print(myUser.0)
print(myUser.1)
print(myUser.2)
print(myUser.3)
print(myUser.4)

// RESULTADO 👇
// SwiftBeta
// Aprende
// Swift
// 10
// true


//tuplas nombradas
let (name, learn, language, score, isProUser) = ("SwiftBeta", "Aprende", "Swift", 10, true)

print(name)
print(learn)
print(language)
print(score)
print(isProUser)

// RESULTADO 👇
// SwiftBeta
// Aprende
// Swift
// 10
// true

//tuplas con tuplas en su interior
let (names, age, phones) = (("martin", "ignacio"), 25, (92423423, 458393))







