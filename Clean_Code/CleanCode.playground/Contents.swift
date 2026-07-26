import Foundation

// MARK: - Clean Code aplicado a Swift e iOS

/*
 Clean Code no significa escribir la menor cantidad posible de líneas.
 Significa que el comportamiento, las dependencias y los límites del código
 pueden entenderse y modificarse sin introducir sorpresas.

 Este playground estudia:
 - nombres y diseño de APIs;
 - funciones, estado y efectos secundarios;
 - tipos que evitan estados inválidos;
 - Optional, throws y errores;
 - inyección de dependencias;
 - concurrencia y aislamiento;
 - memoria con ARC;
 - pruebas y refactorización;
 - límites: cuándo una abstracción empeora el código.

 Los ejemplos usan Foundation para poder representar situaciones de una app
 iOS sin depender de una interfaz gráfica ni realizar llamadas de red reales.
 */

// MARK: - Modelo utilizado en los ejemplos

struct UserProfile: Equatable, Sendable {
  let id: UUID
  let name: String
  let email: String
}

let sampleProfile = UserProfile(
  id: UUID(),
  name: "Rodolfo",
  email: "rodolfo@example.com"
)

// MARK: - 1. Nombres y claridad en el punto de uso

/*
 BAD: get(_:_:) no comunica qué obtiene ni qué representa cada argumento.
 Las abreviaciones y los nombres genéricos trasladan el esfuerzo al lector:

 func get(_ p: Double, _ d: Double) -> Double {
     p - (p * d)
 }
 */

/*
 GOOD: el nombre, las etiquetas y los tipos permiten leer la llamada como una
 frase. En Swift, los tipos usan UpperCamelCase y los demás símbolos,
 lowerCamelCase.
 */

func discountedPrice(for subtotal: Double, rate discountRate: Double) -> Double {
  subtotal - (subtotal * discountRate)
}

let checkoutPrice = discountedPrice(for: 100, rate: 0.20)
assert(checkoutPrice == 80)

/*
 LÍMITE:
 Un nombre largo no es automáticamente mejor. Debe agregar información útil
 sin repetir lo que los tipos y el contexto ya expresan.
 */

// MARK: - 2. let, var y alcance del estado

/*
 BAD: el estado global puede cambiar desde cualquier parte y hace que el
 resultado dependa del orden de ejecución:

 var globalCartTotal = 0.0

 func addToGlobalCart(price: Double) {
     globalCartTotal += price
 }
 */

/*
 GOOD: se mantiene el estado dentro del tipo responsable. private(set) permite
 leer el total desde fuera, pero solamente ShoppingCart puede modificarlo.
 */

struct ShoppingCart {
  private(set) var total = 0.0

  mutating func addItem(price: Double) {
    total += price
  }
}

var shoppingCart = ShoppingCart()
shoppingCart.addItem(price: 25)
assert(shoppingCart.total == 25)

/*
 COMPORTAMIENTO:
 - let expresa que un valor no debe reasignarse.
 - var se reserva para el estado que realmente cambia.
 - private y private(set) reducen los lugares desde los que puede mutarse.

 LÍMITE:
 La mutabilidad no es incorrecta. El problema es la mutabilidad compartida,
 innecesaria o accesible desde demasiados lugares.
 */

// MARK: - 3. Funciones pequeñas y un nivel de abstracción

struct OrderLine {
  let unitPrice: Double
  let quantity: Int
}

/*
 BAD: mezcla validación, cálculo y presentación. También devuelve un String,
 lo que impide reutilizar el resultado numérico:

 func processOrder(unitPrice: Double, quantity: Int) -> String {
     if quantity <= 0 {
         return "Cantidad inválida"
     }

     let subtotal = unitPrice * Double(quantity)
     let total = subtotal > 100 ? subtotal * 0.9 : subtotal
     return "Total: \(total)"
 }
 */

enum OrderValidationError: Error {
  case invalidQuantity
  case negativePrice
}

func validate(_ line: OrderLine) throws {
  guard line.quantity > 0 else {
    throw OrderValidationError.invalidQuantity
  }
  guard line.unitPrice >= 0 else {
    throw OrderValidationError.negativePrice
  }
}

func subtotal(for line: OrderLine) -> Double {
  line.unitPrice * Double(line.quantity)
}

func totalApplyingVolumeDiscount(to subtotal: Double) -> Double {
  subtotal > 100 ? subtotal * 0.9 : subtotal
}

/*
 GOOD: la función de alto nivel cuenta la historia del caso de uso y delega
 detalles a funciones con una sola intención.
 */

func checkoutTotal(for line: OrderLine) throws -> Double {
  try validate(line)
  return totalApplyingVolumeDiscount(to: subtotal(for: line))
}

let orderTotal = try checkoutTotal(for: OrderLine(unitPrice: 60, quantity: 2))
assert(orderTotal == 108)

/*
 LÍMITE:
 No existe un número universal de líneas permitido. Extraer una función tiene
 valor cuando nombra una intención, reduce duplicación real o aísla un cambio.
 */

// MARK: - 4. Modelar estados inválidos con tipos

/*
 BAD: cualquier String puede representar un nombre, incluso una cadena vacía.
 Cada consumidor tendría que recordar validarlo:

 struct ProfileDraft {
     let displayName: String
 }
 */

enum DisplayNameError: Error {
  case empty
}

struct DisplayName: Sendable {
  let value: String

  init(_ value: String) throws {
    let normalizedValue = value.trimmingCharacters(in: .whitespacesAndNewlines)
    guard !normalizedValue.isEmpty else {
      throw DisplayNameError.empty
    }
    self.value = normalizedValue
  }
}

struct ProfileDraft: Sendable {
  let displayName: DisplayName
}

let displayName = try DisplayName("  Rodolfo  ")
let profileDraft = ProfileDraft(displayName: displayName)
assert(profileDraft.displayName.value == "Rodolfo")

/*
 COMPORTAMIENTO:
 Después de construir DisplayName, el resto del programa puede confiar en su
 invariante básica. La validación queda en un único límite.

 LÍMITE:
 No conviertas cada String o Int en un tipo nuevo. Hazlo cuando el dominio
 tenga reglas propias o confundir valores pueda provocar errores.
 */

// MARK: - 5. Optional, guard y ausencia de valores

/*
 BAD: force unwrap finaliza el proceso si displayName es nil:

 func greeting(displayName: String?) -> String {
     "Hola, \(displayName!)"
 }
 */

/*
 GOOD: nil-coalescing es apropiado cuando existe un fallback válido.
 */

func greeting(displayName: String?) -> String {
  "Hola, \(displayName ?? "Invitado")"
}

assert(greeting(displayName: nil) == "Hola, Invitado")

/*
 GOOD: optional binding permite continuar solamente cuando existe un valor.
 */

func normalizedToken(_ token: String?) -> String? {
  guard let token, !token.isEmpty else {
    return nil
  }
  return token.trimmingCharacters(in: .whitespacesAndNewlines)
}

assert(normalizedToken(" abc ") == "abc")
assert(normalizedToken(nil) == nil)

/*
 LÍMITE:
 - Usa fallback solo si representa un comportamiento correcto del negocio.
 - Usa throws cuando la ausencia impide completar la operación.
 - Reserva force unwrap para invariantes demostrables; si pueden romperse por
   datos externos o estado de usuario, no son invariantes.
 */

// MARK: - 6. Errores que conservan información

enum ProfileDecodingError: Error {
  case invalidPayload
  case missingName
}

private struct ProfilePayload: Decodable {
  let name: String
}

/*
 BAD: nil no explica si faltaba el nombre o si el documento estaba corrupto:

 func decodeName(from data: Data) -> String? {
     try? JSONDecoder().decode(ProfilePayload.self, from: data).name
 }
 */

/*
 GOOD: throws obliga al consumidor a considerar el error y conserva su causa.
 */

func decodeName(from data: Data) throws -> String {
  let payload: ProfilePayload
  do {
    payload = try JSONDecoder().decode(ProfilePayload.self, from: data)
  } catch {
    throw ProfileDecodingError.invalidPayload
  }

  guard !payload.name.isEmpty else {
    throw ProfileDecodingError.missingName
  }
  return payload.name
}

let profileData = Data(#"{"name":"Rodolfo"}"#.utf8)
let decodedName = try decodeName(from: profileData)
assert(decodedName == "Rodolfo")

/*
 LÍMITE:
 No todos los resultados ausentes son errores. first(where:) devuelve Optional
 porque no encontrar un elemento puede ser una situación normal.
 */

// MARK: - 7. Comentarios y documentación

/*
 BAD:
 total += fee // Suma la tarifa al total

 El comentario repite la sintaxis y puede quedar desactualizado.

 GOOD:
 El comentario explica una decisión que el código no puede expresar:
 */

/// Calcula el cargo de servicio aplicado en el checkout.
///
/// La tienda absorbe el cargo en pedidos de 50 o más para mantener la regla
/// comercial acordada con soporte.
///
/// - Parameter subtotal: Valor previo a impuestos y envío.
/// - Returns: `0` cuando la tienda absorbe el cargo; `2.5` en los demás casos.
func serviceFee(for subtotal: Double) -> Double {
  subtotal >= 50 ? 0 : 2.5
}

assert(serviceFee(for: 60) == 0)

/*
 COMPORTAMIENTO:
 - // explica una decisión local o una restricción no evidente.
 - /// documenta una API para Quick Help y DocC.
 - Un buen nombre suele eliminar la necesidad de comentar el "qué".
 */

// MARK: - 8. Separar lógica pura de efectos secundarios

enum AnalyticsEvent: String, Sendable {
  case profileOpened = "profile_opened"
}

protocol AnalyticsTracking {
  func track(event: AnalyticsEvent)
}

struct ConsoleAnalyticsTracker: AnalyticsTracking {
  func track(event: AnalyticsEvent) {
    print("Analytics:", event.rawValue)
  }
}

/*
 La transformación es pura: las mismas entradas producen la misma salida.
 Puede probarse sin red, disco, reloj ni interfaz.
 */

func profileTitle(for profile: UserProfile) -> String {
  profile.name.isEmpty ? "Perfil" : "Perfil de \(profile.name)"
}

/*
 El efecto secundario queda explícito en una dependencia.
 */

struct ProfileOpeningHandler {
  private let analytics: any AnalyticsTracking

  init(analytics: any AnalyticsTracking) {
    self.analytics = analytics
  }

  func execute(profile: UserProfile) -> String {
    analytics.track(event: .profileOpened)
    return profileTitle(for: profile)
  }
}

let consoleHandler = ProfileOpeningHandler(analytics: ConsoleAnalyticsTracker())
let consoleTitle = consoleHandler.execute(profile: sampleProfile)
assert(consoleTitle == "Perfil de Rodolfo")

/*
 LÍMITE:
 No es necesario envolver operaciones triviales como String.uppercased() en un
 protocolo. Abstrae límites variables: red, persistencia, reloj, UUID,
 notificaciones, analytics o frameworks externos.
 */

// MARK: - 9. Inyección de dependencias y testabilidad

protocol ProfileFetching: Sendable {
  func fetchProfile(id: UUID) async throws -> UserProfile
}

enum ProfileRepositoryError: Error, Sendable {
  case notFound
}

struct InMemoryProfileRepository: ProfileFetching {
  private let profiles: [UUID: UserProfile]

  init(profiles: [UUID: UserProfile]) {
    self.profiles = profiles
  }

  func fetchProfile(id: UUID) throws -> UserProfile {
    guard let profile = profiles[id] else {
      throw ProfileRepositoryError.notFound
    }
    return profile
  }
}

/*
 COMPORTAMIENTO:
 La dependencia llega por el inicializador. El ViewModel no crea URLSession,
 una base de datos o un singleton oculto, por lo que puede recibir una
 implementación real, en memoria o simulada.

 LÍMITE:
 Inyección de dependencias no significa que todo deba ser un protocolo. Una
 estructura concreta e inmutable puede ser la dependencia más clara.
 */

// MARK: - 10. Concurrencia: estado de UI en MainActor

@MainActor
final class ProfileViewModel {
  enum State: Equatable {
    case idle
    case loading
    case loaded(UserProfile)
    case failed(message: String)
  }

  private let repository: any ProfileFetching
  private(set) var state: State = .idle

  init(repository: any ProfileFetching) {
    self.repository = repository
  }

  func load(id: UUID) async {
    state = .loading

    do {
      state = .loaded(try await repository.fetchProfile(id: id))
    } catch is CancellationError {
      state = .idle
    } catch {
      state = .failed(message: "No fue posible cargar el perfil")
    }
  }
}

let memoryRepository = InMemoryProfileRepository(
  profiles: [sampleProfile.id: sampleProfile]
)
let loadedProfile = try memoryRepository.fetchProfile(id: sampleProfile.id)
assert(loadedProfile == sampleProfile)

let profileViewModel = ProfileViewModel(repository: memoryRepository)
await profileViewModel.load(id: sampleProfile.id)
assert(profileViewModel.state == .loaded(sampleProfile))

/*
 COMPORTAMIENTO:
 - @MainActor aísla las mutaciones del estado que consume la interfaz.
 - async/await expresa la suspensión sin callbacks anidados.
 - CancellationError se conserva como cancelación, no se presenta como falla.
 - Sendable controla los valores que cruzan dominios de concurrencia.

 LÍMITE:
 @MainActor no debe usarse para ejecutar decodificación o trabajo pesado. Solo
 protege el estado asociado al actor principal; el trabajo debe realizarse en
 la dependencia adecuada.
 */

// MARK: - 11. ARC y ciclos de retención

final class SearchController {
  var onRefresh: (() -> Void)?
  private(set) var refreshCount = 0

  func configureRefresh() {
    /*
     onRefresh es almacenado por self. Capturar self fuertemente aquí
     produciría el ciclo self -> closure -> self.
     */
    onRefresh = { [weak self] in
      self?.refreshCount += 1
    }
  }
}

let searchController = SearchController()
searchController.configureRefresh()
searchController.onRefresh?()
assert(searchController.refreshCount == 1)

/*
 LÍMITE:
 [weak self] no debe agregarse mecánicamente a cada closure. Es necesario
 cuando la relación de propiedad puede formar un ciclo o cuando no se desea
 prolongar la vida del objeto. unowned solo es seguro cuando la vida útil de
 la referencia capturada está garantizada.
 */

// MARK: - 12. Pruebas del comportamiento

final class AnalyticsSpy: AnalyticsTracking {
  private(set) var receivedEvents: [AnalyticsEvent] = []

  func track(event: AnalyticsEvent) {
    receivedEvents.append(event)
  }
}

func verifyProfileOpeningHandler() {
  let analytics = AnalyticsSpy()
  let handler = ProfileOpeningHandler(analytics: analytics)

  let title = handler.execute(profile: sampleProfile)

  assert(title == "Perfil de Rodolfo")
  assert(analytics.receivedEvents == [.profileOpened])
}

verifyProfileOpeningHandler()

/*
 En un playground, assert sirve para hacer verificaciones ejecutables.
 En una app real, las pruebas deben vivir en un test target.

 Ejemplo equivalente con Swift Testing:

 import Testing
 @testable import MyApp

 @Test
 func openingProfileTracksEvent() {
     let analytics = AnalyticsSpy()
     let handler = ProfileOpeningHandler(analytics: analytics)

     let title = handler.execute(profile: sampleProfile)

     #expect(title == "Perfil de Rodolfo")
     #expect(analytics.receivedEvents == [.profileOpened])
 }
 */

// MARK: - 13. DRY sin abstracciones prematuras

/*
 BAD:
 Reutilizar una operación solo porque dos fórmulas se parecen puede unir reglas
 que evolucionan por razones distintas:

 func triangleArea(base: Double, height: Double) -> Double {
     rectangleArea(width: base, height: height) / 2
 }
 */

func rectangleArea(width: Double, height: Double) -> Double {
  width * height
}

/*
 GOOD:
 La fórmula del triángulo queda explícita. Una pequeña repetición accidental
 puede ser más limpia que una dependencia conceptual falsa.
 */

func triangleArea(base: Double, height: Double) -> Double {
  base * height / 2
}

assert(rectangleArea(width: 10, height: 4) == 40)
assert(triangleArea(base: 10, height: 4) == 20)

/*
 LÍMITE:
 DRY se aplica al conocimiento y a las reglas de negocio duplicadas, no a cada
 par de líneas visualmente parecido.
 */

// MARK: - 14. Refactorización conserva comportamiento

func legacyShippingCost(subtotal: Double) -> Double {
  if subtotal >= 50 {
    return 0
  }
  return 4.99
}

enum ShippingPolicy {
  static let freeShippingThreshold = 50.0
  static let standardCost = 4.99
}

/*
 GOOD: se nombran los valores y se simplifica el flujo, pero las entradas siguen
 produciendo los mismos resultados.
 */

func shippingCost(subtotal: Double) -> Double {
  guard subtotal < ShippingPolicy.freeShippingThreshold else {
    return 0
  }
  return ShippingPolicy.standardCost
}

for subtotal in [0.0, 49.99, 50, 120] {
  assert(legacyShippingCost(subtotal: subtotal) == shippingCost(subtotal: subtotal))
}

// MARK: - Checklist final

/*
 Antes de considerar "limpio" un cambio, pregunta:

 1. ¿La llamada puede entenderse sin abrir la implementación?
 2. ¿Los tipos representan las reglas importantes del dominio?
 3. ¿Los errores y la ausencia de valores tienen significado explícito?
 4. ¿Los efectos secundarios están visibles y aislados?
 5. ¿El estado mutable tiene un propietario claro?
 6. ¿Las dependencias variables pueden sustituirse en pruebas?
 7. ¿El código concurrente respeta aislamiento, Sendable y cancelación?
 8. ¿Los comentarios explican decisiones y límites, no la sintaxis?
 9. ¿Las pruebas verifican comportamiento observable?
 10. ¿La abstracción resuelve una variación real o solo agrega capas?

 Clean Code es contextual. La solución más limpia es la más simple que hace
 explícito el comportamiento requerido y permite cambiarlo con seguridad.
 */
