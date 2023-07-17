//
//  NetworkTest.swift
//  ReFree
//
//  Created by 이주훈 on 2023/07/17.
//

import UIKit

struct TestStruct: Codable {
    let test: String
}

enum NetTest {
    case post(TestStruct)
}

extension NetTest: Target {
    var baseURL: String {
        return Network.server
    }
    
    var url: URLConvertible {
        switch self {
        case .post:
            return "\(baseURL)\(path)"
        }
    }
    
    var method: HTTPMethod {
        return .post
    }
    
    var header: HTTPHeaders {
        return [
            "Content-Type": "application/json"
        ]
    }
    
    var path: String {
        switch self {
        case .post:
            return "/postTest"
        }
    }
    
    var parameters: Data? {
        switch self {
        case let .post(params):
            return try? JSONEncoder().encode(params)
        }
    }
    
    var encoding: ParameterEncoding {
        return JSONEncoding.default
    }
    
    var images: [UIImage] {
        switch self {
        case .post:
            return []
        }
    }
}
