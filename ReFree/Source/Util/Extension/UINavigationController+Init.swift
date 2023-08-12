//
//  UINavigationController+Init.swift
//  ReFree
//
//  Created by 이주훈 on 2023/08/12.
//

import UIKit

extension UINavigationController {
    func popToRootAndPushLoginViewController() {
        self.popToRootViewController(animated: false)
        self.pushViewController(LogInViewController(), animated: true)
    }
}
