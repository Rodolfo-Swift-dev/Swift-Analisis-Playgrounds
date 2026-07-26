import Foundation

// MARK: - SOLID aplicado a una funcionalidad iOS

/*
 SOLID reúne cinco principios para controlar las razones de cambio, diseñar
 contratos sustituibles y dirigir las dependencias hacia las reglas del
 producto.

 No es una obligación de crear una clase o protocolo para cada operación.
 En Swift también se aplica mediante estructuras, enums, composición,
 funciones, protocolos, actores y value semantics.

 Cada sección contiene:
 - intención;
 - ejemplo problemático;
 - alternativa;
 - comportamiento observable;
 - límites del principio.
 */

// MARK: - Modelo compartido

struct Profile: Codable, Equatable, Sendable {
  let id: UUID
  let name: String
  let email: String
}

let profileID = UUID()
let exampleProfile = Profile(
  id: profileID,
  name: "Rodolfo",
  email: "rodolfo@example.com"
)

enum ProfileFeatureError: Error, Sendable {
  case notFound
  case invalidData
  case invalidResponse(statusCode: Int?)
}

// MARK: - S · Single Responsibility Principle (SRP)

/*
 INTENCIÓN:
 Un tipo debe tener una razón cohesionada para cambiar. "Responsabilidad" no
 significa necesariamente "un solo método"; significa que cambios de UI, red,
 decodificación y persistencia no deberían obligar a editar el mismo tipo.

 BAD:
 Este controlador mezcla decodificación, almacenamiento y presentación. En una
 app real también terminaría coordinando UIKit o SwiftUI:

 final class ProfileController {
     private var cachedProfiles: [UUID: Profile] = [:]

     func loadProfile(from data: Data) throws -> String {
         let profile = try JSONDecoder().decode(Profile.self, from: data)
         cachedProfiles[profile.id] = profile
         return "Perfil de \(profile.name)"
     }
 }
 */

/*
 GOOD:
 Cada tipo encapsula una causa diferente de cambio.
 */

struct ProfileDecoder {
  func decode(_ data: Data) throws -> Profile {
    do {
      return try JSONDecoder().decode(Profile.self, from: data)
    } catch {
      throw ProfileFeatureError.invalidData
    }
  }
}

actor ProfileCache {
  private var storage: [UUID: Profile] = [:]

  func save(_ profile: Profile) {
    storage[profile.id] = profile
  }

  func profile(id: UUID) -> Profile? {
    storage[id]
  }
}

func profileTitle(for profile: Profile) -> String {
  "Perfil de \(profile.name)"
}

struct ProfileImporter {
  let decoder: ProfileDecoder
  let cache: ProfileCache

  func execute(data: Data) async throws -> Profile {
    let profile = try decoder.decode(data)
    await cache.save(profile)
    return profile
  }
}

let encodedProfile = try JSONEncoder().encode(exampleProfile)
let decodedProfile = try ProfileDecoder().decode(encodedProfile)
assert(decodedProfile == exampleProfile)
assert(profileTitle(for: decodedProfile) == "Perfil de Rodolfo")

let profileCache = ProfileCache()
let profileImporter = ProfileImporter(
  decoder: ProfileDecoder(),
  cache: profileCache
)
let importedProfile = try await profileImporter.execute(data: encodedProfile)
let cachedProfile = await profileCache.profile(id: importedProfile.id)
assert(cachedProfile == importedProfile)

/*
 COMPORTAMIENTO:
 - Cambiar JSON por otro formato afecta al decoder.
 - Cambiar la persistencia afecta al cache.
 - Cambiar el texto visible afecta a profileTitle(for:).
 - ProfileImporter conserva la responsabilidad de coordinar el caso de uso.

 LÍMITE:
 Dividir hasta crear tipos sin significado aumenta navegación y acoplamiento.
 SRP busca cohesión y razones de cambio, no un método por archivo.
 */

// MARK: - O · Open/Closed Principle (OCP)

/*
 INTENCIÓN:
 Permitir una variación prevista agregando una implementación, sin reescribir
 el flujo estable que la consume.

 BAD:
 Cada proveedor nuevo obliga a modificar el enum y el switch:

 enum AnalyticsProvider {
     case console
     case diagnostics
 }

 func track(event: String, provider: AnalyticsProvider) -> String {
     switch provider {
     case .console:
         return "Console: \(event)"
     case .diagnostics:
         return "Diagnostics: \(event)"
     }
 }
 */

/*
 GOOD:
 El flujo depende del comportamiento AnalyticsTracking. Agregar otro proveedor
 no modifica ProfileAnalytics.
 */

enum AnalyticsEvent: String, Sendable {
  case profileOpened = "profile_opened"
}

protocol AnalyticsTracking {
  func track(event: AnalyticsEvent)
}

struct ConsoleAnalytics: AnalyticsTracking {
  func track(event: AnalyticsEvent) {
    print("Console:", event.rawValue)
  }
}

struct DiagnosticsAnalytics: AnalyticsTracking {
  func track(event: AnalyticsEvent) {
    print("Diagnostics:", event.rawValue)
  }
}

struct ProfileAnalytics {
  private let tracker: any AnalyticsTracking

  init(tracker: any AnalyticsTracking) {
    self.tracker = tracker
  }

  func profileOpened() {
    tracker.track(event: .profileOpened)
  }
}

let consoleProfileAnalytics = ProfileAnalytics(tracker: ConsoleAnalytics())
let diagnosticsProfileAnalytics = ProfileAnalytics(tracker: DiagnosticsAnalytics())
consoleProfileAnalytics.profileOpened()
diagnosticsProfileAnalytics.profileOpened()

/*
 COMPORTAMIENTO:
 ProfileAnalytics permanece cerrado frente a la variación "proveedor", pero
 sigue abierto a correcciones y cambios de requisitos.

 LÍMITE:
 OCP no significa que nunca se modifica código existente ni que debamos
 anticipar todas las variaciones. Primero usa tipos concretos; crea el punto de
 extensión cuando exista más de una implementación o una frontera real.
 */

// MARK: - L · Liskov Substitution Principle (LSP)

/*
 INTENCIÓN:
 Toda implementación aceptada por un contrato debe poder sustituirse sin
 romper las expectativas observables del consumidor.

 El contrato incluye más que la firma:
 - valores y errores;
 - precondiciones y postcondiciones;
 - efectos secundarios;
 - cancelación;
 - aislamiento y orden cuando sean relevantes.
 */

protocol AvatarDataLoading {
  func loadAvatar(for profileID: UUID) throws -> Data
}

/*
 BAD:
 Esta implementación cumple la firma, pero devuelve datos vacíos para cualquier
 perfil. Si el consumidor espera .notFound ante ausencia, rompe el contrato:

 struct EmptyAvatarLoader: AvatarDataLoading {
     func loadAvatar(for profileID: UUID) throws -> Data {
         Data()
     }
 }
 */

/*
 GOOD:
 Ambas implementaciones respetan el mismo contrato:
 - retornan datos no vacíos cuando existe el avatar;
 - lanzan .notFound cuando no existe.
 */

struct BundledAvatarLoader: AvatarDataLoading {
  let avatars: [UUID: Data]

  func loadAvatar(for profileID: UUID) throws -> Data {
    guard let data = avatars[profileID], !data.isEmpty else {
      throw ProfileFeatureError.notFound
    }
    return data
  }
}

struct CachedAvatarLoader: AvatarDataLoading {
  let cache: [UUID: Data]

  func loadAvatar(for profileID: UUID) throws -> Data {
    guard let data = cache[profileID], !data.isEmpty else {
      throw ProfileFeatureError.notFound
    }
    return data
  }
}

func avatarSize(using loader: any AvatarDataLoading, profileID: UUID) throws -> Int {
  try loader.loadAvatar(for: profileID).count
}

let avatarBytes = Data([0x01, 0x02, 0x03])
let validAvatarLoaders: [any AvatarDataLoading] = [
  BundledAvatarLoader(avatars: [profileID: avatarBytes]),
  CachedAvatarLoader(cache: [profileID: avatarBytes]),
]

for loader in validAvatarLoaders {
  let loadedAvatarSize = try avatarSize(using: loader, profileID: profileID)
  assert(loadedAvatarSize == 3)
}

/*
 LÍMITE:
 Un protocolo no garantiza por sí solo LSP; el compilador comprueba firmas,
 pero no todas las reglas semánticas. Documenta el contrato y ejecuta la misma
 suite de pruebas contra cada implementación.
 */

// MARK: - I · Interface Segregation Principle (ISP)

/*
 INTENCIÓN:
 Un consumidor no debería depender de operaciones que no necesita. En Swift,
 se prefieren protocolos pequeños orientados al caso de uso del cliente.

 BAD:
 La pantalla de lectura queda acoplada también a escritura y borrado:

 protocol AllProfileOperations {
     func read(id: UUID) async throws -> Profile
     func save(_ profile: Profile) async throws
     func delete(id: UUID) async throws
 }
 */

/*
 GOOD:
 Las capacidades se separan. Un repositorio completo puede conformar varias,
 pero cada cliente declara solamente lo que utiliza.
 */

protocol ProfileReading: Sendable {
  func read(id: UUID) async throws -> Profile
}

protocol ProfileSaving: Sendable {
  func save(_ profile: Profile) async throws
}

protocol ProfileDeleting: Sendable {
  func delete(id: UUID) async throws
}

actor MemoryProfileRepository: ProfileReading, ProfileSaving, ProfileDeleting {
  private var profiles: [UUID: Profile]

  init(profiles: [UUID: Profile] = [:]) {
    self.profiles = profiles
  }

  func read(id: UUID) throws -> Profile {
    guard let profile = profiles[id] else {
      throw ProfileFeatureError.notFound
    }
    return profile
  }

  func save(_ profile: Profile) {
    profiles[profile.id] = profile
  }

  func delete(id: UUID) {
    profiles[id] = nil
  }
}

let memoryProfileRepository = MemoryProfileRepository()
let profileWriter: any ProfileSaving = memoryProfileRepository
try await profileWriter.save(exampleProfile)

let profileReader: any ProfileReading = memoryProfileRepository
let storedProfile = try await profileReader.read(id: profileID)
assert(storedProfile == exampleProfile)

let profileDeleter: any ProfileDeleting = memoryProfileRepository
try await profileDeleter.delete(id: profileID)
do {
  _ = try await profileReader.read(id: profileID)
  assertionFailure("El perfil eliminado no debe estar disponible")
} catch ProfileFeatureError.notFound {
  // Resultado esperado.
}

/*
 COMPORTAMIENTO:
 Cada referencia existencial expone solo read, save o delete. Su superficie de
 dependencia documenta exactamente lo que el consumidor puede hacer.

 LÍMITE:
 Protocolos excesivamente pequeños pueden fragmentar una API cohesionada. No
 dividas operaciones que siempre cambian y se consumen juntas.
 */

// MARK: - D · Dependency Inversion Principle (DIP)

/*
 INTENCIÓN:
 La política de alto nivel no debe quedar controlada por detalles de bajo nivel
 como URLSession, UserDefaults o una base de datos. Ambas partes dependen de un
 contrato definido alrededor de la necesidad del caso de uso.

 Dependency Injection es la técnica utilizada para entregar la dependencia.
 Dependency Inversion es la dirección arquitectónica de esa relación.

 BAD:
 El ViewModel construye el cliente concreto. No puede sustituirse en una prueba
 y cualquier cambio de transporte obliga a editarlo:

 @MainActor
 final class ProfileViewModel {
     private let api = ConcreteProfileAPI()
 }
 */

/*
 GOOD:
 El ViewModel depende de ProfileReading, la capacidad que necesita. La
 implementación se inyecta desde el composition root de la app.
 */

protocol HTTPDataLoading: Sendable {
  func data(for request: URLRequest) async throws -> Data
}

struct URLSessionHTTPClient: HTTPDataLoading {
  private let session: URLSession

  init(session: URLSession = .shared) {
    self.session = session
  }

  func data(for request: URLRequest) async throws -> Data {
    let (data, response) = try await session.data(for: request)

    guard let response = response as? HTTPURLResponse else {
      throw ProfileFeatureError.invalidResponse(statusCode: nil)
    }

    switch response.statusCode {
    case 200..<300:
      return data
    case 404:
      throw ProfileFeatureError.notFound
    default:
      throw ProfileFeatureError.invalidResponse(
        statusCode: response.statusCode
      )
    }
  }
}

struct HTTPDataLoaderStub: HTTPDataLoading {
  let expectedPath: String
  let responseData: Data

  func data(for request: URLRequest) async throws -> Data {
    guard request.url?.path == expectedPath else {
      throw ProfileFeatureError.notFound
    }
    return responseData
  }
}

struct LiveProfileRepository: ProfileReading {
  private let baseURL: URL
  private let client: any HTTPDataLoading
  private let decoder: ProfileDecoder

  init(
    baseURL: URL,
    client: any HTTPDataLoading,
    decoder: ProfileDecoder = ProfileDecoder()
  ) {
    self.baseURL = baseURL
    self.client = client
    self.decoder = decoder
  }

  func read(id: UUID) async throws -> Profile {
    let profileURL =
      baseURL
      .appendingPathComponent("profiles")
      .appendingPathComponent(id.uuidString)
    let data = try await client.data(for: URLRequest(url: profileURL))
    return try decoder.decode(data)
  }
}

@MainActor
final class ProfileViewModel {
  enum State: Equatable {
    case idle
    case loading
    case loaded(Profile)
    case failed
  }

  private let reader: any ProfileReading
  private(set) var state: State = .idle

  init(reader: any ProfileReading) {
    self.reader = reader
  }

  func load(id: UUID) async {
    state = .loading

    do {
      state = .loaded(try await reader.read(id: id))
    } catch is CancellationError {
      state = .idle
    } catch {
      state = .failed
    }
  }
}

@MainActor
func makeLiveProfileViewModel(
  baseURL: URL,
  session: URLSession = .shared
) -> ProfileViewModel {
  let client = URLSessionHTTPClient(session: session)
  let repository = LiveProfileRepository(
    baseURL: baseURL,
    client: client
  )
  return ProfileViewModel(reader: repository)
}

struct ProfileReaderStub: ProfileReading {
  enum Result: Sendable {
    case success(Profile)
    case failure(ProfileFeatureError)
  }

  let expectedID: UUID
  let result: Result

  func read(id: UUID) async throws -> Profile {
    guard id == expectedID else {
      throw ProfileFeatureError.notFound
    }

    switch result {
    case .success(let profile):
      return profile
    case .failure(let error):
      throw error
    }
  }
}

let successfulReader = ProfileReaderStub(
  expectedID: profileID,
  result: .success(exampleProfile)
)
let successfulViewModel = ProfileViewModel(reader: successfulReader)
await successfulViewModel.load(id: profileID)
assert(successfulViewModel.state == .loaded(exampleProfile))

let failingReader = ProfileReaderStub(
  expectedID: profileID,
  result: .failure(.notFound)
)
let failingViewModel = ProfileViewModel(reader: failingReader)
await failingViewModel.load(id: profileID)
assert(failingViewModel.state == .failed)

if let baseURL = URL(string: "https://api.example.com") {
  let repositoryStub = LiveProfileRepository(
    baseURL: baseURL,
    client: HTTPDataLoaderStub(
      expectedPath: "/profiles/\(profileID.uuidString)",
      responseData: encodedProfile
    )
  )
  let liveProfile = try await repositoryStub.read(id: profileID)
  assert(liveProfile == exampleProfile)

  let liveViewModel = makeLiveProfileViewModel(baseURL: baseURL)
  assert(liveViewModel.state == .idle)
} else {
  assertionFailure("La URL de configuración debe ser válida")
}

/*
 En producción:

 let viewModel = makeLiveProfileViewModel(baseURL: configuration.apiURL)

 En pruebas:

 let stub = ProfileReaderStub(
     expectedID: profileID,
     result: .success(exampleProfile)
 )
 let viewModel = ProfileViewModel(reader: stub)
 */

/*
 COMPORTAMIENTO:
 - El ViewModel expresa política de presentación y estados.
 - El repositorio decide cómo obtener datos.
 - El composition root conoce las implementaciones concretas.
 - La prueba sustituye infraestructura sin ejecutar red real.

 LÍMITE:
 DIP no requiere contenedores globales, service locators ni frameworks de
 inyección. La inyección por inicializador suele hacer explícitas las
 dependencias obligatorias y evita objetos parcialmente configurados.
 */

// MARK: - Composición: los cinco principios juntos

/*
 Flujo de una funcionalidad iOS:

 Vista (SwiftUI o UIKit)
     ↓ observa
 ProfileViewModel                  @MainActor
     ↓ depende de ProfileReading   DIP + ISP
 ProfileRepository                red/cache aislados por SRP
     ↓ implementaciones sustituibles y con el mismo contrato LSP
 Live / Memory / Stub

 AnalyticsTracking permite agregar proveedores sin modificar el caso de uso
 estable (OCP).
 */

// MARK: - Verificación manual del contrato

func verifyAvatarLoaderContract(
  makeLoader: () -> any AvatarDataLoading
) throws {
  let loader = makeLoader()
  let data = try loader.loadAvatar(for: profileID)
  assert(!data.isEmpty)

  let missingID = UUID()

  do {
    _ = try loader.loadAvatar(for: missingID)
    assertionFailure("El contrato exige lanzar notFound")
  } catch ProfileFeatureError.notFound {
    // Resultado esperado.
  }
}

try verifyAvatarLoaderContract {
  BundledAvatarLoader(avatars: [profileID: avatarBytes])
}

try verifyAvatarLoaderContract {
  CachedAvatarLoader(cache: [profileID: avatarBytes])
}

// MARK: - Límites y señales de sobrearquitectura

/*
 SOLID debe mejorar la capacidad de cambiar y verificar comportamiento.
 Detente si observas:

 - un protocolo con una única implementación sin frontera variable;
 - tipos que solo reenvían una llamada sin agregar una regla;
 - factories o service locators que ocultan dependencias;
 - decenas de archivos para una funcionalidad trivial;
 - mocks que conocen detalles privados en vez de resultados observables;
 - herencia utilizada solo para compartir código;
 - contratos sin documentar errores, cancelación o aislamiento;
 - abstracciones creadas para variaciones hipotéticas.

 Checklist:

 S — ¿qué cambio obliga a editar este tipo?
 O — ¿qué variación real necesita una extensión estable?
 L — ¿todas las implementaciones conservan el mismo contrato observable?
 I — ¿el consumidor depende solo de las capacidades que utiliza?
 D — ¿la política de la app conoce detalles o declara sus necesidades?

 SOLID es una herramienta de razonamiento, no una meta cuantitativa. La mejor
 arquitectura es la menor estructura que mantiene explícitos sus contratos,
 dependencias y razones de cambio.
 */
