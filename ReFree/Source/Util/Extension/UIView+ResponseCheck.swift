//
//  UIView+ResponseCheck.swift
//  ReFree
//
//  Created by 이주훈 on 2023/08/11.
//

import UIKit

// UIView의 로직을 UIVIewController로 리팩토링 시 삭제 예정
extension UIView {
    func responseCheck(response: CommonResponse) -> Bool {
        switch response.code {
        case "200": return true
        case "401": loginExpired(); return false
        default: return false // TODO: 나머지 핸들링 + Error Alert
        }
    }
    
    private func loginExpired() {
        Alert.checkAlert(
            targetView: self,
            title: "로그인이 만료되었습니다.",
            message: "다시 로그인해 주세요."
        )
        guard
            let sceneDelegate = self.window?.windowScene?.delegate as? SceneDelegate
        else { return }
        sceneDelegate.popToRootViewController()
        let userRepository = UserRepository()
        userRepository.deleteUserNickName()
    }
}
