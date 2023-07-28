//
//  NetworkError.swift
//  ReFree
//
//  Created by 이주훈 on 2023/07/28.
//

import Foundation

enum NetworkError: Error {
    case makeRequestError
}

extension NetworkError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .makeRequestError:
            return NSLocalizedString("URLRequest 생성 실패", comment: "")
        }
    }
}
