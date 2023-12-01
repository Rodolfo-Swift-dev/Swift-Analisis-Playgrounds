import Foundation

//Gestión de errores Swift

//en Swift podemos controlar los errores o posibles errores que ocurren en la ejecución de nuestro codigo.
//la finalidad es identificar, capturar y manejar los errores a través de las keyword try, do, catch, throw y throws.

//cabe señalar que en Swift encontramos tipos de datos Int, String, etc. pero existen unos tipos de datos de tipo error que están predefinidos, por ejemplo para peticion http necesitamos el framework llamado Foundation y dentro de este framework encontraremos el tipo de error URLError.
//lo anterior con la finalidad de que tengas presente que en ocasiones como desarrollador iOS tendremos que identificar y manejar errores proporcionados por Swift y a veces tendremos que crear y gestionar nuestros propios errores





//Crear un tipo de error

//para crear errores primero tenemos que identificar posibles errores según la funcionalidad de nuestro código. Ejemplo almacenar un User en una base de datos, los posibles errores serían

//el usuario ya existe
//el nombre de usuario es demasiado corto
//los caracteres no cumplen con los permitidos
//etc

Cabe señalar que estos posibles errores los podemos encapsular en un tipo Enum que además conforme el protocolo Error

//creacion de Enum Que conforma protocolo Error y captura posibles errores

enum DatabaseError: Error {
    case userAlreadyExists
    case usernameTooShort
    case invalidCharacters
}

//en el código anterior hemos capturado todos los posibles errores que se pueden lanzar desde nuestro código cuando intentemos almacenar un nuevo User en la base de datos.



//Creacion de objeto que es capaz de gestionar errores

Struct User {

enum DatabaseError: Error {
    case userAlreadyExists
    case usernameTooShort
    case invalidCharacters
}

func saveUser(name: String) throws {

    if name == "SwiftBeta" {
        throw DatabaseError.userAlreadyExists
    } else {
        print("Saving user...")
    }
  }
}

//en este código podemos ver los pasos necesarios para gestionar errores de forma correcta

//crear un Enum que conforme el protocolo Error con los posibles errores relacionados a la funcionalidad del código
//throws
//con la keyword throws después de los parámetros del método, es que facultamos a nuestra función para que pueda lanzar errores
//throw
//con la keyword throw dentro de la función podemos lanzar el error específico del Enum siempre y cuando pase por un filtro y verifiquemos que el error corresponda

//el método creado anteriormente verifica el nombre que es ingresado y lanza un error si no reúne las condiciones implementadas en la cláusula if y else. Cabe señalar que a esta altura hemos lanzado el error pero aún no lo capturamos






//instancia de objeto y captura y manejo de error

let user = User()

do {
    try user.saveUser(name: "SwiftBeta")
} catch {
    print(error)
}

print("End")


//try
//con la keyword try antes del llamado de la funcion y dentro de las llaves del do, le indicamos al compilador que estamos conscientes que puede lanzar un error y que aún así  intente ejecutar la función. A esta altura aún no capturamos nuestro error
//do
//Con la keyword do le indicamos que haga, que actúe. Dentro del do estará el try lanzando el método y en caso de que llegue a haber un error no se ejecuta el do y se ejecuta el catch
//catch
Con la keyword catch estamos capturando el error en caso de que lo hubiese. El catch trabaja en conjunto con el do y se activa uno o el otro.

//es importante mencionar que esta es la forma correcta de gestionar errores en Swift, con las keywords antes señaladas.
//con la gestión de errores evitamos que nuestra App sea segura y no se bloquee ni cierre en ejecución, además de retroalimentarnos de los errores actuales y también poder transmitir información al usuario, como en el ejemplo anterior, si es que el nombre ya existe, le indicamos al usuario y le solicitamos que ingrese otro.




//try? Sin do ni catch

// en el código anterior pudimos ver como utilizamos las keyword try, do y catch en conjunto como ejecutamos una función que puede lanzar error y capturar el error si existe



//try?

//con try? cláusula podemos omitir las keyword do y catch e intentar ejecutar nuestra función, pero esto nos condiciona a saber solo si existe error pero no es capturado por lo tanto no conseguimos mayor información, al contrario de cuanto trabajamos con do y catch

//instancia de objeto y que arroja error y no es capturado

let user = User()

try? user.saveUser(name: "SwiftBeta")


//aunque este método no es completo y la mejor forma es gestión y manejo de errores, pero tal vez en ciertas ocasiones necesitemos no tanta información ni manejar errores y aquí es donde podremos ocupar la cláusula try?

