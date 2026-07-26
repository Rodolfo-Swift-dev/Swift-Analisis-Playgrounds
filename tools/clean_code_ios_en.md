# Clean Code in Swift and iOS

A guide to writing code that's easy to read, test, and change. Each topic explains what problem it solves, how Swift behaves, and when a practice can complicate the project.

## Code clarity

### 1. Names that explain the code

**In simple terms:** A good name allows you to understand a call without opening the function to investigate what it does.

**What happens:** Swift uses `UpperCamelCase` for types and `lowerCamelCase` for functions and variables. The labels, such as `for` and `rate`, help read the call as a sentence.

**Watch out:** A longer name is not always clearer. Don't repeat information that the type or context already shows.

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

### 2. Who can change the data

**In simple terms:** It should be easy to know what data you can change and what part of the program has permission to change it.

**What happens:** `let` prevents reassignment, `var` permits changes, and `private(set)` allows other code to read the property while only the declaring type can write it.

**Watch out:** Using `var` is not inherently bad. The problem begins when too many places can change the same data and its origin becomes unclear.

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

### 3. Functions with a clear task

**In simple terms:** A function should tell a clear action and leave the details in functions with easy-to-follow names.

**What happens:** By separating validation and calculation, each part can be read, reused, and tested separately.

**Watch out:** There is no maximum number of lines valid for all functions. Divide when the new name clarifies an intention or separates something that can change.

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

### 4. Avoid invalid data

**In simple terms:** If a piece of data has important rules, check them once when creating it to avoid repeating the same validation throughout the app.

**What happens:** `DisplayName` can only be created with valid text. From then on, the rest of the code can trust that the name is not empty.

**Watch out:** You don't need to create a type for each `String`. Do it when the value has its own rules or can be confused with other data.

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

## Flow, absence and errors

### 5. Values that may be missing

**In simple terms:** An `Optional` clearly indicates that a value may be present or absent.

**What happens:** `??` supplies a fallback; optional binding (`if let` or `guard let`) unwraps a value only when it exists; `guard` exits early when it does not.

**Watch out:** A fallback should not hide a real error. Force unwrap (`!`) traps if the value is `nil`, so it requires a genuine, verifiable guarantee.

```swift
func greeting(displayName: String?) -> String {
    "Hola, \(displayName ?? "Invitado")"
}

func normalizedToken(_ token: String?) -> String? {
    guard let token, !token.isEmpty else { return nil }
    return token.trimmingCharacters(in: .whitespaces)
}
```

### 6. Errors that explain what went wrong

**In simple terms:** If the caller needs to react differently depending on the problem, the error should say what went wrong.

**What happens:** `throws` states that a function may fail and requires that failure to be handled or propagated. An `enum` separates causes such as invalid data or a missing name.

**Watch out:** Not every missing value is an error. If “not found” is a normal result, an `Optional` may be clearer than `throws`.

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

### 7. Comments that provide context

**In simple terms:** Code should show what it does; a comment should explain why a decision was made or which rule must be followed.

**What happens:** `///` documentation comments appear in Quick Help and DocC. They can explain parameters, results, errors, and important rules for callers.

**Watch out:** Don't describe line by line what the code already says. That comment adds noise and may become outdated.

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

## iOS dependencies and architecture

### 8. Separate calculations from external actions

**In simple terms:** Separate calculations from actions such as saving, requesting data over the network or sending analytics.

**What happens:** A pure function returns the same result with the same data. External actions are visible in properties such as `analytics`, called dependencies.

**Watch out:** Don't create protocols for simple operations that will never change. An extra layer only helps when there is a real need to replace or test that action.

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

### 9. Receive dependencies from outside

**In simple terms:** A type should receive the tools it needs instead of creating and hiding them internally.

**What happens:** Dependency injection passes the repository through `init`. The same ViewModel can then use a production repository, an in-memory implementation, or a test double.

**Watch out:** Injecting dependencies does not require a protocol for every type. Add an abstraction when you need interchangeable implementations or a meaningful testing boundary.

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

### 10. Asynchronous tasks and screen state

**In simple terms:** When multiple tasks can run at once, the code should make it clear where each state can be read and changed.

**What happens:** `@MainActor` protects the state used by the interface; `await` notes that the function can be paused; `CancellationError` indicates that the task was canceled, not that the user made an error.

**Watch out:** Do not perform heavy calculations on `MainActor`, because they can freeze the interface. After an `await`, check again for data that may have changed while the task was suspended.

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

### 11. Avoid memory cycles

**In simple terms:** If a class holds a closure that also holds that class, neither class can be freed.

**What happens:** ARC manages class-instance memory. A `weak` capture does not keep the instance alive and becomes `nil` when that instance is released.

**Watch out:** Do not add `[weak self]` to every closure by habit. Use `unowned` only when the reference is guaranteed to remain alive; otherwise, accessing it traps.

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

## Verification and evolution

### 12. Tests that verify results

**In simple terms:** A test should test what the user of the code receives, not how it is built inside.

**What happens:** A spy records actions that are interesting to observe. Swift Testing uses `@Test` and `#expect` within a test target.

**Watch out:** `assert` helps demonstrate an idea in a playground, but it does not replace tests run by Xcode and continuous integration (CI).

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

### 13. Reuse without forcing

**In simple terms:** DRY seeks not to repeat the same rule, but two similar fragments do not always represent the same idea.

**What happens:** Keeping the rectangle and triangle formulas separate allows each to change for its own reason.

**Watch out:** Sometimes repeating two lines is clearer than creating a shared solution that then needs exceptions to work.

```swift
// Dos dominios diferentes: no se fuerza una dependencia.
func rectangleArea(width: Double, height: Double) -> Double {
    width * height
}

func triangleArea(base: Double, height: Double) -> Double {
    base * height / 2
}
```

### 14. Sort without changing results

**In simple terms:** Refactoring means improving the organization of the code while maintaining the same result for whoever uses it.

**What happens:** Tests confirm that important inputs produce the same result before and after reorganizing the code.

**Watch out:** Adding a new rule, validation, or result isn't just refactoring: it also changes behavior and requires new testing.

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

## Apply it judiciously

### 15. Checklist

**In simple terms:** Clean Code seeks to make a change easy and safe, not for the project to have the greatest number of layers.

**What happens:** Before creating an abstraction, identify what data changes, what outcome you promise, what alternative exists, and what external action you need to control.

**Watch out:** Having short functions, many protocols or high coverage does not guarantee clarity. The important thing is that the behavior is understandable and verifiable.

```swift
// Preguntas antes de crear una abstracción:
// 1. ¿Qué variación real resuelve?
// 2. ¿Qué consumidor necesita este contrato?
// 3. ¿Qué error, estado o efecto hace explícito?
// 4. ¿Puede probarse por comportamiento?
// 5. ¿Es más simple que usar el tipo concreto?
```
