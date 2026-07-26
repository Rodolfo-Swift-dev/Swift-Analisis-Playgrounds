# SOLID en Swift e iOS

SOLID reúne cinco ideas para que un cambio afecte la menor cantidad posible de código. Esta guía las aplica a una pantalla de perfiles y muestra cuándo ayudan y cuándo solo agregan complejidad.

## Principios SOLID

### S · Una responsabilidad clara (SRP)

**En simple:** Una pieza de código debería encargarse de una tarea que pueda explicarse con claridad.

**Qué ocurre:** Descargar, convertir, guardar y mostrar un perfil son tareas distintas. `ProfileImporter` las coordina, pero cada detalle puede cambiar sin reescribir los demás.

**Cuidado:** SRP no significa crear un tipo por cada línea o método. Si todo cambia por la misma razón y se entiende junto, puede permanecer junto.

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

### O · Agregar opciones sin romper lo existente (OCP)

**En simple:** Si sabes que aparecerán nuevas opciones, intenta poder agregarlas sin reescribir el código que ya funciona.

**Qué ocurre:** `ProfileAnalytics` trabaja con cualquier objeto que cumpla `AnalyticsTracking`. Se puede agregar otro proveedor sin modificar el flujo que envía el evento.

**Cuidado:** “Cerrado al cambio” no significa código intocable. Corrige errores y requisitos; crea extensiones solo para alternativas que realmente existen o están previstas.

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

### L · Cumplir la misma promesa (LSP)

**En simple:** Si dos tipos prometen hacer lo mismo, quien los usa debería poder intercambiarlos y recibir un resultado equivalente.

**Qué ocurre:** Cada cargador de avatar debe devolver datos válidos cuando encuentra la imagen y lanzar `notFound` cuando no existe. La promesa incluye resultados y errores, no solo el nombre de la función.

**Cuidado:** Swift comprueba que la función tenga la firma correcta, pero no que respete su significado. Un tipo puede cumplir el protocolo y aun así devolver resultados inesperados.

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

### I · Pedir solo lo necesario (ISP)

**En simple:** Cada pantalla o función debería conocer solo las operaciones que realmente necesita.

**Qué ocurre:** La pantalla de detalle recibe `ProfileReading` porque solo lee perfiles. No queda conectada por accidente a guardar, borrar o cargar avatares.

**Cuidado:** No todo método necesita su propio protocolo. Mantén juntas las operaciones que normalmente se usan y cambian juntas.

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

### D · Recibir herramientas desde fuera (DIP)

**En simple:** La lógica principal debería recibir las herramientas que necesita en vez de decidir y construir una herramienta concreta dentro.

**Qué ocurre:** `ProfileViewModel` pide algo capaz de leer perfiles. Desde fuera se le entrega el repositorio real en la app o uno controlado en las pruebas.

**Cuidado:** Inyección de dependencias es la forma de entregar esas herramientas; DIP es la idea de que la lógica no dependa del detalle concreto. No necesitas un framework ni un contenedor global.

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

## Cómo conectar las piezas

### La promesa de un protocolo

**En simple:** Un protocolo no solo enumera funciones; también debe dejar claro qué puede esperar quien las llama.

**Qué ocurre:** La misma prueba se ejecuta con cada cargador y confirma que todos devuelven datos válidos y comunican la ausencia con el mismo error.

**Cuidado:** No pruebes cada paso interno con mocks. Comprueba el resultado visible para evitar que una reorganización rompa pruebas aunque la función siga funcionando.

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

### Dónde se conectan las piezas

**En simple:** Conviene elegir y conectar los objetos reales en un único lugar cercano al inicio de la app.

**Qué ocurre:** Ese lugar se conoce como composition root. Allí se crean el cliente de red, el repositorio y el ViewModel antes de construir la pantalla.

**Cuidado:** Un contenedor global accesible desde cualquier archivo vuelve a ocultar las dependencias y dificulta saber cuándo se crean y se liberan.

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

**En simple:** En código asíncrono también debes aclarar quién puede cambiar un dato y desde dónde.

**Qué ocurre:** Un `actor` protege la caché compartida, `@MainActor` protege el estado de la interfaz y `Sendable` marca valores seguros para pasar entre zonas aisladas.

**Cuidado:** Un actor evita cambios simultáneos directos, pero sus datos pueden cambiar mientras una función está pausada en `await`. Comprueba de nuevo lo que siga siendo importante al continuar.

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

## Aplicarlo con criterio

### Comenzar simple

**En simple:** Empieza con el tipo más sencillo que resuelva el problema y agrega una abstracción cuando aparezca una necesidad concreta.

**Qué ocurre:** Un tipo concreto muestra directamente qué se está usando. Un protocolo cobra valor cuando necesitas intercambiar implementaciones, separar módulos o controlar una prueba.

**Cuidado:** Un protocolo con una sola implementación no es siempre incorrecto, pero debería resolver una frontera real y no existir solo “por si acaso”.

```swift
// Empieza simple.
func profileTitle(for profile: Profile) -> String {
    "Perfil de \(profile.name)"
}

// Extrae un contrato cuando aparezca una necesidad real,
// no solo para aumentar la cantidad de capas.
```

### Señales de demasiada arquitectura

**En simple:** SOLID debería facilitar los cambios, no convertir una acción sencilla en una cadena difícil de seguir.

**Qué ocurre:** Una abstracción útil tiene un consumidor claro, promete un resultado entendible y permite reemplazar algo que de verdad puede variar.

**Cuidado:** Revisa factories sin una decisión real, tipos que solo reenvían llamadas, herencia usada solo para compartir código y protocolos creados para casos imaginarios.

```swift
// Revisa una capa si no puede responder:
// - ¿qué razón de cambio aísla?
// - ¿qué contrato protege?
// - ¿qué consumidor la necesita?
// - ¿qué implementación permite sustituir?
// - ¿qué prueba demuestra su valor?
```
