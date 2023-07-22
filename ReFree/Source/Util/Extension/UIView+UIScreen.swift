//
//  UIView+UIScreen.swift
//  ReFree
//
//  Created by hwijinjeong on 2023/07/20.
//

import UIKit

extension UIScreen {
    var isWiderThan375pt: Bool { self.bounds.size.width > 375 }
}
