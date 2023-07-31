//
//  Ingredient.swift
//  ReFree
//
//  Created by 이주훈 on 2023/07/26.
//

import Foundation

struct Ingredient {
    let title: String?
    let category: String?
    let expireDate: String?
    let count: Int?
    let memo: String?
    
    init(
        title: String? = nil,
        category: String? = nil,
        expireDate: String? = nil,
        count: Int? = nil,
        memo: String? = nil
    ){
        self.title = title
        self.category = category
        self.expireDate = expireDate
        self.count = count
        self.memo = memo
    }
    
    func setTitle(title: String) -> Ingredient {
        return self
    }
    
    func setCategory(category: String) -> Ingredient {
        return self
    }
    
    func expireDate(date: String) -> Ingredient {
        return self
    }
    
    func setCount(count: Int) -> Ingredient {
        return self
    }
    
    func setMemo(memo: String) -> Ingredient {
        return self
    }
}
