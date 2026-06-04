
import SwiftUI

struct ResetPasswordView: View {
    @State private var viewModel = ResetPasswordViewModel(resetToken: "")

    init(resetToken: String) {
        _viewModel = State(initialValue: ResetPasswordViewModel(resetToken: resetToken))
    }

    var body: some View {
        ZStack {
            Color.appBackground.ignoresSafeArea()

            VStack(spacing: 0) {
                Spacer()

                ResetPasswordLogoSection()

                Spacer().frame(height: 48)

                ResetPasswordFormSection(viewModel: viewModel)

                Spacer()

                ResetPasswordBottomSection(viewModel: viewModel)
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 32)
        }
        .navigationBarHidden(true)
        .toast(message: $viewModel.errorMessage)
    }
}

#Preview {
    NavigationStack {
        ResetPasswordView(resetToken: "sample-token")
    }
    .environment(AuthStore())
}
