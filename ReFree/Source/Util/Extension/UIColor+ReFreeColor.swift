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
        let background1 = UIColor(named: "Background1")
        let background2 = UIColor(named: "Background2")
        let background3 = UIColor(named: "Background3")
        let background4 = UIColor(named: "Background4")
        
        // Point Colors
        let border1 = UIColor(named: "Border1")
        let border2 = UIColor(named: "Border2")
        let defaultBack = UIColor(named: "DefaultBack")
        let recipeBack1 = UIColor(named: "RecipeBack1")
        let recipeBack2 = UIColor(named: "RecipeBack2")
        let selectedBack = UIColor(named: "SelectedBack")
        let sideBarIcon = UIColor(named: "SideBarIcon")
        let unSelectedBack = UIColor(named: "UnSelectedBack") // == White
        let unSelectedIcon = UIColor(named: "UnSelectedIcon")
    }
}
