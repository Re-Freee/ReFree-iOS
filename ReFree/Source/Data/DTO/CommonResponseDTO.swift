//
//  CommonResponseDTO.swift
//  ReFree
//
//  Created by 이주훈 on 2023/07/28.
//

import Foundation

struct CommonResponseDTO: Decodable {
    let code: Int
    let message: String
    
    func toDomain() -> CommonResponse {
        return CommonResponse(code: "\(self.code)", message: self.message)
    }
}
