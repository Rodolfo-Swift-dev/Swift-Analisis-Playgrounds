# SOLID in Swift and iOS

SOLID brings together five ideas so that a change affects the least amount of code possible. This guide applies them to a profiles screen and shows when they help and when they just add complexity.

## SOLID principles

### S · A clear responsibility (SRP)

**In simple terms:** A piece of code should take care of a task that can be clearly explained.

**What happens:** Downloading, converting, saving and displaying a profile are different tasks. `ProfileImporter` coordinates them, but each detail can change without rewriting the others.

**Watch out:** SRP does not mean creating a type for each line or method. If everything changes for the same reason and is understood together, it can stay together.

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
    "Profile for \(profile.name)"
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

### OR · Add options without breaking what exists (OCP)

**In simple terms:** If you know new options will appear, try to be able to add them without rewriting code that already works.

**What happens:** `ProfileAnalytics` works with any object that meets `AnalyticsTracking`. Another provider can be added without modifying the flow that sends the event.

**Watch out:** “Closed for modification” does not mean untouchable code. Fix bugs and requirements; add extension points only for alternatives that exist or are planned.

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

### L · Keep the same promise (LSP)

**In simple terms:** If two types promise to do the same thing, the user should be able to swap them and receive an equivalent result.

**What happens:** Each avatar loader must return valid data when it finds the image and throw `notFound` when it does not. The contract includes results and errors, not just the function name.

**Watch out:** Swift checks that the function has the correct signature, but not that it respects its meaning. A type can comply with the protocol and still return unexpected results.

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

### I · Order only what is necessary (ISP)

**In simple terms:** Each screen or function should know only the operations it really needs.

**What happens:** The detail screen receives `ProfileReading` because it only reads profiles. It is not accidentally coupled to saving, deleting, or loading avatars.

**Watch out:** Not every method needs its own protocol. Keep operations that are normally used and changed together.

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

### D · Receive tools from outside (DIP)

**In simple terms:** The main logic should receive the tools it needs instead of deciding and building a specific tool inside.

**What happens:** `ProfileViewModel` asks for something capable of reading profiles. The app supplies the real repository, while tests can supply a controlled implementation.

**Watch out:** Dependency injection is the way to deliver those tools; DIP is the idea that logic does not depend on the specific detail. You don't need a framework or a global container.

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

## How to connect the parts

### The promise of a protocol

**In simple terms:** A protocol does more than list functions; it should also make the caller's expectations clear.

**What happens:** The same test is run with each loader and confirms that they all return valid data and report the absence with the same error.

**Watch out:** Do not test every internal step with mocks. Check observable results so refactoring does not break tests while behavior remains correct.

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

### Where the pieces connect

**In simple terms:** It is best to choose and connect the real objects in a single place near the start of the app.

**What happens:** That place is the composition root. It creates the network client, repository, and ViewModel before building the screen.

**Watch out:** A global container accessible from any file again hides dependencies and makes it difficult to know when they are created and released.

```swift
@MainActor
func makeProfileScreen() -> ProfileViewController {
    let httpClient = URLSessionHTTPClient()
    let repository = LiveProfileRepository(client: httpClient)
    let viewModel = ProfileViewModel(reader: repository)
    return ProfileViewController(viewModel: viewModel)
}
```

### SOLID and concurrency

**In simple terms:** In asynchronous code you must also clarify who can change data and from where.

**What happens:** An `actor` protects shared cache state, `@MainActor` protects interface state, and `Sendable` marks values that are safe to pass between isolation domains.

**Watch out:** An actor avoids direct simultaneous changes, but its data can change while a function is paused in `await`. Double-check what is still important as you continue.

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

## Apply it judiciously

### Start simple

**In simple terms:** Start with the simplest type that solves the problem and add an abstraction when a specific need arises.

**What happens:** A concrete type directly shows what is being used. A protocol comes into its own when you need to swap implementations, separate modules, or control a test.

**Watch out:** A protocol with one implementation is not always wrong, but it should represent a real boundary rather than exist “just in case.”

```swift
// Start simple.
func profileTitle(for profile: Profile) -> String {
    "Profile for \(profile.name)"
}

// Extract a contract when a real need appears,
// not just to increase the number of layers.
```

### Signs of too much architecture

**In simple terms:** SOLID should make changes easier, not turn a simple action into a difficult-to-follow chain.

**What happens:** A useful abstraction has a clear consumer, promises an understandable result, and allows us to replace something that can really vary.

**Watch out:** Review factories with no real decision, types that only forward calls, inheritance used only to share code, and protocols created for imaginary cases.

```swift
// Review a layer if it cannot answer:
// - Which reason for change does it isolate?
// - Which contract does it protect?
// - Which consumer needs it?
// - Which implementation can it replace?
// - Which test demonstrates its value?
```
