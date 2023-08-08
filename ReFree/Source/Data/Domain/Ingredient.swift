//
//  Ingredient.swift
//  ReFree
//
//  Created by 이주훈 on 2023/07/26.
//

import UIKit

struct Ingredient {
    let ingredientId: String?
    let image: UIImage?
    let imageURL: String?
    let saveMethod: String?
    let title: String?
    let category: String?
    let expireDate: String?
    let count: Int?
    let memo: String
    
    init(
        ingredientId: String? = nil,
        image: UIImage? = UIImage(named: "ReFree_non"),
        imageURL: String? = nil,
        saveMethod: String? = nil,
        title: String? = nil,
        category: String? = nil,
        expireDate: String? = nil,
        count: Int? = nil,
        memo: String = ""
    ){
        self.ingredientId = ingredientId
        self.image = image
        self.imageURL = imageURL
        self.saveMethod = saveMethod
        self.title = title
        self.category = category
        self.expireDate = expireDate
        self.count = count
        self.memo = memo
    }
    
    var option: Int? {
        switch self.saveMethod {
        case "실온": return 0
        case "냉장": return 1
        case "냉동": return 2
        case "기타": return 3
        default: return nil
        }
    }
    
    func setImage(image: UIImage?) -> Ingredient {
        return Ingredient(
            image: image,
            imageURL: self.imageURL,
            saveMethod: self.saveMethod,
            title: self.title,
            category: self.category,
            expireDate: self.expireDate,
            count: self.count,
            memo: self.memo
        )
    }
    
    func setImageURL(imageURL: String?) -> Ingredient {
        return Ingredient(
            image: self.image,
            imageURL: imageURL,
            saveMethod: self.saveMethod,
            title: self.title,
            category: self.category,
            expireDate: self.expireDate,
            count: self.count,
            memo: self.memo
        )
    }
    
    func setSaveMethod(method: String?) -> Ingredient {
        return Ingredient(
            image: self.image,
            imageURL: self.imageURL,
            saveMethod: method,
            title: self.title,
            category: self.category,
            expireDate: self.expireDate,
            count: self.count,
            memo: self.memo
        )
    }
    
    func setTitle(title: String?) -> Ingredient {
        return Ingredient(
            image: self.image,
            imageURL: self.imageURL,
            saveMethod: self.saveMethod,
            title: title,
            category: self.category,
            expireDate: self.expireDate,
            count: self.count,
            memo: self.memo
        )
    }
    
    func setCategory(category: String?) -> Ingredient {
        return Ingredient(
            image: self.image,
            imageURL: self.imageURL,
            saveMethod: self.saveMethod,
            title: self.title,
            category: category,
            expireDate: self.expireDate,
            count: self.count,
            memo: self.memo
        )
    }
    
    func setExpireDate(date: String?) -> Ingredient {
        return Ingredient(
            image: self.image,
            imageURL: self.imageURL,
            saveMethod: self.saveMethod,
            title: self.title,
            category: self.category,
            expireDate: date,
            count: self.count,
            memo: self.memo
        )
    }
    
    func setCount(count: Int?) -> Ingredient {
        return Ingredient(
            image: self.image,
            imageURL: self.imageURL,
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
            image: self.image,
            imageURL: self.imageURL,
            saveMethod: self.saveMethod,
            title: self.title,
            category: self.category,
            expireDate: self.expireDate,
            count: self.count,
            memo: memo
        )
    }
    
    enum IngredientValidationMessage {
        static let savedMethodIsNil = "보관 방법을 채워주세요."
        static let titleIsNil = "이름을 채워주세요."
        static let categoryIsNil = "카테고리를 채워주세요."
        static let expireDateIsNil = "소비기한을 채워주세요."
        static let countIsNil = "수량을 채워주세요."
    }
    
    func isAllPropertiesFilled() -> String? {
        if saveMethod == nil {
            return IngredientValidationMessage.savedMethodIsNil
        } else if title == nil {
            return IngredientValidationMessage.titleIsNil
        } else if category == nil {
            return IngredientValidationMessage.categoryIsNil
        } else if expireDate == nil {
            return IngredientValidationMessage.expireDateIsNil
        } else if count == nil {
            return IngredientValidationMessage.countIsNil
        }
        
        return nil
    }
}

