//
//  UIViewController+addsubViewToWindow.swift
//  ReFree
//
//  Created by 이주훈 on 2023/08/13.
//

import UIKit

extension UIViewController {
    func addsubViewToWindow(view: UIView) {
        guard
            let sceneDelegate = self.view.window?.windowScene?.delegate as? SceneDelegate,
            let window = sceneDelegate.window
        else {
            return
        }
        let windowFrame = window.frame
        view.frame = windowFrame
        view.layer.zPosition = 1
        window.addSubview(view)
    }
}
