# Clean Code en Swift e iOS

Una guía para escribir código fácil de leer, probar y cambiar. Cada tema explica qué problema resuelve, cómo se comporta Swift y cuándo una práctica puede complicar el proyecto.

## Claridad del código

### 1. Nombres que explican el código

**En simple:** Un buen nombre permite entender una llamada sin abrir la función para investigar qué hace.

**Qué ocurre:** Swift usa `UpperCamelCase` para tipos y `lowerCamelCase` para funciones y variables. Las etiquetas, como `for` y `rate`, ayudan a leer la llamada como una frase.

**Cuidado:** Un nombre más largo no siempre es más claro. No repitas información que el tipo o el contexto ya muestran.

```swift
// Bad
func get(_ p: Double, _ d: Double) -> Double {
    p - (p * d)
}

// Good
func discountedPrice(
    for subtotal: Double,
    rate discountRate: Double
) -> Double {
    subtotal - (subtotal * discountRate)
}

let total = discountedPrice(for: 100, rate: 0.20)
```

### 2. Quién puede cambiar los datos

**En simple:** Debe ser fácil saber qué dato puede cambiar y qué parte del programa tiene permiso para cambiarlo.

**Qué ocurre:** `let` evita reasignar un valor, `var` permite modificarlo y `private(set)` deja que otros lo lean, pero solo el propio tipo puede escribirlo.

**Cuidado:** Usar `var` no es malo. El problema aparece cuando demasiados lugares pueden cambiar el mismo dato y ya no se sabe quién produjo el resultado.

```swift
struct ShoppingCart {
    private(set) var total = 0.0

    mutating func addItem(price: Double) {
        total += price
    }
}

var cart = ShoppingCart()
cart.addItem(price: 25)
print(cart.total)
```

### 3. Funciones con una tarea clara

**En simple:** Una función debería contar una acción clara y dejar los detalles en funciones con nombres fáciles de seguir.

**Qué ocurre:** Al separar validación y cálculo, cada parte se puede leer, reutilizar y probar por separado.

**Cuidado:** No existe un número máximo de líneas válido para todas las funciones. Divide cuando el nuevo nombre aclare una intención o separe algo que puede cambiar.

```swift
func checkoutTotal(for line: OrderLine) throws -> Double {
    try validate(line)
    let subtotal = subtotal(for: line)
    return totalApplyingVolumeDiscount(to: subtotal)
}

func subtotal(for line: OrderLine) -> Double {
    line.unitPrice * Double(line.quantity)
}
```

### 4. Evitar datos inválidos

**En simple:** Si un dato tiene reglas importantes, compruébalas una vez al crearlo para no repetir la misma validación en toda la app.

**Qué ocurre:** `DisplayName` solo se crea con texto válido. Desde ese momento, el resto del código puede confiar en que el nombre no está vacío.

**Cuidado:** No necesitas crear un tipo para cada `String`. Hazlo cuando el valor tenga reglas propias o pueda confundirse con otro dato.

```swift
enum DisplayNameError: Error {
    case empty
}

struct DisplayName: Equatable {
    let value: String

    init(_ value: String) throws {
        let normalized = value.trimmingCharacters(
            in: .whitespacesAndNewlines
        )
        guard !normalized.isEmpty else {
            throw DisplayNameError.empty
        }
        self.value = normalized
    }
}
```

## Flujo, ausencia y errores

### 5. Valores que pueden faltar

**En simple:** Un `Optional` indica de forma visible que un valor puede existir o puede faltar.

**Qué ocurre:** `??` entrega un valor alternativo; optional binding (`if let` o `guard let`) abre el valor solo si existe; `guard` permite salir temprano si falta.

**Cuidado:** Un valor alternativo no debe ocultar un error real. El force unwrap (`!`) cierra la app si el valor es `nil`, por eso exige una garantía verdadera.

```swift
func greeting(displayName: String?) -> String {
    "Hello, \(displayName ?? "Guest")"
}

func normalizedToken(_ token: String?) -> String? {
    guard let token, !token.isEmpty else { return nil }
    return token.trimmingCharacters(in: .whitespaces)
}
```

### 6. Errores que explican qué falló

**En simple:** Si quien llama necesita reaccionar de forma distinta según el problema, el error debe decir qué falló.

**Qué ocurre:** `throws` avisa que una función puede fallar y obliga a manejar o propagar ese fallo. Un `enum` separa causas como datos inválidos o nombre ausente.

**Cuidado:** No todo valor ausente es un error. Si “no encontrado” es un resultado normal, un `Optional` puede ser más claro que `throws`.

```swift
enum ProfileDecodingError: Error {
    case invalidPayload
    case missingName
}

private struct ProfilePayload: Decodable {
    let name: String
}

func decodeName(from data: Data) throws -> String {
    let payload: ProfilePayload
    do {
        payload = try JSONDecoder().decode(
            ProfilePayload.self,
            from: data
        )
    } catch {
        throw ProfileDecodingError.invalidPayload
    }
    guard !payload.name.isEmpty else {
        throw ProfileDecodingError.missingName
    }
    return payload.name
}
```

### 7. Comentarios que aportan contexto

**En simple:** El código debería mostrar qué hace; el comentario debería explicar por qué se tomó una decisión o qué regla debe respetarse.

**Qué ocurre:** Los comentarios `///` aparecen en Quick Help y DocC. Allí puedes explicar parámetros, resultado, errores y reglas importantes para quien use la función.

**Cuidado:** No describas línea por línea lo que el código ya dice. Ese comentario agrega ruido y puede quedar desactualizado.

```swift
/// Calculates the checkout service fee.
///
/// The store absorbs the fee from 50 onward to honor
/// the business rule agreed with support.
///
/// - Parameter subtotal: Value before shipping and taxes.
/// - Returns: Zero when the store absorbs the fee.
func serviceFee(for subtotal: Double) -> Double {
    subtotal >= 50 ? 0 : 2.5
}
```

## Dependencias y arquitectura iOS

### 8. Separar cálculos de acciones externas

**En simple:** Separa los cálculos de acciones como guardar, pedir datos por red o enviar analytics.

**Qué ocurre:** Una función pura devuelve el mismo resultado con los mismos datos. Las acciones externas quedan visibles en propiedades como `analytics`, llamadas dependencias.

**Cuidado:** No crees protocolos para operaciones simples que nunca cambiarán. Una capa extra solo ayuda cuando existe una necesidad real de reemplazar o probar esa acción.

```swift
func profileTitle(for profile: UserProfile) -> String {
    profile.name.isEmpty ? "Profile" : "Profile for \(profile.name)"
}

enum AnalyticsEvent: String {
    case profileOpened = "profile_opened"
}

struct ProfileOpeningHandler {
    let analytics: any AnalyticsTracking

    func execute(profile: UserProfile) -> String {
        analytics.track(event: .profileOpened)
        return profileTitle(for: profile)
    }
}
```

### 9. Recibir dependencias desde fuera

**En simple:** Un tipo debería recibir las herramientas que necesita en vez de crearlas y ocultarlas dentro.

**Qué ocurre:** La inyección de dependencias pasa el repositorio por el `init`. Así, el mismo ViewModel puede usar datos reales, en memoria o preparados para una prueba.

**Cuidado:** Inyectar dependencias no obliga a crear un protocolo para cada tipo. Usa una abstracción cuando realmente necesites más de una implementación o una frontera de prueba.

```swift
protocol ProfileFetching: Sendable {
    func fetchProfile(id: UUID) async throws -> UserProfile
}

@MainActor
final class ProfileViewModel {
    private let repository: any ProfileFetching

    init(repository: any ProfileFetching) {
        self.repository = repository
    }

    func profile(id: UUID) async throws -> UserProfile {
        try await repository.fetchProfile(id: id)
    }
}
```

### 10. Tareas asíncronas y estado de pantalla

**En simple:** Cuando varias tareas pueden ejecutarse a la vez, el código debe dejar claro dónde se puede leer y cambiar cada estado.

**Qué ocurre:** `@MainActor` protege el estado usado por la interfaz; `await` señala que la función puede pausarse; `CancellationError` indica que la tarea fue cancelada, no que el usuario cometió un error.

**Cuidado:** No hagas cálculos pesados en `MainActor` porque pueden congelar la interfaz. Después de un `await`, comprueba de nuevo los datos que podrían haber cambiado mientras la tarea estaba pausada.

```swift
@MainActor
final class ProfileViewModel {
    private let repository: any ProfileFetching
    private(set) var state: State = .idle

    func load(id: UUID) async {
        state = .loading
        do {
            state = .loaded(
                try await repository.fetchProfile(id: id)
            )
        } catch is CancellationError {
            state = .idle
        } catch {
            state = .failed
        }
    }
}
```

### 11. Evitar ciclos de memoria

**En simple:** Si una clase guarda una closure que también conserva a esa clase, ninguna de las dos puede liberarse.

**Qué ocurre:** ARC administra la memoria de las clases. Una captura `weak` no mantiene viva la instancia y pasa a `nil` cuando esa instancia se libera.

**Cuidado:** No agregues `[weak self]` a todas las closures por costumbre. Usa `unowned` solo si puedes garantizar que la referencia seguirá viva; si no, la app puede cerrarse.

```swift
final class SearchController {
    var onRefresh: (() -> Void)?
    private(set) var refreshCount = 0

    func configureRefresh() {
        onRefresh = { [weak self] in
            self?.refreshCount += 1
        }
    }
}
```

## Verificación y evolución

### 12. Pruebas que verifican resultados

**En simple:** Una prueba debería comprobar lo que recibe quien usa el código, no cómo está construido por dentro.

**Qué ocurre:** Un spy registra acciones que interesa observar. Swift Testing usa `@Test` y `#expect` dentro de un target de pruebas.

**Cuidado:** `assert` ayuda a demostrar una idea en un playground, pero no reemplaza pruebas ejecutadas por Xcode y por la integración continua (CI).

```swift
@Test
func openingProfileTracksEvent() {
    let analytics = AnalyticsSpy()
    let handler = ProfileOpeningHandler(analytics: analytics)

    let title = handler.execute(profile: sampleProfile)

    #expect(title == "Profile for Rodolfo")
    #expect(analytics.receivedEvents == [.profileOpened])
}
```

### 13. Reutilizar sin forzar

**En simple:** DRY busca no repetir una misma regla, pero dos fragmentos parecidos no siempre representan la misma idea.

**Qué ocurre:** Mantener separadas las fórmulas del rectángulo y el triángulo permite que cada una cambie por su propia razón.

**Cuidado:** A veces repetir dos líneas es más claro que crear una solución compartida que después necesita excepciones para funcionar.

```swift
// Dos dominios diferentes: no se fuerza una dependencia.
func rectangleArea(width: Double, height: Double) -> Double {
    width * height
}

func triangleArea(base: Double, height: Double) -> Double {
    base * height / 2
}
```

### 14. Ordenar sin cambiar resultados

**En simple:** Refactorizar significa mejorar la organización del código manteniendo el mismo resultado para quien lo usa.

**Qué ocurre:** Las pruebas confirman que entradas importantes producen el mismo resultado antes y después de ordenar el código.

**Cuidado:** Agregar una regla, validación o resultado nuevo no es solo refactorizar: también cambia el comportamiento y necesita pruebas nuevas.

```swift
enum ShippingPolicy {
    static let freeThreshold = 50.0
    static let standardCost = 4.99
}

func shippingCost(subtotal: Double) -> Double {
    guard subtotal < ShippingPolicy.freeThreshold else {
        return 0
    }
    return ShippingPolicy.standardCost
}
```

## Aplicarlo con criterio

### 15. Lista de revisión

**En simple:** Clean Code busca que un cambio sea fácil y seguro, no que el proyecto tenga la mayor cantidad de capas.

**Qué ocurre:** Antes de crear una abstracción, identifica qué dato cambia, qué resultado prometes, qué alternativa existe y qué acción externa necesitas controlar.

**Cuidado:** Tener funciones cortas, muchos protocolos o alta cobertura no garantiza claridad. Lo importante es que el comportamiento sea comprensible y comprobable.

```swift
// Questions to ask before creating an abstraction:
// 1. What real variation does it address?
// 2. Which consumer needs this contract?
// 3. Which error, state, or effect does it make explicit?
// 4. Can it be tested through behavior?
// 5. Is it simpler than using the concrete type?
```
