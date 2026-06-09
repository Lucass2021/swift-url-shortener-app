import SwiftUI

struct WelcomeBottomSection: View {
    @Binding var showLogin: Bool
    @Binding var showRegister: Bool

    var body: some View {
        VStack(spacing: 12) {
            PrimaryButton(title: "Sign In") {
                showLogin = true
            }

            SecondaryButton(title: "Create Account") {
                showRegister = true
            }

            Text("By continuing, you agree to our \(Text("Terms of Service").bold().underline())")
                .font(.caption)
                .foregroundStyle(Color.appTextSecondary)
                .multilineTextAlignment(.center)
                .padding(.top, 4)
        }
    }
}

#Preview {
    @Previewable @State var showLogin = false
    @Previewable @State var showRegister = false
    ZStack {
        Color.appBackgroundApp.ignoresSafeArea()
        WelcomeBottomSection(showLogin: $showLogin, showRegister: $showRegister)
            .padding(.horizontal, 20)
    }
}
