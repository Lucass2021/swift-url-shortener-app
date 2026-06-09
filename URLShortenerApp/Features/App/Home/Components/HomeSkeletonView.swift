import SwiftUI

struct HomeSkeletonView: View {
    @State private var shimmer = false

    private let placeholder = Link(
        code: "placeholder-link",
        originalUrl: "https://example.com/placeholder-url-here",
        clicks: 0,
        createdAt: .now,
        expiresAt: nil,
        isProtected: false
    )

    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                HStack(spacing: 12) {
                    statPlaceholder(labelWidth: 80, valueWidth: 40)
                    statPlaceholder(labelWidth: 70, valueWidth: 30)
                }
                .padding(.horizontal, 20)
                .padding(.top, 16)
                .padding(.bottom, 20)

                VStack(spacing: 16) {
                    ForEach(0..<4, id: \.self) { _ in
                        LinkRowView(link: placeholder)
                            .redacted(reason: .placeholder)
                    }
                }
                .padding(.horizontal, 20)
            }
        }
        .opacity(shimmer ? 0.5 : 1.0)
        .onAppear {
            withAnimation(.easeInOut(duration: 0.9).repeatForever(autoreverses: true)) {
                shimmer = true
            }
        }
    }

    private func statPlaceholder(labelWidth: CGFloat, valueWidth: CGFloat) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            RoundedRectangle(cornerRadius: 4)
                .fill(Color.appSurfaceHigh)
                .frame(width: labelWidth, height: 12)
            RoundedRectangle(cornerRadius: 4)
                .fill(Color.appSurfaceHigh)
                .frame(width: valueWidth, height: 22)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(16)
        .background(Color.appSurfaceCard)
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color.white.opacity(0.3), lineWidth: 0.5))
    }
}

#Preview {
    ZStack {
        Color.appBackgroundApp.ignoresSafeArea()
        HomeSkeletonView()
    }
}
