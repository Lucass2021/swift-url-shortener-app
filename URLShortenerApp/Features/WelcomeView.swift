import SwiftUI

struct WelcomeView: View {
    var body: some View {
        NavigationStack {
            VStack(spacing: 16) {
                Text("URL Shortener")
                    .font(.largeTitle)
                    .bold()

                NavigationLink("Login") {
                    LoginView()
                }

                NavigationLink("Criar conta") {
                    RegisterView()
                }
            }
            .padding()
        }
    }
}

#Preview {
    WelcomeView()
}