import SwiftUI

// How to view this with canva?
// Maybe break this code in more components?

struct WelcomeView: View {
    @State private var showLogin    = false
    @State private var showRegister = false

    var body: some View {
        NavigationStack {
            ZStack {
                Color.appBackground.ignoresSafeArea()

                VStack(spacing: 0) {
                    Spacer()

                    logoSection

                    Spacer().frame(height: 40)

                    statsCard

                    Spacer()

                    bottomSection
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 32)
            }
            .navigationBarHidden(true)
            // .navigationDestination(isPresented: $showLogin)    { LoginView() }
            // .navigationDestination(isPresented: $showRegister) { RegisterView() }
        }
    }

    // MARK: - Subviews

    private var logoSection: some View {
        VStack(spacing: 20) {
            ZStack {
                RoundedRectangle(cornerRadius: 22)
                    .fill(Color.appSurface)
                    .frame(width: 88, height: 88)

                Image(systemName: "bolt.fill")
                    .font(.system(size: 40, weight: .semibold))
                    .foregroundStyle(Color.appPrimary)
            }

            VStack(spacing: 8) {
                Text("LinkShort")
                    .font(.system(size: 34, weight: .bold))
                    .foregroundStyle(Color.appTextPrimary)

                Text("Shorten. Share. Track.")
                    .font(.subheadline)
                    .foregroundStyle(Color.appTextSecondary)
            }
        }
    }

    private var statsCard: some View {
        HStack(spacing: 0) {
            statItem(value: "4.2M+", label: "Links Created")

            Rectangle()
                .fill(Color.appOutline)
                .frame(width: 0.5, height: 40)

            statItem(value: "99.9%", label: "Uptime")
        }
        .padding(.vertical, 20)
        .background(Color.appSurface)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color.appOutline, lineWidth: 0.5)
        )
    }

    private func statItem(value: String, label: String) -> some View {
        VStack(spacing: 4) {
            Text(value)
                .font(.title2.bold())
                .foregroundStyle(Color.appAccent)
            Text(label)
                .font(.caption)
                .foregroundStyle(Color.appTextSecondary)
        }
        .frame(maxWidth: .infinity)
    }

    private var bottomSection: some View {
        VStack(spacing: 12) {
            PrimaryButton(title: "Sign In") {
                showLogin = true
            }

            SecondaryButton(title: "Create Account") {
                showRegister = true
            }

            Text("By continuing, you agree to our **Terms of Service**")
                .font(.caption)
                .foregroundStyle(Color.appTextSecondary)
                .multilineTextAlignment(.center)
                .padding(.top, 4)
        }
    }
}
