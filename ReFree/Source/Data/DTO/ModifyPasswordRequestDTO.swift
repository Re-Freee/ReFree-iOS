//
//  ModifyPasswordRequestDTO.swift
//  ReFree
//
//  Created by 이주훈 on 2023/07/28.
//

import Foundation

struct ModifyPasswordRequestDTO: Encodable {
    let email: String
    let password: String
    let checkPassword: String
}
