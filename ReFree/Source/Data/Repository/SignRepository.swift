//
//  Network+Sign.swift
//  ReFree
//
//  Created by 이주훈 on 2023/08/01.
//

import Foundation
import RxSwift


protocol SignRepositoryProtocol {
    func request(signIn: NetworkSign) -> Observable<CommonResponse> // TODO: 헤더 접근 수정 필요
    func request(signUp: NetworkSign) -> Observable<CommonResponse>
    func request(findPassword: NetworkSign) -> Observable<CommonResponse>
    func request(modifyPassword: NetworkSign) -> Observable<CommonResponse>
}

struct SignRepository: SignRepositoryProtocol {
    func request(signIn: NetworkSign) -> Observable<CommonResponse> {
        let observable: Observable<CommonResponseDTO> = Network.requestJSON(target: signIn)
        return observable.map { $0.toDomain() }
    }
    
    func request(signUp: NetworkSign) -> Observable<CommonResponse> {
        let observable: Observable<CommonResponseDTO> = Network.requestJSON(target: signUp)
        return observable.map { $0.toDomain() }
    }
    
    func request(findPassword: NetworkSign) -> Observable<CommonResponse> {
        let observable: Observable<CommonResponseDTO> = Network.requestJSON(target: findPassword)
        return observable.map { $0.toDomain() }
    }
    
    func request(modifyPassword: NetworkSign) -> Observable<CommonResponse> {
        let observable: Observable<CommonResponseDTO> = Network.requestJSON(target: modifyPassword)
        return observable.map { $0.toDomain() }
    }
}
