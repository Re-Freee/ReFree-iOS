//
//  Network+Ingredient.swift
//  ReFree
//
//  Created by 이주훈 on 2023/08/01.
//

import Foundation
import RxSwift

protocol IngredientRepositoryProtocol {
    func request(closerIngredients: NetworkIngredient) -> Observable<[Ingredient]>
    func request(endIngredients: NetworkIngredient) -> Observable<[Ingredient]>
    func request(searchIngredients: NetworkIngredient) -> Observable<[Ingredient]>
    func request(detailIngredientt: NetworkIngredient) -> Observable<[Ingredient]>
    func request(saveIngredient: NetworkIngredient) -> Observable<CommonResponse>
    func request(modifyIngredient: NetworkIngredient) -> Observable<CommonResponse>
}

struct IngredientRepository: IngredientRepositoryProtocol {
    func request(closerIngredients: NetworkIngredient) -> Observable<[Ingredient]> {
        let observable: Observable<IngredientResponseDTO> = Network.requestJSON(target: closerIngredients)
        return observable.map { $0.toDomain() }
    }
    
    func request(endIngredients: NetworkIngredient) -> Observable<[Ingredient]> {
        let observable: Observable<IngredientResponseDTO> = Network.requestJSON(target: endIngredients)
        return observable.map { $0.toDomain() }
    }
    
    func request(searchIngredients: NetworkIngredient) -> Observable<[Ingredient]> {
        let observable: Observable<IngredientResponseDTO> = Network.requestJSON(target: searchIngredients)
        return observable.map { $0.toDomain() }
    }
    
    func request(detailIngredientt: NetworkIngredient) -> Observable<[Ingredient]> {
        let observable: Observable<IngredientResponseDTO> = Network.requestJSON(target: detailIngredientt)
        return observable.map { $0.toDomain() }
    }
    
    func request(saveIngredient: NetworkIngredient) -> Observable<CommonResponse> {
        let observable: Observable<CommonResponseDTO> = Network.requestJSON(target: saveIngredient)
        return observable.map { $0.toDomain() }
    }
    
    func request(modifyIngredient: NetworkIngredient) -> Observable<CommonResponse> {
        let observable: Observable<CommonResponseDTO> = Network.requestJSON(target: modifyIngredient)
        return observable.map { $0.toDomain() }
    }
}
