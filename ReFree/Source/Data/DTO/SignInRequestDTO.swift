//
//  SignInDTO.swift
//  ReFree
//
//  Created by 이주훈 on 2023/07/28.
//

import Foundation

struct SignInRequestDTO: Encodable {
    let email: String
    let password: String
}
