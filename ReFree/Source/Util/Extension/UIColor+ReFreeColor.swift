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
        let border1 = UIColor(named: "Border1") ?? .white
        let border2 = UIColor(named: "Border2") ?? .white
        let defaultBack = UIColor(named: "DefaultBack") ?? .white
        let recipeBack1 = UIColor(named: "RecipeBack1") ?? .white
        let recipeBack2 = UIColor(named: "RecipeBack2") ?? .white
        let selectedBack = UIColor(named: "SelectedBack") ?? .white
        let sideBarIcon = UIColor(named: "SideBarIcon") ?? .white
        let unSelectedBack = UIColor(named: "UnSelectedBack") ?? .white // == White
        let unSelectedIcon = UIColor(named: "UnSelectedIcon") ?? .white
    }
}
