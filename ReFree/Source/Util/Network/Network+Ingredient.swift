//
//  Network+Ingredient.swift
//  ReFree
//
//  Created by 이주훈 on 2023/08/01.
//

import Foundation
import RxSwift

protocol NetworkIngredientProtocol {
    static func request(closerIngredients: NetworkIngredient) -> Observable<[Ingredient]>
    static func request(endIngredients: NetworkIngredient) -> Observable<[Ingredient]>
    static func request(searchIngredients: NetworkIngredient) -> Observable<[Ingredient]>
    static func request(detailIngredientt: NetworkIngredient) -> Observable<[Ingredient]>
    static func request(saveIngredient: NetworkIngredient) -> Observable<CommonResponse>
    static func request(modifyIngredient: NetworkIngredient) -> Observable<CommonResponse>
}

extension Network: NetworkIngredientProtocol {
    static func request(closerIngredients: NetworkIngredient) -> Observable<[Ingredient]> {
        let observable: Observable<IngredientResponseDTO> = Network.requestJSON(target: closerIngredients)
        return observable.map { $0.toDomain() }
    }
    
    static func request(endIngredients: NetworkIngredient) -> Observable<[Ingredient]> {
        let observable: Observable<IngredientResponseDTO> = Network.requestJSON(target: endIngredients)
        return observable.map { $0.toDomain() }
    }
    
    static func request(searchIngredients: NetworkIngredient) -> Observable<[Ingredient]> {
        let observable: Observable<IngredientResponseDTO> = Network.requestJSON(target: searchIngredients)
        return observable.map { $0.toDomain() }
    }
    
    static func request(detailIngredientt: NetworkIngredient) -> Observable<[Ingredient]> {
        let observable: Observable<IngredientResponseDTO> = Network.requestJSON(target: detailIngredientt)
        return observable.map { $0.toDomain() }
    }
    
    static func request(saveIngredient: NetworkIngredient) -> Observable<CommonResponse> {
        let observable: Observable<CommonResponseDTO> = Network.requestJSON(target: saveIngredient)
        return observable.map { $0.toDomain() }
    }
    
    static func request(modifyIngredient: NetworkIngredient) -> Observable<CommonResponse> {
        let observable: Observable<CommonResponseDTO> = Network.requestJSON(target: modifyIngredient)
        return observable.map { $0.toDomain() }
    }
}
