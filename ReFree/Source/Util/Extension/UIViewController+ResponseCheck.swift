//
//  UIViewController+ResponseCheck.swift
//  ReFree
//
//  Created by 이주훈 on 2023/08/12.
//

import UIKit

extension UIViewController {
    func responseCheck(response: CommonResponse) -> Bool {
        // TODO: 각 코드별 핸들링 + Error Alert
        switch response.code {
        case "200": return true
        case "401": loginExpired(); return false
        default:
            Alert.erroAlert(viewController: self, errorMessage: response.message)
            return false
        }
    }
    
    private func loginExpired() {
        guard
            let sceneDelegate = view.window?.windowScene?.delegate as? SceneDelegate
        else { return }
        sceneDelegate.popToRootViewController()
        let userRepository = UserRepository()
        userRepository.deleteUserNickName()
    }
}

