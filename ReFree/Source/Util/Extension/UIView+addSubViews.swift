//
//  UIView+.swift
//  ReFree
//
//  Created by 이주훈 on 2023/07/06.
//

import UIKit

extension UIView {
    func addSubviews(_ views: [UIView]) {
        views.forEach {
            addSubview($0)
        }
    }
}
