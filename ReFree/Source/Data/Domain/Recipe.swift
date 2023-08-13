//
//  Recipe.swift
//  ReFree
//
//  Created by 이주훈 on 2023/07/26.
//

import Foundation

struct Recipe {
    let id: String
    let title: String
    let ingredients: String
    let imageURL: String
    var isHeart: Bool
    let manual: [Manual]?
    
    func setIsHeart(_ isHeart: Bool) -> Recipe {
        return Recipe(
            id: id,
            title: title,
            ingredients: ingredients,
            imageURL: imageURL,
            isHeart: isHeart,
            manual: manual
        )
    }
}

struct Manual {
    let describe: String
    let imageURL: String
}
