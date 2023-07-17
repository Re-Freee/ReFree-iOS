//
//  RecipeDetailCell.swift
//  ReFree
//
//  Created by 이주훈 on 2023/07/16.
//

import UIKit
import SnapKit
import Then


final class RecipeDetailCell: UICollectionViewCell, Identifiable {
    let imageView = UIImageView().then {
        $0.layer.cornerRadius = 15
        $0.backgroundColor = .refreeColor.lightGray
    }
    let descriptionLabel = UILabel().then {
        $0.textAlignment = .center
        $0.numberOfLines = 0
        // TODO: Remove
        $0.text = "냄비에 썰어둔 김치와 밑간한 돼지고기, 김칫국물 5큰술, 참기름 1작은술을 넣어 약불에서 3~5분간 충분히 볶아줍니다.냄비에 썰어둔 김치와 밑간한 돼지고기, 김칫국물 5큰술, 참기름 1작은술을 넣어 약불에서 3~5분간 충분히 볶아줍니다.냄비에 썰어둔 김치와 밑간한 돼지고기, 김칫국물 5큰술, 참기름 1작은술을 넣어 약불에서 3~5분간 충분히 볶아줍니다."
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layout() {
        addSubviews([imageView, descriptionLabel])
        
        imageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(12)
            $0.width.equalTo(80)
            $0.height.equalTo(imageView.snp.width).multipliedBy(0.8)
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.top.trailing.bottom.equalToSuperview()
            $0.leading.equalTo(imageView.snp.trailing).offset(12)
        }
    }
}
