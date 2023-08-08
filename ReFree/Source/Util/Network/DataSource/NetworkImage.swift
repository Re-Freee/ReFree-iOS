//
//  NetworkImage.swift
//  ReFree
//
//  Created by 이주훈 on 2023/08/08.
//

import UIKit

enum NetworkImage {
    case saveIngredient(ingredient: Ingredient)
    case modifyIngredient(ingredient: Ingredient)
}

extension NetworkImage: ImageTarget {
    var baseURL: String {
        return Network.server
    }
    
    var url: URLConvertible {
        switch self {
        case .saveIngredient, .modifyIngredient:
            return "\(baseURL)\(path)"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .saveIngredient, .modifyIngredient:
            return .post
        }
    }
    
    var header: HTTPHeaders {
        switch self {
        case .saveIngredient, .modifyIngredient:
            guard let token = try? KeyChain.shared.searchToken(kind: .accessToken)
            else { return [] }
            return [
                "Content-Type": "multipart/form-data",
                "Authorization" : token
            ]
        }
    }
    
    var path: String {
        switch self {
        case .saveIngredient:
            return "/ingredient/create"
        case .modifyIngredient(let ingredient):
            guard let id = ingredient.ingredientId else {return ""}
            return "/ingredient/edit/\(id)"
        }
    }
    
    var parameters: [String : Any]? {
        switch self {
        case .saveIngredient(let ingredient), .modifyIngredient(let ingredient):
            guard
                let title = ingredient.title,
                let category = ingredient.category,
                let period = ingredient.expireDate,
                let quantity = ingredient.count,
                let options = ingredient.option
            else { return nil }
                    
            return [
                "name": title,
                 "category": category,
                "period" : period,
                 "quantity": quantity,
                 "content": ingredient.memo,
                 "options": options,
            ]
        }
    }
    
    var encoding: ParameterEncoding {
        return JSONEncoding.default
    }
    
    var imageData: [ImageData] {
        switch self {
        case .saveIngredient(let ingredient), .modifyIngredient(let ingredient):
            guard let image = ingredient.image else { return [] }
            return [
                ImageData(
                    image: image,
                    withName: "image",
                    fileName: "image.jpg"
                )
            ]
        }
    }
}
