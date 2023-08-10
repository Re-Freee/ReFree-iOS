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
        let calorie: Double?
        let isHeart: Int?
        let ingredient: String?
        let imageURL: String
        let manual: [ManualDTO]?
        
        enum CodingKeys: String, CodingKey {
            case id
            case name
            case calorie
            case isHeart
            case ingredient
            case imageURL = "image"
            case manual
        }
    }
    
    struct ManualDTO: Decodable {
        let describe: String
        let manualImageURL: String
        
        enum CodingKeys: String, CodingKey {
            case describe = "describe"
            case manualImageURL = "manualImage"
        }
        
        func toDomain() -> Manual {
            return Manual(
                describe: self.describe,
                imageURL: self.manualImageURL
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
                ingredients: recipeDTO.ingredient ?? "",
                imageURL: recipeDTO.imageURL,
                isHeart: recipeDTO.isHeart == 1 ? true : false,
                manual: recipeDTO.manual?.map{
                    $0.toDomain()
                }
            )
        }
    }
    
    func toDomainManual() -> [Manual] {
        guard let manualData = data?.first?.manual else { return [] }
        return manualData.map{ manualDTO in
            Manual(
                describe: manualDTO.describe,
                imageURL: manualDTO.manualImageURL
            )
        }
    }
}
