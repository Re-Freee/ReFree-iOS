//
//  Network+Sign.swift
//  ReFree
//
//  Created by 이주훈 on 2023/08/01.
//

import Foundation
import RxSwift


protocol SignRepositoryProtocol {
    func request(signIn: NetworkSign)
    -> Observable<(response: CommonResponse, token: String)>
    
    func request(signUp: NetworkSign)
    -> Observable<(response: CommonResponse, backupCode: String)>
    
    func request(findPassword: NetworkSign)
    -> Observable<CommonResponse>
    
    func request(modifyPassword: NetworkSign)
    -> Observable<CommonResponse>
    
    func request(withdrawUser: NetworkSign)
    -> Observable<CommonResponse>
}

struct SignRepository: SignRepositoryProtocol {
    func request(signIn: NetworkSign) -> Observable<(response: CommonResponse, token: String)> {
        let observable: Observable<(response: CommonResponseDTO, headerString: String)> = Network.requestJSONHeader(target: signIn)
        return observable.map { ($0.response.toDomain(), $0.headerString) }
    }
    
    func request(signUp: NetworkSign) -> Observable<(response: CommonResponse, backupCode: String)> {
        let observable: Observable<(response: CommonResponseDTO, headerString: String)> = Network.requestJSONHeader(target: signUp)
        return observable.map { ($0.response.toDomain(), $0.headerString) } 
    }
    
    func request(findPassword: NetworkSign) -> Observable<CommonResponse> {
        let observable: Observable<CommonResponseDTO> = Network.requestJSON(target: findPassword)
        return observable.map { $0.toDomain() }
    }
    
    func request(modifyPassword: NetworkSign) -> Observable<CommonResponse> {
        let observable: Observable<CommonResponseDTO> = Network.requestJSON(target: modifyPassword)
        return observable.map { $0.toDomain() }
    }
    
    func request(withdrawUser: NetworkSign) -> Observable<CommonResponse> {
        let observable: Observable<CommonResponseDTO> = Network.requestJSON(target: withdrawUser)
        return observable.map { $0.toDomain() }
    }
}
