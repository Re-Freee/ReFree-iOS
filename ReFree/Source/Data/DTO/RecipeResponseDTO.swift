//
//  RecipeResponseDTO.swift
//  ReFree
//
//  Created by 이주훈 on 2023/07/28.
//

import Foundation

struct RecipeResponseDTO: Decodable {
    let code: Int
    let message: String
    let count: Int
    let data: [RecipeDTO]
    
    struct RecipeDTO: Decodable {
        let id: Int
        let name: String
        let calorie: Double
        let ingredient: String
        let imageURL: String
        let manual: [Manual]?
        
        enum CodingKeys: String, CodingKey {
            case id
            case name
            case calorie
            case ingredient
            case imageURL = "image"
            case manual
        }
    }
    
    struct Manual: Decodable {
        let describe: String
        let manuelImageURL: String
        
        enum CodingKeys: String, CodingKey {
            case describe
            case manuelImageURL = "manuelImage"
        }
    }
}

extension RecipeResponseDTO {
    func toDomain() -> [Recipe] {
        return data.map { recipeDTO in
            Recipe(
                id: "\(recipeDTO.id)",
                title: recipeDTO.name,
                ingredients: recipeDTO.ingredient,
                imageURL: recipeDTO.imageURL,
                isHeart: false // TODO: 추천 레시피에선 사용하지 않음
            )
        }
    }
}
