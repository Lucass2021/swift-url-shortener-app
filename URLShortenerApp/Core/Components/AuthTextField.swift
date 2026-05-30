import SwiftUI

struct AuthTextField: View {
    let placeholder: String
    let icon: String
    @Binding var text: String
    var isSecure: Bool = false

    @State private var isRevealed = false
    @FocusState private var isFocused: Bool

    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .foregroundStyle(Color.appTextSecondary)
                .frame(width: 20)

            if isSecure && !isRevealed {
                SecureField(text: $text, prompt: Text(placeholder).foregroundStyle(.white)) {}
                    .focused($isFocused)
            } else {
                TextField(text: $text, prompt: Text(placeholder).foregroundStyle(.white)) {}
                    .focused($isFocused)
                    .keyboardType(isSecure ? .default : .emailAddress)
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled()
            }

            if isSecure {
                Button {
                    isRevealed.toggle()
                } label: {
                    Image(systemName: isRevealed ? "eye" : "eye.slash")
                        .foregroundStyle(Color.appTextSecondary)
                }
                .buttonStyle(.plain)
            }
        }
        .padding(.horizontal, 16)
        .frame(height: 52)
        .background(Color.appSurface)
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(isFocused ? Color.appPrimary : Color.appOutline, lineWidth: isFocused ? 2 : 0.5)
        )
        .foregroundStyle(Color.appTextPrimary)
    }
}

#Preview {
    @Previewable @State var text = ""
    VStack(spacing: 16) {
        AuthTextField(placeholder: "name@company.com", icon: "envelope", text: $text)
        AuthTextField(placeholder: "••••••••", icon: "lock", text: $text, isSecure: true)
    }
    .padding()
    .background(Color.appBackground)
}
