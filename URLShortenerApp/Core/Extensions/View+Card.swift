import SwiftUI

extension View {
    func cardSurface(cornerRadius: CGFloat = 16) -> some View {
        background(Color.appSurfaceCard)
            .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(Color.white.opacity(0.08), lineWidth: 0.5)
            )
    }
}
