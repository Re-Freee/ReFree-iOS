//
//  Network.swift
//  ReFree
//
//  Created by 이주훈 on 2023/07/17.
//

import UIKit
import RxSwift
import Alamofire

struct Network {
    static func request<T: Decodable>(target: Target) -> Observable<T> {
        return Observable.create { emmiter in
            let request = AF.request(
                target.url,
                method: target.method,
                parameters: target.parameters,
                encoding: target.encoding,
                headers: target.header
            )
            .validate(statusCode: 200..<300)
            .responseDecodable(of: T.self) { response in
                switch response.result {
                case let .success(data):
                    print(data)
                case let .failure(error):
                    print(error)
                }
            }
            
            return Disposables.create {
                request.cancel()
            }
        }
    }
}
