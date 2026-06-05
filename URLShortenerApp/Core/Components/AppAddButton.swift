import SwiftUI

struct AppAddButton: View {
    var body: some View {
        Button {
            print("AppAddButton tapped")
        } label: {
            Image(systemName: "plus")
                .font(.title2.bold())
                .foregroundStyle(.white)
                .frame(width: 56, height: 56)
                .background(Color.appPrimary)
                .clipShape(Circle())
                .shadow(color: Color.appPrimary.opacity(0.4), radius: 8, x: 0, y: 4)
        }
    }
}
