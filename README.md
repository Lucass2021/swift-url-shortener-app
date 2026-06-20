# URLShortener iOS

Native iOS client for the [URL Shortener API](https://github.com/Lucass2021/nest-api-url-shortener-context).  
Built with SwiftUI as a study project to learn native iOS development coming from React Native.

---

## Stack

- **Language:** Swift 5.9+
- **UI:** SwiftUI (no UIKit)
- **Architecture:** MVVM with `@Observable`
- **Networking:** URLSession + Codable (no external libraries)
- **Storage:** Keychain (tokens), no UserDefaults for sensitive data
- **QR Code:** CoreImage (no external libraries)
- **Tests:** Swift Testing
- **Tooling:** SwiftFormat, SwiftLint, Lefthook (git hooks), GitHub Actions

---

## Features

- Register and login with JWT authentication
- Automatic access token refresh with single-flight de-duplication and retry
- List, create, and delete short links
- Pull to refresh and swipe to delete on links list
- Link detail with stats, copy button, and QR code generation
- Passcode protection for links
- Profile screen with name, email, and sign out

---

## Configuration (API URL)

The API base URL is **not hardcoded** in Swift. It is injected at build time from
`.xcconfig` files (the iOS equivalent of a `.env`), read into `Info.plist`, and exposed
in code as `Config.baseURL`.

```
Config/*.xcconfig  →  Info.plist ($(API_BASE_URL))  →  Config.swift  →  APIClient
```

| File | Used by | Value |
|---|---|---|
| `Config/Debug.xcconfig` | Debug builds (simulator) | `http://localhost:3000` |
| `Config/Release.xcconfig` | Release builds (TestFlight / App Store) | default localhost, overridable |
| `Config/Local.xcconfig` | per-machine override (gitignored) | your own URL |

### Local development

Nothing to set up — Debug builds already point at `http://localhost:3000`.

### TestFlight with a tunnel (e.g. ngrok)

Release builds run on a real device, so `localhost` won't reach your machine. Point the
app at a public HTTPS tunnel:

1. Copy the template: `cp Config/Local.xcconfig.example Config/Local.xcconfig`
2. Set your URL (the `$()` keeps `//` from being read as an xcconfig comment):
   ```
   API_BASE_URL = https:/$()/your-id.ngrok-free.app
   ```
3. Archive for TestFlight.

`Config/Local.xcconfig` is gitignored — it is your personal `.env` and never committed.
Use an **HTTPS** URL so iOS App Transport Security doesn't block the request.

---

## Project Structure

```
URLShortenerApp/
├── App/
│   └── URLShortenerAppApp.swift       # @main entry point, environment injection
├── Core/
│   ├── Config.swift                   # reads API_BASE_URL from Info.plist
│   ├── ValidationMessage.swift        # centralized form validation strings
│   ├── Auth/
│   │   ├── AuthStore.swift            # authentication state (@Observable)
│   │   ├── AuthService.swift          # login, register, refresh calls
│   │   └── KeychainHelper.swift       # secure token storage
│   ├── Network/
│   │   ├── APIClient.swift            # URLSession actor, auth interceptor
│   │   ├── APIError.swift             # typed error enum
│   │   └── Endpoint.swift             # all API endpoints in one enum
│   ├── Components/                    # shared UI components
│   └── Extensions/                    # Color+App, Error+UserMessage, etc.
├── Features/
│   ├── Auth/                          # Welcome, Login, Register, ForgotPassword
│   └── App/
│       ├── Home/                      # links list + dashboard
│       ├── Create/                    # create link form
│       ├── Detail/                    # link stats, QR code, delete
│       └── Profile/                   # user info, sign out
└── Models/                            # Codable structs: Link, User, AuthTokens

Config/                                # .xcconfig files (API URL per environment)
URLShortenerAppTests/                  # Swift Testing suite (mirrors app structure)
```

---

## Running the App

1. Open `URLShortenerApp.xcodeproj` in Xcode
2. Start the backend (default Debug URL is `http://localhost:3000`)
3. Select a simulator and press `Cmd+R`

---

## Testing

Tests use **Swift Testing** (`@Test` / `#expect`) and live in `URLShortenerAppTests/`,
mirroring the app's folder structure.

- **Run all:** `Cmd+U` in Xcode, or from the terminal:
  ```bash
  xcodebuild test -project URLShortenerApp.xcodeproj -scheme URLShortenerApp \
    -destination 'platform=iOS Simulator,name=iPhone 17 Pro'
  ```
- **Coverage:** ViewModels (logic + validation), models/decoding, the `APIClient`
  token-refresh flow (via a `URLProtocol` stub), and component render smoke tests.
- Mocks live in `URLShortenerAppTests/Support/` and reuse the sample data from the
  app's SwiftUI previews (`Link.samples`, `PreviewHomeService`).

---

## Code Quality

| Tool | Role | RN equivalent |
|---|---|---|
| SwiftFormat | formatting | Prettier |
| SwiftLint | lint rules | ESLint |
| Lefthook | git hooks | Husky |
| GitHub Actions | CI | GitHub Actions |

Setup on a fresh clone:

```bash
brew install swiftformat swiftlint lefthook
lefthook install
```

- **On build (Xcode):** SwiftLint runs as a build phase and shows warnings inline.
- **On `git commit`:** SwiftFormat + SwiftLint run on staged files.
- **On `git push`:** the full test suite runs.
- **On push / PR:** CI runs format check, lint, build, and tests.

Config files: `.swiftformat`, `.swiftlint.yml`, `.editorconfig`, `lefthook.yml`,
`.github/workflows/ci.yml`.
