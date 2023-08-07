//
//  MockupData.swift
//  ReFree
//
//  Created by 이주훈 on 2023/08/01.
//

import UIKit

struct Mockup {
    static let ingredients: [Ingredient] = {
        return (0..<30).map { _ in
            return Ingredient(
                image: UIImage(named: "RefreeLogo"),
                imageURL: nil,
                saveMethod: "냉장",
                title: "돼지고기",
                category: "돼지고기",
                expireDate: "2023-08-02",
                count: 2,
                memo: "메모메모"
            )
        }
    }()
    
    static let testIngredients1: [Ingredient] = {
        return (0..<20).map { _ in
            return Ingredient(
                image: UIImage(named: "RefreeLogo"),
                imageURL: nil,
                saveMethod: "냉장",
                title: "돼지고기",
                category: "돼지고기",
                expireDate: "2023-08-02",
                count: 2,
                memo: "메모메모"
            )
        }
    }()
    
    static let testIngredients2: [Ingredient] = {
        return (0..<10).map { _ in
            return Ingredient(
                image: UIImage(named: "RefreeLogo"),
                imageURL: nil,
                saveMethod: "냉동",
                title: "소고기",
                category: "소고기",
                expireDate: "2023-08-031",
                count: 4,
                memo: "메모메모"
            )
        }
    }()
    
    static let recommendReciple: [Recipe] = {
        return (0..<3).map { _ in
            return Recipe(
                id: "0",
                title: "맛있는 코드",
                ingredients: "Xcode, Swift, Developer",
                imageURL: "RefreeLogo",
                isHeart: true,
                manual: nil
            )
        }
    }()
    
    static let savedRecipe: [Recipe] = {
        return (0..<30).map { _ in
            return Recipe(
                id: "0",
                title: "맛있는 코드",
                ingredients: "Xcode, Swift, Developer",
                imageURL: "RefreeLogo",
                isHeart: true,
                manual: nil
            )
        }
    }()
    
    static let detailRecipe: [Manual] = {
        return (0..<15).map { _ in
            return Manual(
                describe: "요리를 망치는 방법 중 세 가지를 설명하려 한다.\n 이것만 피해도 반은 갈 수 있다..\n 첫 번째는 레시피에서 대충 비슷한 재료를 쓰는 것이고\n 두 번째는 양을 무시한 채 마음대로 넣는 것이다.\n 마지막 세 번째는 불조절을 무시한 채 만드는 것이다. 레시피를 잘 따라서 만들도록 하자",
                imageURL: "RefreeLogo"
            )
        }
    }()
}
