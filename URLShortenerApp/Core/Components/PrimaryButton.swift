import SwiftUI

struct PrimaryButton: View {
    let title: String
    var isLoading: Bool = false
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            ZStack {
                if isLoading {
                    ProgressView()
                        .tint(.white)
                } else {
                    Text(title)
                        .font(.headline)
                        .foregroundStyle(.white)
                }
            }
            .frame(maxWidth: .infinity)
            .frame(height: 52)
            .background(Color.appPrimary)
            .clipShape(RoundedRectangle(cornerRadius: 14))
        }
        .disabled(isLoading)
        .buttonStyle(.plain)
    }
}

#Preview {
    VStack(spacing: 16) {
        PrimaryButton(title: "Sign In") {}
        PrimaryButton(title: "Loading", isLoading: true) {}
    }
    .padding()
    .background(Color.appBackground)
}
