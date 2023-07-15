//
//  KeyChain.swift
//  ReFree
//
//  Created by 이주훈 on 2023/07/15.
//

import Foundation

struct KeyChain {
    struct AccessToken {
        let token: String
    }
    
    enum KeyChainError: Error {
        case encodingFailed
    }
    
    static let shared = KeyChain()
    
    private init() {}
    
    func addToken(accessToken: KeyChain.AccessToken) throws {
        guard let token = accessToken.token.data(using: .utf8) else { throw KeyChainError.encodingFailed}
        var query: [String: Any] = [
            kSecClass as String: kSecClassCertificate,
//            kSecAttrServer as String: ReFreeServer,
            kSecValueData as String: token
        ]
    }
}
