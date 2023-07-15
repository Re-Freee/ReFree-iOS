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
    
    func addLeftPadding() {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: self.frame.height))
        self.leftView = paddingView
        self.leftViewMode = ViewMode.always
      }
}
