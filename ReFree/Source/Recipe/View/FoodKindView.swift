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
    enum Kind: String {
        case bowl = "Bowl"
        case soup = "Soup"
        case sideMenu = "Side"
        case dessert = "Dessert"
        case save = "SaveHeart"
        
        var foodScript: String {
            switch self {
            case .bowl: return "밥 레시피"
            case .soup: return "국&찌개 레시피"
            case .sideMenu: return "반찬 레시피"
            case .dessert: return "후식 레시피"
            case .save: return "저장한 레시피"
            }
        }
    }
    
    private let title = UILabel().then {
        $0.font = .pretendard.bold15
        $0.textColor = .refreeColor.text1
    }
    private let imageView = UIImageView()
    
    var kind: Kind
    
    init(kind: Kind) {
        self.kind = kind
        super.init(frame: .zero)
        config()
        layout()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func config() {
        imageView.image = UIImage(named: kind.rawValue)
        title.text = kind.foodScript
        addSubviews([imageView, title])
    }

    private func layout() {
        imageView.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(24)
            $0.centerY.equalToSuperview()
            $0.height.width.equalTo(20)
        }
        
        title.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(12)
            $0.leading.equalTo(imageView.snp.trailing).offset(24)
        }
        
        snp.makeConstraints {
            $0.height.equalTo(60)
        }
        
        layer.cornerRadius = 10
    }
}
