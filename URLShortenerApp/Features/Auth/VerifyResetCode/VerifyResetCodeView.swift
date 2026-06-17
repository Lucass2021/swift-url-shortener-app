
import SwiftUI

struct VerifyResetCodeView: View {
    @State private var viewModel: VerifyResetCodeViewModel
    @Environment(\.dismiss) private var dismiss

    init(email: String) {
        _viewModel = State(initialValue: VerifyResetCodeViewModel(email: email))
    }

    var body: some View {
        ZStack {
            Color.appBackground.ignoresSafeArea()

            VStack(spacing: 0) {
                Spacer()

                AuthHeader(title: "LinkShort")
                    .staggeredAppear(0)

                Spacer().frame(height: 48)

                VerifyResetCodeFormSection(viewModel: viewModel)
                    .staggeredAppear(1)

                Spacer()

                VerifyResetCodeBottomSection(viewModel: viewModel)
                    .staggeredAppear(2)
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 32)
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            GoBackHeader(title: "Back") { dismiss() }
        }
        .enableSwipeBack()
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
