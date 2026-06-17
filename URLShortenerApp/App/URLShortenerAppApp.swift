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
    @State private var showSplash = true

    var body: some View {
        ZStack {
            if authStore.isAuthenticated {
                AppView()
            } else {
                WelcomeView()
            }

            if showSplash {
                SplashView {
                    withAnimation(.easeInOut(duration: 0.4)) {
                        showSplash = false
                    }
                }
                .transition(.opacity)
            }
        }
        .preferredColorScheme(.dark)
    }
}
