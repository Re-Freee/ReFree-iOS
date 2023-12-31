//
//  IngredientResponseDTO.swift
//  ReFree
//
//  Created by 이주훈 on 2023/08/01.
//

import Foundation


struct IngredientResponseDTO: Decodable {
    let code: Int
    let message: String
    let count: Int?
    let data: [IngredientDTO]?
    
    struct IngredientDTO: Decodable {
        let ingredientId: Int
        let name: String
        let period: String
        let imageURL: String
        let category: String?
        let savedMethod: Int?
        let count: Int?
        let memo: String?
        
        
        enum CodingKeys: String, CodingKey {
            case ingredientId = "id"
            case category = "category"
            case name = "name"
            case period = "period"
            case count = "quantity"
            case memo = "content"
            case savedMethod = "options"
            case imageURL = "image"
        }
    }
    
    func toDomain() -> (commonResponse: CommonResponse, ingredients: [Ingredient]) {
        guard let data else {
            return (CommonResponse(code: "\(code)", message: message), [])
        }
        
        return (
            CommonResponse(code: "\(code)", message: message),
            data.map {
                var savedMethod: String = ""
                switch $0.savedMethod {
                case 0: savedMethod = "실온"
                case 1: savedMethod = "냉장"
                case 2: savedMethod = "냉동"
                case 3: savedMethod = "기타"
                default: savedMethod = "기타"
                }
                
                let extractedExpr = Ingredient(
                    ingredientId: "\($0.ingredientId)",
                    imageURL: $0.imageURL,
                    saveMethod: savedMethod,
                    title: $0.name,
                    category: $0.category,
                    expireDate: $0.period,
                    count: $0.count,
                    memo: $0.memo ?? ""
                )
                return extractedExpr
            }
        )
    }
}
