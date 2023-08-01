//
//  Network+Recipe.swift
//  ReFree
//
//  Created by 이주훈 on 2023/08/01.
//

import Foundation
import RxSwift

protocol NetworkRecipeProtocol {
    static func request(recommendRecipe: NetworkRecipe) -> Observable<[Recipe]>
    static func request(searchRecipe: NetworkRecipe) -> Observable<[Recipe]>
    static func request(bookMark: NetworkRecipe) -> Observable<CommonResponse>
    static func request(detailRecipe: NetworkRecipe) -> Observable<Recipe?>
    static func request(savedRecipe: NetworkRecipe) -> Observable<[Recipe]>
}

extension Network: NetworkRecipeProtocol {
    static func request(recommendRecipe: NetworkRecipe) -> Observable<[Recipe]> {
        let observable: Observable<RecipeResponseDTO> = Network.requestJSON(target: recommendRecipe)
        return observable.map { $0.toDomain() }
    }
    
    static func request(searchRecipe: NetworkRecipe) -> Observable<[Recipe]> {
        let observable: Observable<RecipeResponseDTO> = Network.requestJSON(target: searchRecipe)
        return observable.map { $0.toDomain() }
    }
    
    static func request(bookMark: NetworkRecipe) -> Observable<CommonResponse> {
        let observable: Observable<CommonResponseDTO> = Network.requestJSON(target: bookMark)
        return observable.map { $0.toDomain() }
    }
    
    static func request(detailRecipe: NetworkRecipe) -> Observable<Recipe?> {
        let observable: Observable<RecipeResponseDTO> = Network.requestJSON(target: detailRecipe)
        return observable.map { $0.toDomain().first }
    }
    
    static func request(savedRecipe: NetworkRecipe) -> Observable<[Recipe]> {
        let observable: Observable<RecipeResponseDTO> = Network.requestJSON(target: savedRecipe)
        return observable.map { $0.toDomain() }
    }
}
