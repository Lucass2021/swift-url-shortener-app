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
