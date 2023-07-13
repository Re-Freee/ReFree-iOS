//
//  UIView+StackView.swift
//  ReFree
//
//  Created by 이주훈 on 2023/07/14.
//

import UIKit

extension UIStackView {
    func addArrangedSubviews(_ views: [UIView]) {
        views.forEach {
            self.addArrangedSubview($0)
        }
    }
}
