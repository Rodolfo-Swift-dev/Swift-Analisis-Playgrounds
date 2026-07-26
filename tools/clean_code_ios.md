# Clean Code en Swift e iOS

Una guía práctica para escribir código cuya intención, estado, errores y dependencias sean fáciles de entender y modificar. Los ejemplos se enfocan en límites reales de una app iOS y no en reglas arbitrarias de estilo.

## Claridad del código

### 1. Nombres y diseño de APIs

**Idea:** La llamada debe explicar la operación sin obligar a abrir su implementación.

**Comportamiento:** Los tipos usan `UpperCamelCase`; funciones, variables y etiquetas usan `lowerCamelCase`. Las etiquetas externas forman parte de la lectura de la API.

**Límite:** Un nombre largo solo es mejor cuando agrega información. Evita repetir datos que el contexto o los tipos ya expresan.

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

### 2. let, var y alcance del estado

**Idea:** El estado mutable debe tener un propietario claro y la menor visibilidad necesaria.

**Comportamiento:** `let` impide reasignación; `var` permite mutación; `private(set)` expone lectura pública y restringe la escritura al tipo.

**Límite:** La mutabilidad no es incorrecta. El riesgo aparece cuando es global, compartida o modificable desde demasiados lugares.

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

### 3. Funciones y niveles de abstracción

**Idea:** Una función de alto nivel debe contar el caso de uso y delegar sus detalles.

**Comportamiento:** Separar validación y cálculo permite reutilizarlos y probarlos sin mezclar presentación.

**Límite:** No existe un máximo universal de líneas. Extrae una función cuando nombre una intención, aísle un cambio o elimine duplicación real.

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

### 4. Estados inválidos y tipos del dominio

**Idea:** Si un valor posee reglas importantes, valídalo al construir un tipo que represente esas reglas.

**Comportamiento:** Después de crear `DisplayName`, los consumidores pueden confiar en su invariante básica.

**Límite:** No conviertas cada `String` en un tipo nuevo. Es útil cuando existen reglas propias o confundir valores puede provocar errores.

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

### 5. Optional, optional binding y guard

**Idea:** La ausencia debe formar parte explícita del tipo y resolverse según el significado del dominio.

**Comportamiento:** `??` entrega un fallback; optional binding extrae un valor existente; `guard` abandona temprano cuando una precondición no se cumple.

**Límite:** No uses un fallback para ocultar un error. `force unwrap` termina el proceso si la suposición resulta falsa.

```swift
func greeting(displayName: String?) -> String {
    "Hola, \(displayName ?? "Invitado")"
}

func normalizedToken(_ token: String?) -> String? {
    guard let token, !token.isEmpty else { return nil }
    return token.trimmingCharacters(in: .whitespaces)
}
```

### 6. throws y errores con significado

**Idea:** Conserva la razón del fallo cuando el consumidor necesita decidir cómo reaccionar.

**Comportamiento:** `throws` obliga a propagar o manejar el error; un enum permite distinguir causas concretas.

**Límite:** No encontrar un elemento puede ser normal. En ese caso, un `Optional` puede comunicar mejor el resultado que un error.

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

### 7. Comentarios, Quick Help y DocC

**Idea:** El código explica qué ocurre; la documentación explica decisiones, contratos y restricciones.

**Comportamiento:** `///` aparece en Quick Help y puede procesarse con DocC. Parámetros, retorno y errores forman parte del contrato publicado.

**Límite:** Un comentario que repite la sintaxis agrega ruido y puede quedar desactualizado.

```swift
/// Calcula el cargo de servicio del checkout.
///
/// La tienda absorbe el cargo desde 50 para respetar
/// la regla comercial acordada con soporte.
///
/// - Parameter subtotal: Valor previo a envío e impuestos.
/// - Returns: Cero cuando la tienda absorbe el cargo.
func serviceFee(for subtotal: Double) -> Double {
    subtotal >= 50 ? 0 : 2.5
}
```

## Dependencias y arquitectura iOS

### 8. Lógica pura y efectos secundarios

**Idea:** Mantén las transformaciones separadas de red, disco, analytics y otros efectos externos.

**Comportamiento:** Una función pura produce la misma salida para las mismas entradas. Los efectos se hacen visibles mediante dependencias.

**Límite:** No envuelvas operaciones triviales de la biblioteca estándar en protocolos sin una variación real.

```swift
func profileTitle(for profile: UserProfile) -> String {
    profile.name.isEmpty ? "Perfil" : "Perfil de \(profile.name)"
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

### 9. Inyección de dependencias

**Idea:** Las dependencias obligatorias deben llegar explícitamente, normalmente por el inicializador.

**Comportamiento:** El caso de uso puede recibir un repositorio real, en memoria o simulado sin modificar su implementación.

**Límite:** Inyección de dependencias no implica crear un protocolo para cada estructura concreta e inmutable.

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

### 10. async/await, MainActor y cancelación

**Idea:** El aislamiento forma parte de la corrección y debe ser visible en el diseño.

**Comportamiento:** `@MainActor` serializa el acceso al estado de presentación; `await` marca suspensión; `CancellationError` representa cancelación, no una falla de usuario.

**Límite:** No ejecutes decodificación o trabajo pesado en `MainActor`. Los actores evitan data races de bajo nivel, pero todavía debes proteger invariantes alrededor de cada `await`.

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

### 11. ARC, weak y unowned

**Idea:** Revisa quién conserva a quién cuando una clase almacena una closure.

**Comportamiento:** Una captura `weak` no conserva la instancia y se convierte en `nil` cuando esta se libera.

**Límite:** No agregues `[weak self]` mecánicamente. `unowned` solamente es válido cuando la vida útil de la referencia está garantizada.

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

### 12. Pruebas de comportamiento

**Idea:** Prueba resultados observables, no detalles privados de implementación.

**Comportamiento:** Un spy registra interacciones; Swift Testing usa `@Test` y `#expect` dentro de un test target.

**Límite:** `assert` es útil para un playground, pero no reemplaza un test target ni su integración con Xcode y CI.

```swift
@Test
func openingProfileTracksEvent() {
    let analytics = AnalyticsSpy()
    let handler = ProfileOpeningHandler(analytics: analytics)

    let title = handler.execute(profile: sampleProfile)

    #expect(title == "Perfil de Rodolfo")
    #expect(analytics.receivedEvents == [.profileOpened])
}
```

### 13. DRY y abstracciones prematuras

**Idea:** DRY evita duplicar conocimiento y reglas, no cada fragmento visualmente parecido.

**Comportamiento:** Mantener explícita una fórmula independiente evita acoplarla accidentalmente a otra regla.

**Límite:** Una pequeña repetición puede ser menos costosa que una abstracción falsa que luego cambia por dos razones.

```swift
// Dos dominios diferentes: no se fuerza una dependencia.
func rectangleArea(width: Double, height: Double) -> Double {
    width * height
}

func triangleArea(base: Double, height: Double) -> Double {
    base * height / 2
}
```

### 14. Refactorización segura

**Idea:** Refactorizar cambia la estructura interna sin cambiar el comportamiento observable.

**Comportamiento:** Las pruebas comparan entradas representativas antes y después de nombrar constantes y simplificar el flujo.

**Límite:** Agregar una nueva tasa, validación o resultado es un cambio funcional, aunque el código también quede más ordenado.

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

## Límites de Clean Code

### 15. Checklist contextual

**Idea:** El objetivo es hacer explícito el comportamiento requerido con la menor estructura suficiente.

**Comportamiento:** Antes de agregar capas, identifica el estado, el contrato, la variación y el efecto secundario que necesitan protección.

**Límite:** Métricas como cantidad de líneas, número de protocolos o cobertura aislada no demuestran por sí solas que el diseño sea claro.

```swift
// Preguntas antes de crear una abstracción:
// 1. ¿Qué variación real resuelve?
// 2. ¿Qué consumidor necesita este contrato?
// 3. ¿Qué error, estado o efecto hace explícito?
// 4. ¿Puede probarse por comportamiento?
// 5. ¿Es más simple que usar el tipo concreto?
```
