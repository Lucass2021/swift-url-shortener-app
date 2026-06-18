import SwiftUI

struct RegisterView: View {
    @State private var viewModel = RegisterViewModel()
    @State private var showLogin = false

    var body: some View {
        AuthScreenScaffold {
            AuthHeader(
                title: "Join LinkShort",
                subtitle: "Create an account to start managing your \nlinks with precision."
            )
            .staggeredAppear(0)

            Spacer().frame(height: 48)

            RegisterFormSection(viewModel: viewModel)
                .staggeredAppear(1)

            Spacer().frame(height: 32)

            RegisterBottomSection(viewModel: viewModel, showLogin: $showLogin)
                .staggeredAppear(2)
        }
        .navigationBarHidden(true)
        .navigationDestination(isPresented: $showLogin) { LoginView() }
        .toast(message: $viewModel.errorMessage)
    }
}

#Preview {
    NavigationStack {
        RegisterView()
    }
    .environment(AuthStore())
}
