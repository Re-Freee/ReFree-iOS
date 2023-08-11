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
    func request(detailIngredient: NetworkIngredient) -> Observable<[Ingredient]>
    func request(saveIngredient: NetworkImage) -> Observable<CommonResponse>
    func request(modifyIngredient: NetworkImage) -> Observable<CommonResponse>
    func request(deleteIngredient: NetworkIngredient) -> Observable<CommonResponse>
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
    
    func request(detailIngredient: NetworkIngredient) -> Observable<[Ingredient]> {
        let observable: Observable<IngredientResponseDTO> = Network.requestJSON(target: detailIngredient)
        return observable.map { $0.toDomain() }
    }
    
    func request(saveIngredient: NetworkImage) -> Observable<CommonResponse> {
        let observable: Observable<CommonResponseDTO> = Network.imageUpload(target: saveIngredient)
        return observable.map { $0.toDomain() }
    }
    
    func request(modifyIngredient: NetworkImage) -> Observable<CommonResponse> {
        let observable: Observable<CommonResponseDTO> = Network.imageUpload(target: modifyIngredient)
        return observable.map { $0.toDomain() }
    }
    
    func request(deleteIngredient: NetworkIngredient) -> Observable<CommonResponse> {
        let observable: Observable<IngredientResponseDTO> = Network.requestJSON(target: deleteIngredient)
        return observable.map { $0.toDomain() }
    }
}
