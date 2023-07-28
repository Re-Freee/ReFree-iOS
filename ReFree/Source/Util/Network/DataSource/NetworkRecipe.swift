//
//  NetworkRecipe.swift
//  ReFree
//
//  Created by 이주훈 on 2023/07/28.
//

import Foundation

enum NetworkRecipe {
    case recommendRecipe(ingredients: [String])
    case searchRecipe(query: [RequestQuery]) // type=밥&title=샐러드
    case bookMark(recipeID: String) // String은 레시피 ID
    case detailRecipe(recipeID: String) // String은 레시피 ID
    case savedRecipe
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
                query: [RequestQuery("ingredients", ingredientString)]
            ).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        case .searchRecipe(let query):
            return setQuery(
                url: "\(baseURL)\(path)",
                query: query
            ).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        case .bookMark(let recipeID), .detailRecipe(let recipeID):
            return "\(baseURL)\(path)/\(recipeID)"
        case .savedRecipe:
            return "\(baseURL)\(path)"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .recommendRecipe, .searchRecipe, .detailRecipe, .savedRecipe:
            return .get
        case .bookMark:
            return .post
        }
    }
    
    var header: HTTPHeaders {
        switch self {
        case .recommendRecipe, .searchRecipe, .bookMark, .detailRecipe, .savedRecipe:
            return [ "Content-Type": "application/json" ] // TODO: Bearer Token 적용 필요   
        }
    }
    
    var path: String {
        switch self {
        case .recommendRecipe:
            return "/recipe/recommend"
        case .searchRecipe:
            return "/recipe/search"
        case .bookMark:
            return "/recipe/like"
        case .detailRecipe:
            return "/recipe/view"
        case .savedRecipe:
            return "/member/like"
        }
    }
    
    var parameters: Data? {
        switch self {
        case .recommendRecipe, .searchRecipe, .bookMark, .detailRecipe, .savedRecipe:
            return nil
        }
    }
    
    var encoding: ParameterEncoding {
        return JSONEncoding.default
    }
}
