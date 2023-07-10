//
//  UIView+.swift
//  ReFree
//
//  Created by 이주훈 on 2023/07/06.
//

import UIKit

extension UIView {
    func addSubviews(views: [UIView]) {
        views.forEach {
            self.addSubview($0)
        }
    }
}
