
import SwiftUI

struct VerifyResetCodeView: View {
    @State private var viewModel: VerifyResetCodeViewModel

    init(email: String) {
        _viewModel = State(initialValue: VerifyResetCodeViewModel(email: email))
    }

    var body: some View {
        ZStack {
            Color.appBackground.ignoresSafeArea()

            VStack(spacing: 0) {
                Spacer()

                AuthHeader(title: "LinkShort")

                Spacer().frame(height: 48)

                VerifyResetCodeFormSection(viewModel: viewModel)

                Spacer()

                VerifyResetCodeBottomSection(viewModel: viewModel)
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 32)
        }
        .navigationBarHidden(true)
        .navigationDestination(isPresented: $viewModel.showResetPassword) {
            ResetPasswordView(resetToken: viewModel.resetToken ?? "")
        }
        .toast(message: $viewModel.errorMessage)
    }
}

#Preview {
    NavigationStack {
        VerifyResetCodeView(email: "test@example.com")
    }
    .environment(AuthStore())
}
