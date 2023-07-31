//
//  Ingredient.swift
//  ReFree
//
//  Created by 이주훈 on 2023/07/26.
//

import Foundation

struct Ingredient {
    let saveMethod: String?
    let title: String?
    let category: String?
    let expireDate: String?
    let count: Int?
    let memo: String?
    
    init(
        saveMethod: String? = nil,
        title: String? = nil,
        category: String? = nil,
        expireDate: String? = nil,
        count: Int? = nil,
        memo: String? = nil
    ){
        self.saveMethod = saveMethod
        self.title = title
        self.category = category
        self.expireDate = expireDate
        self.count = count
        self.memo = memo
    }
    
    func saveMethod(method: String) -> Ingredient {
        return Ingredient(
            saveMethod: method,
            title: self.title,
            category: self.category,
            expireDate: self.expireDate,
            count: self.count,
            memo: self.memo
        )
    }
    
    func setTitle(title: String) -> Ingredient {
        return Ingredient(
            saveMethod: self.saveMethod,
            title: title,
            category: self.category,
            expireDate: self.expireDate,
            count: self.count,
            memo: self.memo
        )
    }
    
    func setCategory(category: String) -> Ingredient {
        return Ingredient(
            saveMethod: self.saveMethod,
            title: self.title,
            category: category,
            expireDate: self.expireDate,
            count: self.count,
            memo: self.memo
        )
    }
    
    func expireDate(date: String) -> Ingredient {
        return Ingredient(
            saveMethod: self.saveMethod,
            title: self.title,
            category: self.category,
            expireDate: date,
            count: self.count,
            memo: self.memo
        )
    }
    
    func setCount(count: Int) -> Ingredient {
        return Ingredient(
            saveMethod: self.saveMethod,
            title: self.title,
            category: self.category,
            expireDate: self.expireDate,
            count: count,
            memo: self.memo
        )
    }
    
    func setMemo(memo: String) -> Ingredient {
        return Ingredient(
            saveMethod: self.saveMethod,
            title: self.title,
            category: self.category,
            expireDate: self.expireDate,
            count: self.count,
            memo: memo
        )
    }
}
