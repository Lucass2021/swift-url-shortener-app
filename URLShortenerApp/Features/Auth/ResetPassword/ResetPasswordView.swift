
import SwiftUI

struct ResetPasswordView: View {
    @State private var viewModel = ResetPasswordViewModel(resetToken: "")
    @Environment(\.dismiss) private var dismiss

    init(resetToken: String) {
        _viewModel = State(initialValue: ResetPasswordViewModel(resetToken: resetToken))
    }

    var body: some View {
        ZStack {
            Color.appBackground.ignoresSafeArea()

            VStack(spacing: 0) {
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
            .padding(.horizontal, 20)
            .padding(.bottom, 32)
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
