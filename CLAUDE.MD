# Coding Standards — URLShortener iOS

When working on this project, follow these rules strictly.

---

## Developer Context

The developer has solid experience in **React Native, Expo, and TypeScript**.  
This is a learning project — explain Swift concepts with **direct React Native parallels** whenever possible.  
Assume they understand mobile architecture, async patterns, and component thinking — just not Swift syntax yet.

### Key parallels to use in explanations

| React Native / TypeScript | Swift / SwiftUI |
|---|---|
| `useState` | `@State` |
| `useEffect` | `.task { }` modifier |
| `useContext` / Context API | `@Environment` |
| `observer` (MobX) / Zustand store | `@Observable` class |
| `Props` interface | struct parameters (`let name: String`) |
| `children` prop | `@ViewBuilder` / trailing closure |
| `flexDirection: column` | `VStack` |
| `flexDirection: row` | `HStack` |
| `flex: 1` / `alignSelf: stretch` | `Spacer()` or `.frame(maxWidth: .infinity)` |
| `justifyContent: flex-end` | `Spacer()` before the element inside a VStack |
| `position: absolute` | `.overlay()` or `ZStack` |
| `StyleSheet` | Modifiers chained on the view |
| `async/await` | `async/await` (same concept) |
| `try/catch` | `do { try } catch { }` |
| `T \| null` (nullable) | `T?` (Optional) |
| `??` nullish coalescing | `??` (same) |
| `arr.filter(...)` | `arr.filter { }` |
| `axios interceptor` | `APIClient` — see `Core/Network/APIClient.swift` |
| AsyncStorage | UserDefaults (non-sensitive only) |
| SecureStore (Expo) | Keychain — see `Core/Auth/KeychainHelper.swift` |

---

## Architecture

**MVVM** — strict separation:

- **View** (`*View.swift`) — only layout and UI. No business logic. Reads from ViewModel.
- **ViewModel** (`*ViewModel.swift`) — `@MainActor @Observable` class. State + async actions. Calls services.
- **Service** (`*Service.swift`) — `enum` with `static func`. Only networking. Returns decoded models.
- **Model** (`*.swift` in Models/) — `Codable` structs. Mirror the API response exactly.

### ViewModel pattern

```swift
@MainActor
@Observable
class ExampleViewModel {
    var data: [Item] = []
    var isLoading = false
    var errorMessage: String?

    func load() async {
        isLoading = true
        defer { isLoading = false }   // runs on exit, like finally{}
        do {
            data = try await ExampleService.fetchItems()
        } catch {
            errorMessage = error.userMessage(fallback: "Something went wrong.")
        }
    }
}
```

- `@MainActor` — all UI updates on the main thread. Required for `@Observable` classes that drive UI.
- `defer` — equivalent to `finally {}` in JS. Guarantees cleanup even if an error is thrown.
- `error.userMessage(fallback:)` — shared helper that maps `APIError` to a friendly message (see Error Handling below).

---

## Component Structure

Each feature folder follows this layout:

```
FeatureName/
├── FeatureNameView.swift         # root view
├── FeatureNameViewModel.swift    # state + logic
└── Components/
    ├── FeatureNameHeroCard.swift  # complex sections
    └── FeatureNameStatCard.swift  # small reusable pieces
```

**Rule:** extract to `Components/` when a section has visual weight or could be reused.  
Simple buttons and single-line views stay as `private var` computed properties inside the parent view.

---

## Navigation

The app uses `NavigationStack` with push navigation (`navigationDestination`) — not sheets, except for bottom sheets with clear dismissal intent.

```swift
// push (most screens)
.navigationDestination(isPresented: $showDetail) {
    DetailView(item: item)
}

// sheet (create, QR preview)
.sheet(isPresented: $showCreate) {
    CreateView()
}
```

Back button: always use `GoBackHeader` (in `Core/Components/`) + `.navigationBarBackButtonHidden(true)`.  
Never use the default iOS back button — it breaks the design.

---

## Networking

All API calls go through `APIClient.shared.request(endpoint)`.  
Define endpoints in `Core/Network/Endpoint.swift` — add a case to the enum and answer 3 questions:

1. `path` — what is the URL path?
2. `method` — GET, POST, or DELETE?
3. `requiresAuth` — does it need the Bearer token?

Never call `URLSession` directly from a ViewModel or View.

`APIClient` is an `actor`. Its `URLSession` is injectable (`init(session:)`) so tests can
drive it with a `URLProtocol` stub — production code uses `APIClient.shared`.

---

## Configuration / Environment

The API base URL is **not hardcoded**. It comes from `.xcconfig` files (the `.env` of iOS):

- `Config/Debug.xcconfig` → localhost · `Config/Release.xcconfig` → overridable.
- `Config/Local.xcconfig` (gitignored) overrides the URL per-machine (e.g. an ngrok URL for TestFlight).
- The value flows `xcconfig → Info.plist ($(API_BASE_URL)) → Config.swift → APIClient`.

In code, always read the URL via `Config.baseURL`. Never hardcode URLs elsewhere.

---

## Error Handling

ViewModels convert thrown errors to a user-facing string with the shared helper, never
by re-casting `APIError` inline:

```swift
} catch {
    errorMessage = error.userMessage(fallback: "Failed to load links.")
}
```

`Error.userMessage(fallback:)` lives in `Core/Extensions/Error+UserMessage.swift`.

---

## Validation Messages

Form validation strings live in `Core/ValidationMessage.swift` — never inline string
literals. Reuse `ValidationMessage.passwordTooShort`, `.emailInvalid`, etc.

---

## Tokens and Auth

- `accessToken` and `refreshToken` live in the **Keychain** only — never UserDefaults.
- `AuthStore` holds `isAuthenticated` state. It is injected at the app root and read via `@Environment(AuthStore.self)`.
- `APIClient` handles `401` automatically: queues the failing request, refreshes the token, retries. ViewModels don't handle 401.

---

## Colors

All app colors are in `Core/Extensions/Color+App.swift`. Always use semantic names:

| Token | Usage |
|---|---|
| `appBackground` | pure black screen background |
| `appBackgroundApp` | main app screen background |
| `appSurfaceCard` | cards and list items |
| `appSurface` | pills, tags, secondary surfaces |
| `appPrimary` | indigo — primary actions, icons |
| `appTextSecondary` | secondary labels |
| `appDestructive` | delete, sign out — red |

Never use `Color(.systemBackground)` or hardcoded hex values outside this file.

---

## Testing

Tests use **Swift Testing** (`@Test` / `#expect`, not XCTest) and live in
`URLShortenerAppTests/`, mirroring the app's folder structure (`Features/Auth/Login/…`).

- Inject mocks via the service protocols (`AuthServicing`, `HomeServicing`). Mocks live in
  `URLShortenerAppTests/Support/` and reuse the preview sample data (`Link.samples`).
- ViewModels and logic get real assertions; SwiftUI views get render smoke tests via
  `ImageRenderer` (verify they don't crash, not pixel output).
- The `APIClient` is tested with a `URLProtocol` stub — no real network.
- Force-unwraps are acceptable **only in test code**, never in the app target.

---

## Quality Tooling

- **SwiftFormat** (`.swiftformat`) = formatting · **SwiftLint** (`.swiftlint.yml`) = lint rules.
- **Lefthook** (`lefthook.yml`): format + lint on commit, tests on push.
- Keep the tree lint-clean — CI runs `swiftlint --strict` and fails on any violation.
- Don't add comments to satisfy a linter; fix the code instead (see Comments).

---

## Comments

**Do not write comments in the code.** Write code that is self-explanatory through clear naming instead.

- No explanatory comments, no section banners, no "what each part does" notes inside source files.
- When something needs explaining, put the explanation in the **chat response**, not in the code.
- Exception: only keep a comment when it documents a non-obvious *why* that the code itself cannot express (e.g. a workaround for an API bug or a deliberate edge-case decision).

---

## Explaining Swift to This Developer

Explanations live in the chat response — never as comments in the code (see Comments above).

- Always frame new concepts relative to React Native equivalents first, then explain the Swift specifics.
- When showing code, explain **what each part does** in the chat — don't assume Swift knowledge.
- When a modifier chain is long, briefly note what each modifier adds.
- `private var` computed properties in SwiftUI are equivalent to sub-components defined inside a React component — they keep the `body` clean without needing a new file.
- `some View` in return types means "a specific view type that Swift figures out for you" — like TypeScript's `infer`.
- Optional chaining (`viewModel.user?.name`) works exactly like in TypeScript/JS.
