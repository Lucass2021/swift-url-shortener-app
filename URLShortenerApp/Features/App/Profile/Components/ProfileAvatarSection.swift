import SwiftUI

struct ProfileAvatarSection: View {
    let name: String
    let email: String
    var isLoading: Bool = false

    private var initials: String {
        let letters = name
            .split(separator: " ")
            .prefix(2)
            .compactMap(\.first)

        return letters.isEmpty ? "?" : letters.map(String.init).joined().uppercased()
    }

    var body: some View {
        VStack(spacing: 8) {
            Text(initials)
                .font(.system(size: 36, weight: .semibold, design: .rounded))
                .foregroundStyle(.white)
                .frame(width: 88, height: 88)
                .background(Circle().fill(Color.appPrimary.gradient))
                .overlay(Circle().stroke(Color.white.opacity(0.15), lineWidth: 1))
                .redacted(reason: isLoading ? .placeholder : [])

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
