import SwiftUI

struct WelcomeView: View {
    @State private var showLogin = false
    @State private var showRegister = false

    var body: some View {
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
    }
}

#Preview {
    WelcomeView()
        .environment(AuthStore())
}
