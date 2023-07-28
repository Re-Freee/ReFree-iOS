//
//  NetworkSign.swift
//  ReFree
//
//  Created by 이주훈 on 2023/07/28.
//

import Foundation

enum NetworkSign {
    case signIn(id: String, password: String)
    case signUp(signUpData: SignUpData)
    case findPassword(email: String)
    case modifyPassword(password: String, checkPassword: String)
}

struct SignUpData {
    let email: String
    let password: String
    let checkPassword: String
    let nickName: String
}

extension NetworkSign: Target {
    var baseURL: String {
        return Network.server
    }
    
    var url: URLConvertible {
        return "\(baseURL)\(path)"
    }
    
    var method: HTTPMethod {
        switch self {
        case .signIn, .signUp, .findPassword, .modifyPassword:
            return .post
        }
    }
    
    var header: HTTPHeaders {
        return [ "Content-Type": "application/json" ]
    }
    
    var path: String {
        switch self {
        case .signIn:
            return "/login"
        case .signUp:
            return "/signup"
        case .findPassword:
            return "/login/search"
        case .modifyPassword:
            return "/login/search/modify"
        }
    }
    
    var parameters: Data? {
        switch self {
        case .signIn(let id, let password):
            return try? JSONEncoder().encode(SignInRequestDTO(email: id, password: password))
        case .signUp(let signUpData):
            let signUpDTO = SignUpRequestDTO(
                email: signUpData.email,
                password: signUpData.password,
                checkPassword: signUpData.checkPassword,
                nickname: signUpData.nickName
            )
            return try? JSONEncoder().encode(signUpDTO)
        case .findPassword(let email):
            return try? JSONEncoder().encode(FindPasswordRequestDTO(email: email))
        case .modifyPassword(let password, let checkPassword):
            return try? JSONEncoder().encode(
                ModifyPasswordRequestDTO(
                    password: password,
                    checkPassword: checkPassword
                )
            )
        }
    }
    
    var encoding: ParameterEncoding {
        return JSONEncoding.default
    }
}
