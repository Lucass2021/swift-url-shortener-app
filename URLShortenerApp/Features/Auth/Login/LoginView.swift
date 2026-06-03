import SwiftUI

struct LoginView: View {
    @State private var viewModel = LoginViewModel()
    @State private var showRegister = false
    @State private var showForgotPassword = false

    var body: some View {
        ZStack {
            Color.appBackground.ignoresSafeArea()

            VStack(spacing: 0) {
                Spacer()

                LoginLogoSection()

                Spacer().frame(height: 48)

                LoginFormSection(viewModel: viewModel, showForgotPassword: $showForgotPassword)

                Spacer()

                LoginBottomSection(viewModel: viewModel, showRegister: $showRegister)
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 32)
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
