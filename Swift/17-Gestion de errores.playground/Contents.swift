//Gestión de errores Swift
//Error frecuente: usar try? cuando importa la causa o try! sin garantía absoluta.
//El bloque do sí comienza y se interrumpe exactamente donde ocurre throw.

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

//Cabe señalar que estos posibles errores los podemos encapsular en un tipo Enum que además conforme el protocolo Error

//creacion de Enum Que conforma protocolo Error y captura posibles errores

enum DatabaseError: Error {
  case userAlreadyExists
  case usernameTooShort
  case invalidCharacters
}

//en el código anterior hemos capturado todos los posibles errores que se pueden lanzar desde nuestro código cuando intentemos almacenar un nuevo User en la base de datos.

//Creacion de objeto que es capaz de gestionar errores

//throws, throw
struct User {
  func saveUser(name: String) throws -> String {
    if name == "Rodolfo" {
      throw DatabaseError.userAlreadyExists
    }

    guard name.count >= 3 else {
      throw DatabaseError.usernameTooShort
    }

    guard name.allSatisfy({ $0.isLetter || $0.isWhitespace }) else {
      throw DatabaseError.invalidCharacters
    }

    return "Saving user..."
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
//try, do, catch.
let user = User()

do {
  let message = try user.saveUser(name: "Rodolfo")
  print(message)
} catch DatabaseError.userAlreadyExists {
  print("The user already exists")
} catch {
  print("Unexpected error: \(error)")
}

print("End")

//try marca el punto exacto donde una operación puede lanzar un error.
//do
//El bloque do comienza a ejecutarse normalmente. Si una operación lanza un error,
//se interrumpe el resto del bloque y el flujo salta al primer catch compatible.
//catch
//catch recibe el error lanzado. Podemos usar varios catch para distinguir casos y
//un catch final para cubrir cualquier error restante.

//es importante mencionar que esta es la forma correcta de gestionar errores en Swift, con las keywords antes señaladas.
//La gestión de errores hace nuestra aplicación más segura y permite recuperarse o
//informar al usuario. No captura automáticamente fallos como índices fuera de rango,
//force unwrap de nil, precondiciones incumplidas o errores de programación.

//try? Sin do ni catch

// en el código anterior pudimos ver como utilizamos las keyword try, do y catch en conjunto como ejecutamos una función que puede lanzar error y capturar el error si existe

//try?

//try? convierte el resultado en Optional: devuelve nil si se lanza un error y
//descarta la información del error. Es apropiado cuando solo importa éxito o fracaso.

//Este nombre sí provoca el error, que try? transforma en nil.

let user1 = User()

let saveResult = try? user1.saveUser(name: "Rodolfo")
print(saveResult == nil)

//try! afirma que la operación no fallará y cierra el programa si la afirmación es
//incorrecta. Debe reservarse para invariantes realmente garantizadas.
//defer permite ejecutar limpieza al abandonar un ámbito, haya o no un error.
