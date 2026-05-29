# Project: Native iOS App — URL Shortener Client

## Developer context

Frontend/mobile developer with solid experience in React Native, Expo, and TypeScript.
Expanding into native development with the goal of growing to senior level.

This project is a direct continuation of an already built and working backend:
**[nest-api-url-shortener-context](https://github.com/Lucass2021/nest-api-url-shortener-context)**

The goal is to learn SwiftUI by consuming a real API the developer built themselves —
familiar domain, no need to understand new business logic while also learning Swift.

---

## Project goal

Build a native iOS app in SwiftUI that consumes the existing URL shortener API.
Full focus on **learning Swift and SwiftUI** with good practices, not on creating new features.

---

## Available API (already ready)

Base URL: `http://localhost:3000` (local) or deploy URL on Railway/Render

### Endpoints the app will consume

**Auth**
- `POST /auth/register` — register with `name`, `email`, and `password` *(name added — requires backend update)*
- `POST /auth/login` — login, returns `accessToken` + `refreshToken`
- `POST /auth/refresh` — renews the accessToken using the refreshToken

**Links**
- `POST /links/shorten` — creates short link (body: `{ url, expiresAt? }`)
- `GET /links/me/links` — lists links for the authenticated user
- `DELETE /links/:code` — deletes own link

**Stats**
- `GET /:code/stats` — link statistics (total clicks, created at, last visit)

**Auth headers**
```
Authorization: Bearer <accessToken>
```

**Standard error responses**
- `401` — token expired → should attempt automatic refresh
- `410` — link expired
- `429` — rate limit reached, `Retry-After` header present

---

## Expected screens

### Authentication flow
- **Welcome screen** — buttons for Login and Sign Up
- **Login screen** — email and password fields, sign in button
- **Sign up screen** — name, email, and password fields, create account button

### Main flow (authenticated)
- **Links list** — all user links, with code, original URL, clicks, and expiration; summary row at top with total clicks and active links count (computed client-side)
- **Create link** — URL field, expiration picker (7 days / 30 days / never), shorten button
- **Link detail** — full stats, copy short link button, QR code (generated client-side via CoreImage), delete button
- **Profile / logout** — user name and email, sign out button

---

## Technical requirements

### Secure storage
- `accessToken` and `refreshToken` stored in the **Keychain** (never in UserDefaults)
- Logout clears tokens from Keychain

### Automatic token refresh
- Request interceptor that detects `401`
- Automatically attempts `POST /auth/refresh`
- If refresh fails, redirects to login
- Queue of pending requests during refresh (does not fire multiple refreshes in parallel)

### Networking
- Centralized network layer with `URLSession` (no external libraries)
- Decoding with `Codable`
- Typed error handling (API error enum)

### Architecture
- **MVVM** — clear separation between View, ViewModel, and Model
- ViewModels with `@Observable` (Swift 5.9+) or `ObservableObject`
- Services for networking (AuthService, LinksService)
- Keychain encapsulated in its own helper (`KeychainHelper`)

### UI / UX
- Pure SwiftUI, no UIKit
- Loading states on all async actions
- User-friendly error messages (no technical details exposed)
- Swipe to delete on links list
- Pull to refresh on links list
- Copy short link to clipboard button with visual feedback (animated checkmark)
- QR code generation via `CoreImage` (no external libraries)
- Dashboard totals (total clicks, active links) computed client-side from the links list

---

## What the developer wants to learn

1. **SwiftUI** — view structure, modifiers, navigation with NavigationStack
2. **Keychain** — secure token storage on iOS
3. **URLSession** — native networking without external libraries
4. **MVVM in Swift** — how to organize code with `@Observable` / `ObservableObject`
5. **Automatic token refresh** — native auth interceptor (equivalent to axios interceptors)
6. **Async/await in Swift** — modern concurrency without callbacks
7. **Swift Concurrency** — `Task`, `MainActor`, cancellation
8. **CoreImage** — QR code generation using native iOS framework

---

## Milestones

| # | Deliverable | Estimated time |
|---|-------------|---------------|
| 1 | Xcode project setup, MVVM folder structure, KeychainHelper | a few hours |
| 2 | Networking layer: URLSession + Codable + error enum | half a day |
| 3 | Backend: add `name` field to register endpoint (NestJS) | ~30 min |
| 4 | Login and sign up screens working with the real API | a weekend |
| 5 | Automatic token refresh with pending request queue | + 1 day |
| 6 | Links list with pull to refresh, swipe to delete, and dashboard totals | + 1 day |
| 7 | Create link screen with expiration picker | + half a day |
| 8 | Detail screen with stats, copy button, and QR code via CoreImage | + half a day |
| 9 | Profile screen with name, email, and sign out | + half a day |
| 10 | Polish: loading states, errors, animations, app icon | + 1 day |

---

## Folder structure

```
URLShortenerApp/
├── App/
│   └── URLShortenerApp.swift       # @main, dependency injection
├── Core/
│   ├── Network/
│   │   ├── APIClient.swift         # centralized URLSession
│   │   ├── APIError.swift          # typed error enum
│   │   └── Endpoint.swift          # endpoint enum
│   ├── Auth/
│   │   └── KeychainHelper.swift    # Keychain wrapper
│   └── Extensions/
│       └── View+Extensions.swift
├── Features/
│   ├── Auth/
│   │   ├── WelcomeView.swift
│   │   ├── LoginView.swift
│   │   ├── LoginViewModel.swift
│   │   ├── RegisterView.swift
│   │   └── RegisterViewModel.swift
│   ├── Links/
│   │   ├── LinksListView.swift
│   │   ├── LinksListViewModel.swift
│   │   ├── CreateLinkView.swift
│   │   ├── CreateLinkViewModel.swift
│   │   ├── LinkDetailView.swift
│   │   └── LinkDetailViewModel.swift
│   └── Profile/
│       └── ProfileView.swift
└── Models/
    ├── Link.swift
    ├── User.swift
    └── AuthTokens.swift
```

---

## Extras (out of scope for now, implement after all milestones)

Features intentionally deferred — good learning exercises if the developer wants to go further after completing the main milestones.

### Passcode Protect
Protect a short link with a 4-digit code. When someone accesses the short URL, the backend checks if a passcode is required before redirecting.

**Backend changes needed (NestJS):**
- Add optional `passcode` field to the `Link` entity
- Accept `passcode` in `POST /links/shorten` body
- Add validation in the redirect handler: if link has a passcode, check it before redirecting (new endpoint or query param)

**iOS changes:**
- Add optional passcode input in `CreateLinkView` (4-digit PIN field)
- Show passcode entry sheet in `LinkDetailView` if the link is protected

**Why it's a good exercise:** Teaches how to extend an existing NestJS entity, add validation middleware, and handle conditional UI states in SwiftUI.

---

## How to use this context with an AI

Paste this document and add one of the instructions below:

**To start the project:**
> "Based on this context, help me configure the Xcode project with the MVVM folder structure and the KeychainHelper to store tokens."

**For a specific milestone:**
> "Based on this context, I'm on milestone 4 (automatic token refresh). Help me implement the interceptor with a pending request queue in Swift."

**For a specific screen:**
> "Based on this context, implement LinksListView with SwiftUI, pull to refresh, and swipe to delete consuming the LinksListViewModel."

**For code review:**
> "Based on this context, review this ViewModel and point out what a senior iOS dev would change."

**For Swift questions:**
> "Based on this context, explain how `@Observable` works and how to use it in this project's ViewModels."
