//
//  RecipeDTO.swift
//  ReFree
//
//  Created by 이주훈 on 2023/07/28.
//

import Foundation

struct RecipeDTO: Codable {
    let id: Int
    let name: String
    let calorie: Double
    let ingredient: String
    let imageURL: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case calorie
        case ingredient
        case imageURL = "image"
    }
}
