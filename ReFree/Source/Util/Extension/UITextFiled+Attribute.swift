//
//  UITextFiled+Attribute.swift
//  ReFree
//
//  Created by 이주훈 on 2023/07/11.
//

import UIKit

extension UITextField {
    func placeHolder(string: String, color: UIColor = .white) {
        self.attributedPlaceholder = NSAttributedString(
            string: string,
            attributes: [
                NSAttributedString.Key.foregroundColor : color
            ]
        )
    }
}
