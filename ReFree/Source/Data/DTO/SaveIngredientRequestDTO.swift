//
//  SaveIngredientRequestDTO.swift
//  ReFree
//
//  Created by 이주훈 on 2023/07/28.
//

import Foundation

struct SaveIngredientRequestDTO {
    let name: String
    let period: String
    let quantity: Int
    let content: String
    let option: Int // 0은 실온, 1은 냉장, 2는 냉동이라고 함 (API 명세에)
}
