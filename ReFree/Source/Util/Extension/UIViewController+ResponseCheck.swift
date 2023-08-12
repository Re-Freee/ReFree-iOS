//
//  UIViewController+ResponseCheck.swift
//  ReFree
//
//  Created by 이주훈 on 2023/08/12.
//

import UIKit

extension UIViewController {
    func responseCheck(response: CommonResponse) -> Bool {
        switch response.code {
        case "200": return true
        case "401": loginExpired(); return false
        default: return false // TODO: 나머지 핸들링 + Error Alert
        }
    }
    
    private func loginExpired() {
        guard
            let sceneDelegate = view.window?.windowScene?.delegate as? SceneDelegate
        else { return }
        sceneDelegate.popToRootViewController()
    }
}

