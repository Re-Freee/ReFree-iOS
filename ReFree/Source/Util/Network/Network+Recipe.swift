//
//  Network+Recipe.swift
//  ReFree
//
//  Created by 이주훈 on 2023/08/01.
//

import Foundation
import RxSwift

protocol NetworkRecipeProtocol {
    static func request(recommendRecipe: NetworkRecipe) -> Single<[Recipe]>
    static func request(searchRecipe: NetworkRecipe) -> Single<[Recipe]>
    static func request(bookMark: NetworkRecipe) -> Single<CommonResponse>
    static func request(detailRecipe: NetworkRecipe) -> Single<Recipe?>
    static func request(savedRecipe: NetworkRecipe) -> Single<[Recipe]>
}

extension Network: NetworkRecipeProtocol {
    static func request(recommendRecipe: NetworkRecipe) -> Single<[Recipe]> {
        let observable: Observable<RecipeResponseDTO> = Network.requestJSON(target: recommendRecipe)
        return observable.flatMap { Observable.of($0.toDomain()) }.asSingle()
    }
    
    static func request(searchRecipe: NetworkRecipe) -> Single<[Recipe]> {
            let observable: Observable<RecipeResponseDTO> = Network.requestJSON(target: searchRecipe)
            return observable.flatMap { Observable.of($0.toDomain()) }.asSingle()
    }
    
    static func request(bookMark: NetworkRecipe) -> Single<CommonResponse> {
        let observable: Observable<CommonResponseDTO> = Network.requestJSON(target: bookMark)
        return observable.flatMap { Observable.of($0.toDomain()) }.asSingle()
    }
    
    static func request(detailRecipe: NetworkRecipe) -> Single<Recipe?> {
        let observable: Observable<RecipeResponseDTO> = Network.requestJSON(target: detailRecipe)
        return observable.flatMap { Observable.of($0.toDomain().first) }.asSingle()
    }
    
    static func request(savedRecipe: NetworkRecipe) -> Single<[Recipe]> {
        let observable: Observable<RecipeResponseDTO> = Network.requestJSON(target: savedRecipe)
        return observable.flatMap { Observable.of($0.toDomain()) }.asSingle()
    }
}
