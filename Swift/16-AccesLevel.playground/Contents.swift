import Foundation

//Level Access Private en Swift



//Tipos control de acceso
//en Swift tenemos 5 keyword con la cuales podemos restringir el acceso del código

//Private
//Open
//Public
//Internal
//FilePrivate

//estos se pueden aplicar a propiedades, métodos, extensiones, etc. incluso tipos(Struct, Class y Enum). Con los tipos resulta muy útil ya que podemos restringir el acceso, de esta manera solo ciertas partes del código son visibles desde “fuera” del tipo.






//Private acces level

//Private en propiedades

//el control de acceso Private es el más restrictivo de los 5 y también es uno de los más utilizados


//creacion de tipo con 2 variables de instancia e instancia del objeto

struct User {
    var name: String
    var language: String
}

let user = User(name: "Roodolfo",
                language: "Swift")

print(user.name)
print(user.language)

// RESULTADO 👇
// Rodolfo
// Swift

//como podemos ver, tras Instanciar el objeto podemos acceder a sus 2 propiedades incluso ya estando fuera del tipo. Si quisiéramos restringir que solo dentro del tipo que tengamos acceso a una propiedad y no en sus instancias, para esto debemos ocupar private



//creacion de tipo con 1 variable de instancia y 1 variable privada

struct Worker {
    private var name: String = "Rodolfo"
    var language: String
    
    init( language: String) {
     
        self.language = language
    }
}


//código erróneo
//instancia de tipo con variable privada
//let worker = Worker(name: "Nacho", language: "Swift")

let worker = Worker( language: "Swift")

//print(worker.name) // ❌ Error
print(worker.language)

// RESULTADO 👇
// 'name' is inaccessible due to 'private' protection level


//al hacer una propiedad privase le indicamos que esta propiedad solo es accesible desde dentro de la implementación del tipo y no desde fuera(instancia)
//esto nos permite ocultar que digo que no es necesario exponerlo más allá de su propio tipo y así garantizamos seguridad ante un error de mal uso de ese código









//Private en métodos

//los private en métodos funcionan de la misma forma que los Private en propiedades.

//debemos agregar la keyword Prevate antes del método y con estamos restringiendo el acceso a su código desde instancias, solo se puede acceder a través de su tipo nada más


//creacion de tipo con 2 variables de instancia y 1 metodo privado

struct User1 {
    var name: String
    var language: String
    
    private func update(name: String) {
        print(name)
    }
}


//código erróneo
//instancia de tipo con método privado

let user1 = User1(name: "Rodolfo",
                language: "Swift")


//codigo erroneo
//user1.update(name: "Youtube")
// RESULTADO
// error: 'update' is inaccessible due to 'private' protection level


print(user1.name)

//casos de usos


