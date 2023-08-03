//
//  UIView+alignBtnTextBelow.swift
//  ReFree
//
//  Created by hwijinjeong on 2023/07/28.
//

import UIKit

extension UIButton {
    func alignBtnTextBelow(spacing: CGFloat = 4.0) {
//        guard
//            let image = self.imageView?.image,
//            let titleLabel = self.titleLabel,
//            let titleText = titleLabel.textelse
//        { return }
//        
//        let titleSize = titleText.size(withAttributes: [
//            NSAttributedString.Key.font: titleLabel.font as Any
//        ])
        
        var config = UIButton.Configuration.plain()
        config.imagePadding = spacing
        config.baseForegroundColor = UIColor.refreeColor.text1
        config.imagePlacement = .top
        self.configuration = config
    }
}
