# SOLID en Swift e iOS

Los cinco principios aplicados a una misma funcionalidad de perfiles. La meta no es producir más capas: es controlar razones de cambio, contratos y dirección de dependencias.

## Principios SOLID

### S · Single Responsibility Principle

**Idea:** Un tipo debe tener una razón cohesionada para cambiar. No significa obligatoriamente un método por tipo.

**Comportamiento:** Transporte, decodificación, cache y presentación pueden evolucionar independientemente. Un caso de uso puede conservar la responsabilidad de coordinarlos.

**Límite:** Fragmentar cada instrucción en un tipo distinto aumenta navegación y acoplamiento sin mejorar cohesión.

```swift
struct ProfileDecoder {
    func decode(_ data: Data) throws -> Profile {
        try JSONDecoder().decode(Profile.self, from: data)
    }
}

actor ProfileCache {
    private var profiles: [UUID: Profile] = [:]

    func save(_ profile: Profile) {
        profiles[profile.id] = profile
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
```

### O · Open/Closed Principle

**Idea:** Una variación prevista debe poder extenderse sin reescribir el flujo estable que la consume.

**Comportamiento:** `ProfileAnalytics` acepta nuevos proveedores que respeten el contrato sin agregar casos a un `switch`.

**Límite:** Cerrado no significa intocable. Corrige errores y cambia requisitos. No diseñes puntos de extensión para escenarios puramente hipotéticos.

```swift
enum AnalyticsEvent: String {
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

struct ProfileAnalytics {
    let tracker: any AnalyticsTracking

    func profileOpened() {
        tracker.track(event: .profileOpened)
    }
}

let analytics = ProfileAnalytics(tracker: ConsoleAnalytics())
analytics.profileOpened()

// Agregar FirebaseAnalytics no modifica ProfileAnalytics.
```

### L · Liskov Substitution Principle

**Idea:** Toda implementación aceptada por un contrato debe poder sustituirse sin romper las expectativas del consumidor.

**Comportamiento:** Los loaders retornan datos no vacíos cuando existe un avatar y lanzan `notFound` cuando falta. El contrato abarca valores, errores, efectos, cancelación y aislamiento.

**Límite:** El compilador verifica firmas, pero no toda la semántica. Una implementación puede conformar al protocolo y aun así violar LSP.

```swift
protocol AvatarDataLoading {
    func loadAvatar(for id: UUID) throws -> Data
}

struct CachedAvatarLoader: AvatarDataLoading {
    let cache: [UUID: Data]

    func loadAvatar(for id: UUID) throws -> Data {
        guard let data = cache[id], !data.isEmpty else {
            throw ProfileError.notFound
        }
        return data
    }
}
```

### I · Interface Segregation Principle

**Idea:** Cada consumidor debe depender únicamente de las capacidades que utiliza.

**Comportamiento:** La pantalla de detalle conoce lectura, pero no escritura, borrado o carga de avatar.

**Límite:** Protocolos de una sola operación no son siempre mejores. Conserva juntas las capacidades que cambian y se consumen juntas.

```swift
protocol ProfileReading: Sendable {
    func read(id: UUID) async throws -> Profile
}

protocol ProfileSaving: Sendable {
    func save(_ profile: Profile) async throws
}

let reader: any ProfileReading = repository
let profile = try await reader.read(id: profileID)
```

### D · Dependency Inversion Principle

**Idea:** Las reglas de alto nivel declaran sus necesidades y no construyen detalles como `URLSession`, `UserDefaults` o una base de datos.

**Comportamiento:** El composition root inyecta un repositorio live en producción y un stub en pruebas.

**Límite:** Dependency Injection es una técnica; Dependency Inversion describe la dirección. No requiere service locators ni frameworks globales.

```swift
@MainActor
final class ProfileViewModel {
    private let reader: any ProfileReading
    private(set) var state: State = .idle

    init(reader: any ProfileReading) {
        self.reader = reader
    }

    func load(id: UUID) async {
        state = .loading
        do {
            state = .loaded(try await reader.read(id: id))
        } catch {
            state = .failed
        }
    }
}
```

## Contratos y composición

### Contrato observable

**Idea:** Un protocolo útil documenta más que sus métodos: define resultados, errores, precondiciones, efectos, cancelación y aislamiento.

**Comportamiento:** La misma prueba de contrato se ejecuta contra cada loader y detecta implementaciones no sustituibles.

**Límite:** Los mocks que reproducen detalles internos hacen frágiles las pruebas. Verifica la conducta visible para el consumidor.

```swift
func verifyAvatarContract(
    makeLoader: () -> any AvatarDataLoading
) throws {
    let loader = makeLoader()
    #expect(try loader.loadAvatar(for: knownID).isEmpty == false)
    #expect(throws: ProfileError.notFound) {
        try loader.loadAvatar(for: missingID)
    }
}
```

### Composition root

**Idea:** Las implementaciones concretas se ensamblan en un límite de la app, no dentro de los casos de uso.

**Comportamiento:** Solo el composition root conoce el cliente HTTP, el repositorio live y su conexión con el ViewModel.

**Límite:** Un contenedor global que resuelve dependencias desde cualquier lugar vuelve a ocultarlas y dificulta razonar sobre su vida útil.

```swift
@MainActor
func makeProfileScreen() -> ProfileViewController {
    let httpClient = URLSessionHTTPClient()
    let repository = LiveProfileRepository(client: httpClient)
    let viewModel = ProfileViewModel(reader: repository)
    return ProfileViewController(viewModel: viewModel)
}
```

### SOLID y concurrencia

**Idea:** Aislamiento y `Sendable` también forman parte de los contratos modernos.

**Comportamiento:** Un actor protege cache mutable; `@MainActor` protege estado de presentación; las dependencias que cruzan actores son `Sendable`.

**Límite:** Un actor elimina accesos simultáneos de bajo nivel, pero su estado puede cambiar durante un `await`. Revalida invariantes después de la suspensión.

```swift
actor ProfileCache {
    private var values: [UUID: Profile] = [:]

    func profile(id: UUID) -> Profile? {
        values[id]
    }

    func save(_ profile: Profile) {
        values[profile.id] = profile
    }
}
```

## Límites de SOLID

### Concrete first

**Idea:** Comienza con una implementación concreta y extrae una abstracción cuando aparezca una frontera o variación real.

**Comportamiento:** Los tipos concretos conservan información y permiten al compilador optimizar y diagnosticar mejor.

**Límite:** Un protocolo con una implementación no es automáticamente incorrecto, pero debe justificar testabilidad, módulos, plataforma o inversión arquitectónica.

```swift
// Empieza simple.
func profileTitle(for profile: Profile) -> String {
    "Perfil de \(profile.name)"
}

// Extrae un contrato cuando aparezca una necesidad real,
// no solo para aumentar la cantidad de capas.
```

### Señales de sobrearquitectura

**Idea:** SOLID debe reducir el costo del cambio, no maximizar el número de tipos.

**Comportamiento:** Una buena abstracción muestra quién la consume, qué comportamiento promete y qué variación admite.

**Límite:** Factories sin propósito, tipos que solo reenvían llamadas, herencia para reutilizar código y protocolos hipotéticos son señales de revisión.

```swift
// Revisa una capa si no puede responder:
// - ¿qué razón de cambio aísla?
// - ¿qué contrato protege?
// - ¿qué consumidor la necesita?
// - ¿qué implementación permite sustituir?
// - ¿qué prueba demuestra su valor?
```
