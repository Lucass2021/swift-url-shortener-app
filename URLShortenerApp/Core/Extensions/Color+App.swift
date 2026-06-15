import SwiftUI

extension Color {
    static let appBackground = Color(hex: "000000")
    static let appBackgroundApp = Color(hex: "0d0d1f")
    static let appSurfaceCard = Color(hex: "0d1c2d")
    static let appSurface = Color(hex: "1c1c1e")
    static let appSurfaceHigh = Color(hex: "2c2c2e")
    static let appOutline = Color(hex: "38383a")
    static let appPrimary = Color(hex: "6366f1")
    static let appAccent = Color(hex: "c0c1ff")
    static let appTertiary = Color(hex: "F9B985")
    static let appTextPrimary = Color.white
    static let appTextSecondary = Color(hex: "8e8e93")
    static let appDestructive = Color(hex: "b50036")
    static let appSuccess = Color(hex: "30d158")
}

extension Color {
    init(hex: String) {
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        self.init(
            .sRGB,
            red: Double((int >> 16) & 0xFF) / 255,
            green: Double((int >> 8) & 0xFF) / 255,
            blue: Double(int & 0xFF) / 255,
            opacity: 1
        )
    }
}
