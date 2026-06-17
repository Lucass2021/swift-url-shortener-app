
import SwiftUI

struct ForgotPasswordView: View {
    @State private var viewModel = ForgotPasswordViewModel()

    var body: some View {
        ZStack {
            Color.appBackground.ignoresSafeArea()

            VStack(spacing: 0) {
                Spacer()

                AuthHeader(
                    title: "LinkShort",
                    subtitle: "Forgot your password? \nNo worries, we got you!"
                )

                Spacer().frame(height: 48)

                ForgotPasswordFormSection(viewModel: viewModel)

                Spacer()

                ForgotPasswordBottomSection(viewModel: viewModel)
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 32)
        }
        .navigationBarHidden(true)
        .navigationDestination(isPresented: $viewModel.showVerifyCode) {
            VerifyResetCodeView(email: viewModel.email)
        }
        .toast(message: $viewModel.errorMessage)
    }
}

#Preview {
    NavigationStack {
        ForgotPasswordView()
    }
    .environment(AuthStore())
}
