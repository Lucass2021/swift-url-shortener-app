import SwiftUI

struct ExpirationPicker: View {
    @Binding var selected: ExpirationOption

    var body: some View {
        HStack(spacing: 8) {
            ForEach(ExpirationOption.allCases, id: \.self) { option in
                Button {
                    selected = option
                } label: {
                    Text(option.label)
                        .font(.subheadline)
                        .fontWeight(.medium)
                        .foregroundStyle(selected == option ? .white : Color.appTextSecondary)
                        .frame(maxWidth: .infinity)
                        .frame(height: 40)
                        .background(selected == option ? Color.appPrimary : Color.appSurface)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                }
                .buttonStyle(.plain)
            }
        }
    }
}

#Preview {
    @Previewable @State var selected = ExpirationOption.never
    ExpirationPicker(selected: $selected)
        .padding()
        .background(Color.appBackground)
}
