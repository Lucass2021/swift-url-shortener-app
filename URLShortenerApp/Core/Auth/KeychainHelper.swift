import Foundation
import Security

enum KeychainHelper {
    private enum Key {
        static let accessToken = "com.urlshortener.accessToken"
        static let refreshToken = "com.urlshortener.refreshToken"
    }

    static func saveAccessToken(_ token: String) {
        save(token, forKey: Key.accessToken)
    }

    static func saveRefreshToken(_ token: String) {
        save(token, forKey: Key.refreshToken)
    }

    static func getAccessToken() -> String? {
        read(forKey: Key.accessToken)
    }

    static func getRefreshToken() -> String? {
        read(forKey: Key.refreshToken)
    }

    static func clearTokens() {
        delete(forKey: Key.accessToken)
        delete(forKey: Key.refreshToken)
    }

    private static func save(_ value: String, forKey key: String) {
        guard let data = value.data(using: .utf8) else { return }

        let query: [CFString: Any] = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: key
        ]

        let attributes: [CFString: Any] = [
            kSecValueData: data,
            kSecAttrAccessible: kSecAttrAccessibleAfterFirstUnlockThisDeviceOnly
        ]

        let status = SecItemUpdate(query as CFDictionary, attributes as CFDictionary)

        if status == errSecItemNotFound {
            var newItem = query
            newItem[kSecValueData] = data
            newItem[kSecAttrAccessible] = kSecAttrAccessibleAfterFirstUnlockThisDeviceOnly
            SecItemAdd(newItem as CFDictionary, nil)
        }
    }

    private static func read(forKey key: String) -> String? {
        let query: [CFString: Any] = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: key,
            kSecReturnData: true,
            kSecMatchLimit: kSecMatchLimitOne
        ]

        var result: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &result)

        guard status == errSecSuccess,
              let data = result as? Data,
              let string = String(data: data, encoding: .utf8)
        else { return nil }

        return string
    }

    private static func delete(forKey key: String) {
        let query: [CFString: Any] = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: key
        ]
        SecItemDelete(query as CFDictionary)
    }
}
