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
    private enum InfoKey {
        static let server = "REFREE_SERVER_DOMAIN"
    }
    
    private static let infoDictionary: [String: Any] = {
        guard let dict = Bundle.main.infoDictionary else {
            fatalError("info.plist가 없는데용?")
        }
        return dict
    }()
    
    static let server: String = {
        guard let domain =  infoDictionary[InfoKey.server] as? String
        else { fatalError("Error: Info.plist 또는 xcconfig 서버 도메인 설정 확인 필요")}
        
        return domain
    }()
    
    static func requestJSON<T: Decodable>(target: Target) -> Observable<T> {
        return Observable.create { emitter in
            guard var request = try? URLRequest(
                url: target.url,
                method: target.method,
                headers: target.header
            ) else {
                emitter.onError(NetworkError.makeRequestError)
                return Disposables.create()
            }
            
            request.httpBody = target.parameters
            
            let task = AF.request(request)
                .validate(statusCode: 200..<300)
                .responseDecodable(of: T.self) { response in
                    switch response.result {
                    case let .success(data):
                        emitter.onNext(data)
                    case let .failure(error):
                        emitter.onError(error)
                    }
                }
            
            return Disposables.create {
                task.cancel()
            }
        }
    }
    
    static func requestCompletion<T: Decodable>(
        type: T.Type,
        target: Target,
        completion: @escaping (DataResponse<T, AFError>
        ) -> ()
    ) {
        guard var request = try? URLRequest(
            url: target.url,
            method: target.method,
            headers: target.header
        ) else { return }
        
        request.httpBody = target.parameters
        
        AF.request(request)
            .validate(statusCode: 200..<300)
            .responseDecodable(of: T.self, completionHandler: completion)
    }
    
    static func imageUpload<T: Decodable>(target: ImageTarget) -> Single<T> {
        return Single.create { single in

            let task = AF.upload(
                multipartFormData: { multipart in
                    target.parameters?.forEach{ (key: String, value: Any) in
                        if
                            let str = value as? String,
                            let data = str.data(using: .utf8)
                        { multipart.append(data , withName: key) }
                        else if
                            let int = value as? Int,
                            let data = String(int).data(using: .utf8)
                        { multipart.append(data , withName: key) }
                    }
                    
                    target.imageData.forEach { data in
                        guard
                            let imageData = data
                            .image
                            .jpegData(compressionQuality: 1)
                        else { return }
                        
                        multipart.append(
                            imageData,
                            withName: data.withName,
                            fileName: data.fileName,
                            mimeType: data.mimeType
                        )
                    }
                    
                },
                to: target.url,
                method: target.method,
                headers: target.header
            )
                .validate(statusCode: 200..<300)
                .responseDecodable(of: T.self) { response in
                    switch response.result {
                    case let .success(data):
                        single(.success(data))
                    case let .failure(error):
                        single(.failure(error))
                    }
                }
            
            return Disposables.create { task.cancel() }
        }
    }
}
