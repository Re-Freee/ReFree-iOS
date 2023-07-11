//
//  UIVIew+Shadow.swift
//  ReFree
//
//  Created by 이주훈 on 2023/07/11.
//

import UIKit

extension UIView {
    func addShadow(
        right: Double = 2,
        down: Double = 3,
        color: UIColor = .gray,
        opacity: Float = 0.4,
        radius: CGFloat = 3
    ) {
        layer.masksToBounds = false
        layer.shadowOffset = CGSize(width: right, height: down)
        layer.shadowOpacity = opacity
        layer.shadowRadius = radius
        layer.shadowColor = color.cgColor
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: layer.cornerRadius).cgPath
    }
    
    func removeShadow() {
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowPath = nil
    }
}
