//
//  FoodKindView.swift
//  ReFree
//
//  Created by 이주훈 on 2023/07/12.
//

import UIKit
import SnapKit
import Then

final class FoodKindView: UIView {
    enum Kind {
        case bowl
        case soup
        case sideMenu
        case dessert
        case save
    }
    
    private let imageView = UIImageView(
        image: UIImage(named: "")
    )
    
    init(kind: Kind) {
        super.init(frame: .zero)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
