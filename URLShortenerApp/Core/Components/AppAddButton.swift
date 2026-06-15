import SwiftUI

struct AppAddButton: View {
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Image(systemName: "plus")
                .font(.title2.bold())
                .foregroundStyle(.white)
                .frame(width: 56, height: 56)
                .background(Color.appPrimary)
                .clipShape(Circle())
                .shadow(color: Color.appPrimary.opacity(0.4), radius: 8, x: 0, y: 4)
        }
        .buttonStyle(PressableButtonStyle(scale: 0.9))
    }
}

#Preview {
    ZStack {
        Color.black.ignoresSafeArea()
        AppAddButton {}
    }
}
