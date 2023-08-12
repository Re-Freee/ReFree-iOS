//
//  UIView+ResponseCheck.swift
//  ReFree
//
//  Created by 이주훈 on 2023/08/11.
//

import UIKit

// UIView의 로직을 UIVIewController로 리팩토링 시 삭제 예정
extension UIView {
    func responseCheck(response: CommonResponse) {
        switch response.code {
        case "200": break
        case "401": loginExpired()
        default: break // TODO: 나머지 핸들링
        }
    }
    
    private func loginExpired() {
        guard
            let sceneDelegate = self.window?.windowScene?.delegate as? SceneDelegate
        else { return }
        sceneDelegate.popToRootViewController()
    }
}
