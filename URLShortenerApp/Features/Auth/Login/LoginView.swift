import SwiftUI

struct LoginView: View {
    @State private var viewModel = LoginViewModel()
    @State private var showRegister = false
    @State private var showForgotPassword = false

    var body: some View {
        AuthScreenScaffold {
            Spacer()

            AuthHeader(
                title: "LinkShort",
                subtitle: "Precision link management \nat your fingertips."
            )
            .staggeredAppear(0)

            Spacer().frame(height: 48)

            LoginFormSection(viewModel: viewModel, showForgotPassword: $showForgotPassword)
                .staggeredAppear(1)

            Spacer()

            LoginBottomSection(viewModel: viewModel, showRegister: $showRegister)
                .staggeredAppear(2)
        }
        .navigationBarHidden(true)
        .navigationDestination(isPresented: $showRegister) { RegisterView() }
        .navigationDestination(isPresented: $showForgotPassword) { ForgotPasswordView() }
        .toast(message: $viewModel.errorMessage)
    }
}

#Preview {
    NavigationStack {
        LoginView()
    }
    .environment(AuthStore())
}
