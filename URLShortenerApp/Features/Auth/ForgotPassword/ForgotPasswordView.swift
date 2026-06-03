
import SwiftUI

struct ForgotPasswordView: View {
    @State private var viewModel = ForgotPasswordViewModel()

    var body: some View {
        ZStack {
            Color.appBackground.ignoresSafeArea()

            VStack(spacing: 0) {
                Spacer()

                ForgotPasswordLogoSection()

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
