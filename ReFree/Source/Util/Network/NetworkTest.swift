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
    case get([GetQuery])
    case post(TestStruct)
}

extension NetTest: Target {
    var baseURL: String {
        return Network.server
    }
    
    var url: URLConvertible {
        switch self {
        case .get(let query):
            return setQuery(url: "\(baseURL)\(path)?", query: query)
        case .post:
            return "\(baseURL)\(path)"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .post:
            return .post
        case .get:
            return .get
        }
    }
    
    var header: HTTPHeaders {
        // TODO: 실제는 토큰 추가
        return [
            "Content-Type": "application/json"
        ]
    }
    
    var path: String {
        switch self {
        case .get:
            return "/getTest"
        case .post:
            return "/postTest"
        }
    }
    
    var parameters: Data? {
        switch self {
        case .get:
            return nil
        case .post(let params):
            return try? JSONEncoder().encode(params)
        }
    }
    
    var encoding: ParameterEncoding {
        return JSONEncoding.default
    }
    
    var images: [UIImage] {
        switch self {
        case .get:
            return []
        case .post:
            return []
        }
    }
}
