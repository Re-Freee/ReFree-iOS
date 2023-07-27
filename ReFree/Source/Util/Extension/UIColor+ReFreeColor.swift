//
//  UIColor+Asset.swift
//  ReFree
//
//  Created by 이주훈 on 2023/07/10.
//

import UIKit

extension UIColor {
    static let refreeColor = ReFreeColor()
    
    struct ReFreeColor {
        // Background Colors
        let background1 = UIColor(named: "Background1") ?? .white
        let background2 = UIColor(named: "Background2") ?? .white
        let background3 = UIColor(named: "Background3") ?? .white
        let background4 = UIColor(named: "Background4") ?? .white
        
        // Point Colors
        let main = UIColor(named: "Main") ?? .white
        let textFrame = UIColor(named: "TextFrame") ?? .white
        let text1 = UIColor(named: "Text1") ?? .white
        let text2 = UIColor(named: "Text2") ?? .white
        let text3 = UIColor(named: "Text3") ?? .white
        let button1 = UIColor(named: "Button1") ?? .white
        let button2 = UIColor(named: "Button2") ?? .white
        let button3 = UIColor(named: "Button3") ?? .white
        let button4 = UIColor(named: "Button4") ?? .white
        let button5 = UIColor(named: "Button5") ?? .white
        let button6 = UIColor(named: "Button6") ?? .white
        let red = UIColor(named: "Red") ?? .white
        
        // Custom Colors
        let lightGray = UIColor(named: "LightGray") ?? .white
    }
}
