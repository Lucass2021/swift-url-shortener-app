
import SwiftUI

struct ResetPasswordView: View {
    @State private var viewModel = ResetPasswordViewModel(resetToken: "")
    @Environment(\.dismiss) private var dismiss

    init(resetToken: String) {
        _viewModel = State(initialValue: ResetPasswordViewModel(resetToken: resetToken))
    }

    var body: some View {
        AuthScreenScaffold {
            Spacer()

            AuthHeader(title: "LinkShort")
                .staggeredAppear(0)

            Spacer().frame(height: 48)

            ResetPasswordFormSection(viewModel: viewModel)
                .staggeredAppear(1)

            Spacer()

            ResetPasswordBottomSection(viewModel: viewModel)
                .staggeredAppear(2)
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            GoBackHeader(title: "Back") { dismiss() }
        }
        .enableSwipeBack()
        .toast(message: $viewModel.errorMessage)
    }
}

#Preview {
    NavigationStack {
        ResetPasswordView(resetToken: "sample-token")
    }
    .environment(AuthStore())
}
