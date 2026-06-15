import SwiftUI

struct SkeletonBar: View {
    var width: CGFloat? = nil
    var height: CGFloat = 16
    var cornerRadius: CGFloat = 6

    @State private var shimmer = false

    var body: some View {
        RoundedRectangle(cornerRadius: cornerRadius)
            .fill(Color.appSurfaceHigh)
            .frame(width: width, height: height)
            .opacity(shimmer ? 0.4 : 0.85)
            .onAppear {
                withAnimation(.easeInOut(duration: 0.9).repeatForever(autoreverses: true)) {
                    shimmer = true
                }
            }
    }
}

#Preview {
    VStack(alignment: .leading, spacing: 12) {
        SkeletonBar(width: 140, height: 24)
        SkeletonBar(width: 200, height: 16)
        SkeletonBar(width: 90, height: 30)
    }
    .padding()
    .background(Color.appBackgroundApp)
}
