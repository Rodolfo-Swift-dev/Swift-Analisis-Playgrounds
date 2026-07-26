//Niveles de control de acceso en Swift
//Error frecuente: declarar todo public o enseñar solo private. Swift dispone de
//open, public, package, internal, fileprivate y private.

//Swift tiene seis niveles de acceso, ordenados aquí desde el contexto más amplio al
//más restringido:
//open, public, package, internal, fileprivate y private.
//
//El nivel de una declaración también está limitado por los tipos que aparecen en su
//firma: una API public, por ejemplo, no puede exponer un tipo internal.

//estos se pueden aplicar a propiedades, métodos, extensiones, etc. incluso tipos(Struct, Class y Enum). Con los tipos resulta muy útil ya que podemos restringir el acceso, de esta manera solo ciertas partes del código son visibles desde “fuera” del tipo.

//Private acces level

//Private en propiedades

//private es el nivel más restrictivo y uno de los más utilizados.

//creacion de tipo con 2 variables de instancia e instancia del objeto

struct User {
  var name: String
  var language: String
}

let user = User(
  name: "Roodolfo",
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

  init(language: String) {

    self.language = language
  }
}

//código erróneo
//instancia de tipo con variable privada
//let worker = Worker(name: "Nacho", language: "Swift")

let worker = Worker(language: "Swift")

//print(worker.name) // ❌ Error
print(worker.language)

// RESULTADO 👇
// 'name' is inaccessible due to 'private' protection level

//private permite acceso desde la declaración que lo contiene y desde extensiones del
//mismo tipo ubicadas en este archivo. No puede accederse desde una instancia externa.
//Esto oculta detalles de implementación que no forman parte de la API.

extension Worker {
  func displayedName() -> String {
    name
  }
}

print(worker.displayedName())

//Private en métodos

//los private en métodos funcionan de la misma forma que los Private en propiedades.

//Anteponemos private al método para que solo pueda utilizarse dentro de su ámbito y
//en extensiones del mismo tipo escritas en este archivo.

//creacion de tipo con 2 variables de instancia y 1 metodo privado

struct User1 {
  private(set) var name: String
  var language: String

  mutating func rename(to newName: String) {
    updateName(to: newName)
  }

  private mutating func updateName(to newName: String) {
    name = newName
  }
}

//código erróneo
//instancia de tipo con método privado

var user1 = User1(
  name: "Rodolfo",
  language: "Swift")

user1.rename(to: "Rodolfo González")

print(user1.name)

//fileprivate
//Permite usar la declaración desde cualquier código del mismo archivo fuente. Es más
//amplio que private, pero continúa ocultándola para los demás archivos del módulo.
private struct FileCache {
  var entries: [String] = []
}

private var fileCache = FileCache()
fileCache.entries.append("Swift")
print(fileCache.entries)

//internal
//Es el nivel predeterminado cuando no escribimos un modificador. La declaración se
//puede usar desde cualquier archivo del mismo módulo, pero no desde otro módulo.
internal struct ModuleService {
  func execute() {
    print("Internal: visible dentro del módulo")
  }
}

ModuleService().execute()

//package
//Disponible desde Swift 5.9. Permite compartir una declaración entre módulos del
//mismo Swift Package y la oculta a clientes externos. Solo puede declararse cuando
//el código se compila como parte de un package, por eso no se activa en este
//playground independiente:
//
// package struct PackageService { }

//public
//Permite usar una API desde otros módulos. Una clase public no puede heredarse ni
//sus miembros sobrescribirse fuera del módulo, salvo que sean open.
public struct PublicProfile {
  public let name: String

  public init(name: String) {
    self.name = name
  }
}

print(PublicProfile(name: "Rodolfo").name)

//open
//Es el acceso más amplio y solo se aplica a clases y miembros de clases. Además de
//ser visible fuera del módulo, permite herencia y override externos.
open class ExtensibleScreen {
  public init() {}

  open func render() {
    print("Render base")
  }
}

final class LocalScreen: ExtensibleScreen {
  override func render() {
    print("Render personalizado")
  }
}

LocalScreen().render()

//casos de usos
