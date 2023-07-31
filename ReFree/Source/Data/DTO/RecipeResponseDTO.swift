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
    let count: Int?
    let data: [RecipeDTO]?
    
    struct RecipeDTO: Decodable {
        let id: Int
        let name: String
        let calorie: Double
        let ingredient: String
        let imageURL: String
        let manual: [ManualDTO]?
        
        enum CodingKeys: String, CodingKey {
            case id
            case name
            case calorie
            case ingredient
            case imageURL = "image"
            case manual
        }
    }
    
    struct ManualDTO: Decodable {
        let describe: String
        let manuelImageURL: String
        
        enum CodingKeys: String, CodingKey {
            case describe
            case manuelImageURL = "manuelImage"
        }
        
        func toDomain() -> Manual {
            return Manual(
                describe: self.describe,
                imageURL: self.manuelImageURL
            )
        }
    }
}

extension RecipeResponseDTO {
    func toDomain() -> [Recipe] {
        guard let data else { return [] }
        return data.map { recipeDTO in
            Recipe(
                id: "\(recipeDTO.id)",
                title: recipeDTO.name,
                ingredients: recipeDTO.ingredient,
                imageURL: recipeDTO.imageURL,
                isHeart: false,
                manual: recipeDTO.manual?.map{
                    $0.toDomain()
                }
            )
        }
    }
}
