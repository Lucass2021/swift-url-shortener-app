import SwiftUI

@main
struct URLShortenerAppApp: App {
    @State private var authStore = AuthStore()

    var body: some Scene {
        WindowGroup {
            RootView()
                .environment(authStore)
        }
    }
}

private struct RootView: View {
    @Environment(AuthStore.self) private var authStore

    var body: some View {
        if authStore.isAuthenticated {
            AppView()
        } else {
            WelcomeView()
        }
    }
}
