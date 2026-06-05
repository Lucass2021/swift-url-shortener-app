import SwiftUI

struct LinkRowView: View {
    let link: Link

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(link.code)
                .font(.headline)
                .foregroundStyle(.white)
            Text(link.originalUrl)
                .font(.caption)
                .foregroundStyle(.white.opacity(0.6))
                .lineLimit(1)
            Text("\(link.clicks) clicks")
                .font(.caption2)
                .foregroundStyle(Color.appPrimary)
        }
        .padding(.vertical, 4)
    }
}
