
import SwiftUI

struct ForgotPasswordView: View {
    @State private var viewModel = ForgotPasswordViewModel()

    var body: some View {
        AuthScreenScaffold {
            Spacer()

            AuthHeader(
                title: "LinkShort",
                subtitle: "Forgot your password? \nNo worries, we got you!"
            )
            .staggeredAppear(0)

            Spacer().frame(height: 48)

            ForgotPasswordFormSection(viewModel: viewModel)
                .staggeredAppear(1)

            Spacer()

            ForgotPasswordBottomSection(viewModel: viewModel)
                .staggeredAppear(2)
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
