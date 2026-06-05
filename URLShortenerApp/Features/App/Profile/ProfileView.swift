import SwiftUI

struct ProfileView: View {
    @Environment(AuthStore.self) private var authStore
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        ZStack {
            Color.appBackground.ignoresSafeArea()

            VStack(spacing: 24) {
                Image(systemName: "person.circle.fill")
                    .font(.system(size: 72))
                    .foregroundStyle(Color.appPrimary)

                Button(role: .destructive) {
                    dismiss()
                    authStore.logout()
                } label: {
                    Text("Sign Out")
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.borderedProminent)
                .tint(Color.appDestructive)
                .padding(.horizontal, 32)
            }
        }
        .presentationDetents([.medium])
    }
}
