import SwiftUI

struct ProfileAvatarSection: View {
    let name: String
    let email: String
    var isLoading: Bool = false

    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: "person.circle.fill")
                .font(.system(size: 88))
                .foregroundStyle(Color.appPrimary)

            if isLoading {
                SkeletonBar(width: 140, height: 24)
                SkeletonBar(width: 180, height: 30, cornerRadius: 15)
            } else {
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
}

#Preview {
    ProfileAvatarSection(name: "Lucas Dias", email: "lucas@example.com")
        .padding()
        .background(Color.appBackgroundApp)
}
