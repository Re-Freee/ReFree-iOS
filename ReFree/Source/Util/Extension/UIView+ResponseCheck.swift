//
//  UIView+ResponseCheck.swift
//  ReFree
//
//  Created by 이주훈 on 2023/08/11.
//

import UIKit

extension UIView {
    func checkResponse(response: CommonResponse){
        switch response.code {
        case "200": break
        case "401": break // 토큰 만료
        default: break // TODO: 나머지 핸들링
        }
    }
}
