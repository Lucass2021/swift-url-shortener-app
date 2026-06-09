import SwiftUI

struct LinkDetailHeroCard: View {
    let shortURL: String
    let isCopied: Bool
    let onCopy: () -> Void

    var body: some View {
        VStack(spacing: 16) {
            VStack(spacing: 6) {
                Text("SHORT LINK")
                    .font(.caption)
                    .fontWeight(.semibold)
                    .foregroundStyle(.white.opacity(0.5))
                    .tracking(1.5)

                Text(shortURL)
                    .font(.system(.body, design: .monospaced).weight(.semibold))
                    .foregroundStyle(Color.appAccent)
                    .multilineTextAlignment(.center)
            }

            Button(action: onCopy) {
                HStack(spacing: 8) {
                    Image(systemName: isCopied ? "checkmark" : "doc.on.doc")
                        .contentTransition(.symbolEffect(.replace))

                    Text(isCopied ? "Copied!" : "Copy Link")
                }
                .font(.subheadline.weight(.semibold))
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity)
                .frame(height: 48)
                .background(Color.appAccent)
                .clipShape(RoundedRectangle(cornerRadius: 12))
            }
        }
        .padding(20)
        .frame(maxWidth: .infinity)
        .background(Color.appSurfaceCard)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color.white.opacity(0.08), lineWidth: 0.5)
        )
    }
}

#Preview {
    LinkDetailHeroCard(shortURL: "https://short.ly/abc123", isCopied: false) {}
        .padding()
        .background(Color.appBackground)
}
