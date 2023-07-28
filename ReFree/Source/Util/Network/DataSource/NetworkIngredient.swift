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
    case searchIngredients(searchKey: String)
    case detailIngredientt(ingredientID: String)
    case saveIngredient(ingredient: Ingredient)
    case modifyIngredient(ingredient: Ingredient) // TODO: 변경 가능성 있음
}

extension NetworkIngredient: Target {
    var baseURL: String {
        return Network.server
    }
    
    var url: URLConvertible {
        switch self {
        case .closerIngredients, .endIngredients, .saveIngredient:
            return "\(baseURL)\(path)"
        case .searchIngredients(let searchKey):
            return setQuery(
                url: "\(baseURL)\(path)",
                query: [RequestQuery("searchKey", searchKey)]
            ).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        case .detailIngredientt(let ingredientID):
            return setQuery(
                url: "\(baseURL)\(path)",
                query: [RequestQuery("ingredId", ingredientID)]
            ).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        case .modifyIngredient:
            return ""  // TODO: 보류
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .closerIngredients, .endIngredients,
                .searchIngredients, .detailIngredientt,
                .saveIngredient:
            return .get
        case .modifyIngredient:
            return .put
        }
    }
    
    var header: HTTPHeaders {
        switch self {
        case .closerIngredients, .endIngredients,
                .searchIngredients, .detailIngredientt,
                .saveIngredient:
            return [ "Content-Type": "application/json" ] // TODO: Bearer Token 적용 필요
        case .modifyIngredient:
            return [] // TODO: 보류
        }
    }
    
    var path: String {
        switch self {
        case .closerIngredients:
            return "/ingredient/closer"
        case .endIngredients:
            return "/ingredient/end"
        case .searchIngredients:
            return "/ingredient/search"
        case .detailIngredientt:
            return "/ingredient/view"
        case .saveIngredient:
            return "/ingredient/create"
        case .modifyIngredient:
            return ""  // TODO: 보류
        }
    }
    
    var parameters: Data? {
        return nil
    }
    
    var encoding: ParameterEncoding {
        return JSONEncoding.default
    }
}
