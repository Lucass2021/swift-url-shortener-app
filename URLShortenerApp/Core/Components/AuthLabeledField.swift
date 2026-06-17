import SwiftUI

struct AuthLabeledField<Content: View>: View {
    let label: String
    @ViewBuilder let content: Content

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(label)
                .font(.callout)
                .foregroundStyle(Color.white)

            content
        }
    }
}

#Preview {
    AuthLabeledField(label: "Email Address") {
        AuthTextField(
            placeholder: "name@company.com",
            icon: "envelope",
            text: .constant(""),
            error: nil
        )
    }
    .padding()
    .background(Color.appBackground)
}
