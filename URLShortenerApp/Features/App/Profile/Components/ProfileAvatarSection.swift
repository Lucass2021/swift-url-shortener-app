import SwiftUI

struct ProfileAvatarSection: View {
    let name: String
    let email: String

    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: "person.circle.fill")
                .font(.system(size: 88))
                .foregroundStyle(Color.appPrimary)

            Text(name)
                .font(.title2.weight(.bold))
                .foregroundStyle(.white)

            Text(email)
                .font(.subheadline)
                .foregroundStyle(Color.appTextSecondary)
                .padding(.horizontal, 16)
                .padding(.vertical, 6)
                .background(Color.appSurface)
                .clipShape(Capsule())
        }
    }
}

#Preview {
    ProfileAvatarSection(name: "Lucas Dias", email: "lucas@example.com")
        .padding()
        .background(Color.appBackgroundApp)
}
