//
//  UIViewController+ResponseCheck.swift
//  ReFree
//
//  Created by 이주훈 on 2023/08/12.
//

import UIKit

extension UIViewController {
    func responseCheck(response: CommonResponse) {
        switch response.code {
        case "200": break
        case "401": loginExpired()
        default: break // TODO: 나머지 핸들링
        }
    }
    
    private func loginExpired() {
        guard
            let sceneDelegate = view.window?.windowScene?.delegate as? SceneDelegate
        else { return }
        sceneDelegate.popToRootViewController()
    }
}

