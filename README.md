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

---

## Features

- Register and login with JWT authentication
- Automatic access token refresh with queued requests during refresh
- List, create, and delete short links
- Pull to refresh and swipe to delete on links list
- Link detail with stats, copy button, and QR code generation
- Passcode protection for links
- Profile screen with name, email, and sign out

---

## Backend

The API is a NestJS project running locally or on Railway/Render.  
Base URL is configured in `Core/Config.swift`.

To run the backend locally, see the [backend README](https://github.com/Lucass2021/nest-api-url-shortener-context).

---

## Project Structure

```
URLShortenerApp/
├── App/
│   └── URLShortenerAppApp.swift       # @main entry point, environment injection
├── Core/
│   ├── Auth/
│   │   ├── AuthStore.swift            # authentication state (@Observable)
│   │   ├── AuthService.swift          # login, register, refresh calls
│   │   └── KeychainHelper.swift       # secure token storage
│   ├── Network/
│   │   ├── APIClient.swift            # URLSession wrapper, auth interceptor
│   │   ├── APIError.swift             # typed error enum
│   │   └── Endpoint.swift             # all API endpoints in one enum
│   ├── Components/                    # shared UI components
│   └── Extensions/                    # Color+App, View+Toast, etc.
├── Features/
│   ├── Auth/                          # Welcome, Login, Register, ForgotPassword
│   └── App/
│       ├── Home/                      # links list + dashboard
│       ├── Create/                    # create link form
│       ├── Detail/                    # link stats, QR code, delete
│       └── Profile/                   # user info, sign out
└── Models/                            # Codable structs: Link, User, AuthTokens
```

---

## Running the App

1. Open `URLShortenerApp.xcodeproj` in Xcode
2. Make sure the backend is running at the URL set in `Core/Config.swift`
3. Select a simulator and press `Cmd+R`
