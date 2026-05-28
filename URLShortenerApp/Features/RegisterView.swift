import SwiftUI

struct RegisterView: View {
    @State private var email = ""
    @State private var password = ""

    var body: some View {
        VStack(spacing: 16) {
            TextField("Email", text: $email)
                .textContentType(.emailAddress)
                .autocapitalization(.none)
                .keyboardType(.emailAddress)
                .textFieldStyle(.roundedBorder)

            SecureField("Senha", text: $password)
                .textFieldStyle(.roundedBorder)

            Button("Criar conta") {
                // TODO: chamar RegisterViewModel
            }
            .buttonStyle(.borderedProminent)
        }
        .padding()
        .navigationTitle("Criar conta")
    }
}

#Preview {
    NavigationStack {
        RegisterView()
    }
}
