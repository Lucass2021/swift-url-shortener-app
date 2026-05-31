import SwiftUI

private struct ToastView: View {
    let message: String

    var body: some View {
        Text(message)
            .font(.subheadline)
            .foregroundStyle(.white)
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
            .background(Color.red.opacity(0.9))
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .shadow(radius: 4)
            .padding(.horizontal, 20)
    }
}

private struct ToastModifier: ViewModifier {
    @Binding var message: String?

    func body(content: Content) -> some View {
        ZStack(alignment: .top) {
            content
            if let message {
                ToastView(message: message)
                    .transition(.move(edge: .top).combined(with: .opacity))
                    .padding(.top, 60)
                    .zIndex(1)
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                            withAnimation(.easeOut) { self.message = nil }
                        }
                    }
            }
        }
        .animation(.spring(duration: 0.3), value: message)
    }
}

extension View {
    func toast(message: Binding<String?>) -> some View {
        modifier(ToastModifier(message: message))
    }
}
