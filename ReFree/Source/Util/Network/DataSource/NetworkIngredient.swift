//
//  NetworkIngredient.swift
//  ReFree
//
//  Created by 이주훈 on 2023/07/28.
//

import Foundation

enum NetworkIngredient {
    case closerIngredients
    case endIngredients
    case searchIngredients(options: SearchIngredientOption? = nil, searchKey: String)
    case detailIngredient(ingredientId: String)
    case deleteIngredient(ingredientId: String)
    
    enum SearchIngredientOption: String {
        case outdoor = "0"
        case refrigerd = "1"
        case frozen = "2"
    }
}

extension NetworkIngredient: Target {
    var baseURL: String {
        return Network.server
    }
    
    var url: URLConvertible {
        switch self {
        case .closerIngredients, .endIngredients:
            return "\(baseURL)\(path)"
        case .searchIngredients(let options, let searchKey):
            if let options {
                return setQuery(
                    url: "\(baseURL)\(path)",
                    query: [
                        RequestQuery("options", options),
                        RequestQuery("searchKey", searchKey)
                    ]
                ).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
            }
            return setQuery(
                url: "\(baseURL)\(path)",
                query: [RequestQuery("searchKey", searchKey)]
            ).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        case .detailIngredient(let ingredientId), .deleteIngredient(let ingredientId):
            return setQuery(
                url: "\(baseURL)\(path)",
                query: [RequestQuery("ingredientId", ingredientId)]
            ).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        }
    }
    var method: HTTPMethod {
        switch self {
        case .closerIngredients, .endIngredients,
                .searchIngredients, .detailIngredient:
            return .get
        case .deleteIngredient:
            return .delete
        }
    }
    
    var header: HTTPHeaders {
        switch self {
        case .closerIngredients, .endIngredients,
                .searchIngredients, .detailIngredient,
                .deleteIngredient:
            guard let token = try? KeyChain.shared.searchToken(kind: .accessToken)
            else { return [] }
            
            return [
                "Content-Type": "application/json",
                "Authorization" : token
            ]
        }
    }
    
    var path: String {
        switch self {
        case .closerIngredients:
            return "/ingredient/imminent"
        case .endIngredients:
            return "/ingredient/end"
        case .searchIngredients:
            return "/ingredient/search"
        case .detailIngredient:
            return "/ingredient/view"
        case .deleteIngredient:
            return "/ingredient/delete"
        }
    }
    
    var parameters: Data? {
        return nil
    }
    
    var encoding: ParameterEncoding {
        return JSONEncoding.default
    }
}
