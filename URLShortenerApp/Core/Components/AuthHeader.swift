import SwiftUI

struct AuthHeader: View {
    let title: String
    var subtitle: String? = nil

    var body: some View {
        VStack(spacing: 20) {
            ZStack {
                RoundedRectangle(cornerRadius: 22)
                    .fill(Color.appSurface)
                    .frame(width: 100, height: 100)
                    .overlay(
                        RoundedRectangle(cornerRadius: 22)
                            .stroke(Color.white, lineWidth: 0.3)
                    )

                Image(systemName: "link")
                    .font(.system(size: 40, weight: .semibold))
                    .foregroundStyle(Color.appPrimary)
            }

            VStack(spacing: 8) {
                Text(title)
                    .font(.system(size: 34, weight: .bold))
                    .foregroundStyle(Color.appTextPrimary)

                if let subtitle {
                    Text(subtitle)
                        .font(.subheadline)
                        .foregroundStyle(Color.appTextPrimary)
                        .multilineTextAlignment(.center)
                }
            }
        }
    }
}

#Preview("With subtitle") {
    AuthHeader(title: "LinkShort", subtitle: "Precision link management \nat your fingertips.")
        .padding()
        .background(Color.appBackground)
}

#Preview("Title only") {
    AuthHeader(title: "LinkShort")
        .padding()
        .background(Color.appBackground)
}
