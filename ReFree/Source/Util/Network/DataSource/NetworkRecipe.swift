//
//  NetworkRecipe.swift
//  ReFree
//
//  Created by 이주훈 on 2023/07/28.
//

import Foundation

enum NetworkRecipe {
    case recommendRecipe([String])
}

extension NetworkRecipe: Target {
    var baseURL: String {
        return Network.server
    }
    
    var url: URLConvertible {
        switch self {
        case .recommendRecipe(let ingredients):
            let ingredientString = ingredients.joined(separator: ",")
            return setQuery(
                url: "\(baseURL)\(path)",
                query: [GetQuery("ingredients", ingredientString)]
            ).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .recommendRecipe:
            return .get
        }
    }
    
    var header: HTTPHeaders {
        switch self {
        case .recommendRecipe:
            return [ "Content-Type": "application/json" ] // TODO: Bearer Token 적용
        }
    }
    
    var path: String {
        switch self {
        case .recommendRecipe:
            return "/recipe/recommend"
        }
    }
    
    var parameters: Data? {
        switch self {
        case .recommendRecipe:
            return nil
        }
    }
    
    var encoding: ParameterEncoding {
        return JSONEncoding.default
    }
}
