import SwiftUI

struct WelcomeView: View {
    @State private var showLogin = false
    @State private var showRegister = false
    @Environment(AuthStore.self) private var authStore

    var body: some View {
        @Bindable var authStore = authStore
        NavigationStack {
            ZStack {
                Color.appBackground.ignoresSafeArea()

                VStack(spacing: 0) {
                    Spacer()

                    WelcomeLogoSection()

                    Spacer().frame(height: 40)

                    WelcomeStatsCard()

                    Spacer()

                    WelcomeBottomSection(showLogin: $showLogin, showRegister: $showRegister)
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 32)
            }
            .navigationBarHidden(true)
            .navigationDestination(isPresented: $showLogin) { LoginView() }
            .navigationDestination(isPresented: $showRegister) { RegisterView() }
        }
        .toast(message: $authStore.pendingToast, style: .success)
    }
}

#Preview {
    WelcomeView()
        .environment(AuthStore())
}
