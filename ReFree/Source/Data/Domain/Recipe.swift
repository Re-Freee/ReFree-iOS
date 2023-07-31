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
    let isHeart: Bool
    let manual: [Manual]?
}

struct Manual {
    let describe: String
    let imageURL: String
}
