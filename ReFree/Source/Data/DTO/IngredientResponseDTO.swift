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
    let data: [IngredientDTO]
    
    struct IngredientDTO: Decodable {
        let userId: Int
        let ingredientID: Int
        let savedMethod: Int
        let name: String
        let period: String
        let count: Int
        let memo: String
        let imageURL: String
        
        enum CodingKeys: String, CodingKey {
            case userId = "member_id"
            case ingredientID = "ingredient_id"
            case savedMethod = "options"
            case name = "name"
            case period = "period"
            case count = "quantity"
            case memo = "content"
            case imageURL = "image"
        }
    }
    
    func toDomain() -> [Ingredient] {
        return data.map {
            return Ingredient(
                saveMethod: "냉장", // TODO: API명세 누락으로 추후 변경
                title: $0.name,
                category: "\($0.ingredientID)", // TODO: ingredientID가 카테고리인지 모름
                expireDate: $0.period,
                count: $0.count,
                memo: $0.memo
            )
        }
    }
}
