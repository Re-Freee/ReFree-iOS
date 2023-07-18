//
//  RecipeListCell.swift
//  ReFree
//
//  Created by 이주훈 on 2023/07/18.
//

import UIKit
import SnapKit
import Then

final class RecipeListCell: UICollectionViewCell, Identifiable {
    private let imageView = UIImageView(image: UIImage(named: "FourCircle")).then {
        $0.layer.opacity = 0.8
    }
    private let titleLabel = UILabel().then {
        $0.numberOfLines = 1
        $0.text = "돼지고기 김치찌개"
        $0.textColor = .refreeColor.text3
        $0.font = .pretendard.bold15
    }
    private let heartImageView = UIImageView(
        image: UIImage(systemName: "heart.fill")?
            .withRenderingMode(.alwaysOriginal)
            .withTintColor(.white)
    )
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        gradientBackground(type: .halfBlackAxial)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layout() {
        clipsToBounds = true
        layer.cornerRadius = 10
        
        addSubviews([
            imageView,
            titleLabel,
            heartImageView
        ])
        
        imageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(24)
            $0.width.equalToSuperview().multipliedBy(0.6)
            $0.bottom.equalToSuperview().inset(24)
        }
        
        heartImageView.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(24)
            $0.width.height.equalTo(titleLabel.snp.height)
            $0.bottom.equalToSuperview().inset(24)
            
        }
    }
}
