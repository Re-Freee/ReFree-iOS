//
//  KeyChain.swift
//  ReFree
//
//  Created by 이주훈 on 2023/07/15.
//

import Foundation

enum KeyChainError: Error {
    case encodingFailed
    case decodingFailed
    case notFound
    case unhandledError(status: OSStatus)
}

struct KeyChain {
    static let shared = KeyChain()
    
    enum TokenKind: String {
        case accessToken = "accessToken"
        case refreshToken = "refreshToken"
    }
    
    private init() {}
    
    func addToken(kind: KeyChain.TokenKind, token: String) throws {
        guard let saveToken = token.data(using: .utf8) else { throw KeyChainError.encodingFailed }
        
        let query: [String: Any] = [
            kSecClass as String: kSecClassInternetPassword,
            kSecAttrType as String : kind.rawValue,
            kSecAttrServer as String: Network.server,
            kSecValueData as String: saveToken
        ]
        
        let status = SecItemAdd(query as CFDictionary, nil)
        guard status == errSecSuccess else { throw KeyChainError.unhandledError(status: status)}
    }
    
    func searchToken(kind: KeyChain.TokenKind) throws -> String {
        let query: [String: Any] = [
            kSecClass as String: kSecClassInternetPassword,
            kSecAttrType as String : kind.rawValue,
            kSecAttrServer as String: Network.server,
            kSecMatchLimit as String: kSecMatchLimitOne,
            kSecReturnAttributes as String: true,
            kSecReturnData as String: true
        ]
        
        var item: CFTypeRef?
        let status = SecItemCopyMatching(query as CFDictionary, &item)
        guard status != errSecItemNotFound else { throw KeyChainError.notFound }
        guard status == errSecSuccess else { throw KeyChainError.unhandledError(status: status) }
        
        guard
            let existingItem = item as? [String : Any],
            let savedToken = existingItem[kSecValueData as String] as? Data,
            let tokenString = String(data: savedToken, encoding: .utf8)
        else {
            throw KeyChainError.decodingFailed
        }
        
        return tokenString
    }
    
    func updateToken(kind: KeyChain.TokenKind, newToken: String) throws {
        guard let token = newToken.data(using: .utf8) else { throw KeyChainError.encodingFailed }
        
        let query: [String: Any] = [
            kSecClass as String: kSecClassInternetPassword,
            kSecAttrType as String : kind.rawValue,
            kSecAttrServer as String: Network.server
        ]
        
        let attributes: [String: Any] = [
            kSecValueData as String: token
        ]
        
        let status = SecItemUpdate(query as CFDictionary, attributes as CFDictionary)
        guard status != errSecItemNotFound else { throw KeyChainError.notFound }
        guard status == errSecSuccess else { throw  KeyChainError.unhandledError(status: status) }
    }
    
    func deleteToken(kind: KeyChain.TokenKind) throws {
        let query: [String: Any] = [
            kSecClass as String: kSecClassInternetPassword,
            kSecAttrType as String : kind.rawValue,
            kSecAttrServer as String: Network.server
        ]
        
        let status = SecItemDelete(query as CFDictionary)
        guard status == errSecSuccess || status == errSecItemNotFound else { throw KeyChainError.unhandledError(status: status) }
    }
}

extension KeyChainError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .decodingFailed:
            return NSLocalizedString("토큰 디코딩 에러", comment: "")
        case .encodingFailed:
            return NSLocalizedString("토큰 인코딩 에러", comment: "")
        case .notFound:
            return NSLocalizedString("토큰을 찾을 수 없습니다.", comment: "")
        case .unhandledError(let status):
            return NSLocalizedString("예상치 못한 에러: \(status)", comment: "")
        }
    }
}
