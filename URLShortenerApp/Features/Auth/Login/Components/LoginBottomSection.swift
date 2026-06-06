import SwiftUI

struct LoginBottomSection: View {
    var viewModel: LoginViewModel
    @Binding var showRegister: Bool
    @Environment(AuthStore.self) private var authStore

    var body: some View {
        VStack(spacing: 12) {
            PrimaryButton(title: "Sign In", isLoading: viewModel.isLoading) {
                Task { await viewModel.signIn(authStore: authStore) }
            }

            Text("Don't have an account? \(Text("Sign Up").bold().foregroundStyle(Color.appPrimary))")
                .font(.default)
                .foregroundStyle(Color.appTextSecondary)
                .multilineTextAlignment(.center)
                .padding(.top, 4)
                .onTapGesture {
                    showRegister = true
                }
        }
    }
}

#Preview {
    LoginBottomSection(viewModel: LoginViewModel(), showRegister: .constant(false))
        .padding()
        .background(Color.appBackground)
        .environment(AuthStore())
}
