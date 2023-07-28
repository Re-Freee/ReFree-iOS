//
//  RecommendRecipeDTO.swift
//  ReFree
//
//  Created by 이주훈 on 2023/07/28.
//

import Foundation

struct RecommendRecipeDTO: Codable {
    let code: Int
    let message: String
    let count: Int
    let data: [RecipeDTO]
}

extension RecommendRecipeDTO {
    func toDomain() -> [Recipe] {
        return data.map { recipeDTO in
            Recipe(
                title: recipeDTO.name,
                ingredients: recipeDTO.ingredient,
                imageURL: recipeDTO.imageURL,
                isHeart: false // TODO: 추천 레시피에선 사용하지 않음
            )
        }
    }
}
