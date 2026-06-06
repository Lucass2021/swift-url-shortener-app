import SwiftUI

struct RegisterBottomSection: View {
    var viewModel: RegisterViewModel
    @Binding var showLogin: Bool
    @Environment(AuthStore.self) private var authStore

    var body: some View {
        VStack(spacing: 12) {
            PrimaryButton(title: "Create Account", isLoading: viewModel.isLoading) {
                Task { await viewModel.signUp(authStore: authStore) }
            }

            Text("Already have an account? \(Text("Sign In").bold().foregroundStyle(Color.appPrimary))")
                .font(.default)
                .foregroundStyle(Color.appTextSecondary)
                .multilineTextAlignment(.center)
                .padding(.top, 4)
                .onTapGesture {
                    showLogin = true
                }
        }
    }
}

#Preview {
    RegisterBottomSection(viewModel: RegisterViewModel(), showLogin: .constant(false))
        .padding()
        .background(Color.appBackground)
        .environment(AuthStore())
}
