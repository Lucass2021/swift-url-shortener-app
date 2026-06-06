import SwiftUI

struct LinkRowView: View {
    let link: Link

    private var shortDomain: String {
        URL(string: Config.baseURL)?.host ?? ""
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("\(shortDomain)/\(link.code)")
                .font(.system(.subheadline, design: .monospaced).weight(.semibold))
                .foregroundStyle(Color.appAccent)

            Text(link.originalUrl)
                .font(.subheadline)
                .foregroundStyle(.white)
                .lineLimit(1)

            HStack(spacing: 16) {
                HStack(spacing: 4) {
                    Image(systemName: "cursorarrow.click")
                    Text("\(link.clicks) clicks")
                }
                .font(.caption)
                .foregroundStyle(.white)

                HStack(spacing: 4) {
                    Image(systemName: "clock")
                    Text("Expires in 30 days")
                }
                .font(.caption)
                .foregroundStyle(Color.appTertiary)
            }
        }
        .padding(16)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.appSurfaceCard)
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color.white.opacity(0.3), lineWidth: 0.5)
        )
    }
}
