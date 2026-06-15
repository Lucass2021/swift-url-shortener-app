import SwiftUI

struct SuccessOverlay: View {
    var message: String = "Done!"

    @State private var animate = false

    var body: some View {
        ZStack {
            Color.appBackground.opacity(0.6).ignoresSafeArea()

            VStack(spacing: 16) {
                Image(systemName: "checkmark.circle.fill")
                    .font(.system(size: 72))
                    .foregroundStyle(Color.appSuccess)
                    .scaleEffect(animate ? 1 : 0.5)

                Text(message)
                    .font(.headline)
                    .foregroundStyle(.white)
            }
            .opacity(animate ? 1 : 0)
        }
        .onAppear {
            withAnimation(.spring(response: 0.4, dampingFraction: 0.6)) {
                animate = true
            }
        }
    }
}

#Preview {
    SuccessOverlay(message: "Link created!")
}
