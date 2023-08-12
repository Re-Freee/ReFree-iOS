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
    case findPassword(email: String, certification: String)
    case modifyPassword(email: String, password: String, checkPassword: String)
    case withDraw
    case userNickName
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
        case .userNickName:
            return .get
        case .signIn, .signUp, .findPassword, .modifyPassword:
            return .post
        case .withDraw:
            return .delete
        }
    }
    
    var header: HTTPHeaders {
        switch self {
        case .userNickName:
            guard
                let token = try? KeyChain.shared.searchToken(kind: .accessToken)
            else { return [] }
            return [
                "Content-Type": "application/json",
                "Authorization" : token
            ]
        case .signIn(_, _), .signUp(_),
                .findPassword(_, _), .modifyPassword(_, _, _),
                .withDraw:
            return [ "Content-Type": "application/json" ]
        }
        
        
    }
    
    var path: String {
        switch self {
        case .userNickName:
            return "/member/nickname"
        case .signIn:
            return "/login"
        case .signUp:
            return "/signup"
        case .findPassword:
            return "/login/search"
        case .modifyPassword:
            return "/login/search/modify"
        case .withDraw:
            return "/member/delete"
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
        case .findPassword(let email, let certification):
            return try? JSONEncoder().encode(
                FindPasswordRequestDTO(email: email, certification: certification)
            )
        case .modifyPassword(let email,let password, let checkPassword):
            return try? JSONEncoder().encode(
                ModifyPasswordRequestDTO(
                    email: email,
                    password: password,
                    checkPassword: checkPassword
                )
            )
        case .userNickName, .withDraw:
            return nil
        }
    }
    
    var encoding: ParameterEncoding {
        return JSONEncoding.default
    }
}
