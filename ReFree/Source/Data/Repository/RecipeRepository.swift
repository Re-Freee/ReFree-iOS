//
//  Network+Recipe.swift
//  ReFree
//
//  Created by 이주훈 on 2023/08/01.
//

import Foundation
import RxSwift

protocol RecipeRepositoryProtocol {
    func request(recommendRecipe: NetworkRecipe)
    -> Observable<(commonResponse: CommonResponse, recipes: [Recipe])>
    
    func request(searchRecipe: NetworkRecipe)
    -> Observable<(commonResponse: CommonResponse, recipes: [Recipe])>
    
    func request(bookMark: NetworkRecipe)
    -> Observable<CommonResponse>
    
    func request(detailRecipe: NetworkRecipe)
    -> Observable<(commonResponse: CommonResponse, manuals: [Manual])>
    
    func request(savedRecipe: NetworkRecipe)
    -> Observable<(commonResponse: CommonResponse, recipes: [Recipe])>
}

struct RecipeRepository: RecipeRepositoryProtocol {
    func request(recommendRecipe: NetworkRecipe)
    -> Observable<(commonResponse: CommonResponse, recipes: [Recipe])> {
        let observable: Observable<RecipeResponseDTO> = Network.requestJSON(target: recommendRecipe)
        return observable.map { $0.toDomain() }
    }
    
    func request(searchRecipe: NetworkRecipe)
    -> Observable<(commonResponse: CommonResponse, recipes: [Recipe])> {
        let observable: Observable<RecipeResponseDTO> = Network.requestJSON(target: searchRecipe)
        return observable.map { $0.toDomain() }
    }
    
    func request(bookMark: NetworkRecipe) -> Observable<CommonResponse> {
        let observable: Observable<CommonResponseDTO> = Network.requestJSON(target: bookMark)
        return observable.map { $0.toDomain() }
    }
    
    func request(detailRecipe: NetworkRecipe)
    -> Observable<(commonResponse: CommonResponse, manuals: [Manual])> {
        let observable: Observable<RecipeResponseDTO> = Network.requestJSON(target: detailRecipe)
        return observable.map { $0.toDomainManual() }
    }
    
    func request(savedRecipe: NetworkRecipe)
    -> Observable<(commonResponse: CommonResponse, recipes: [Recipe])> {
        let observable: Observable<RecipeResponseDTO> = Network.requestJSON(target: savedRecipe)
        return observable.map { $0.toDomain() }
    }
}
