//
//  RecipeDetailCell.swift
//  ReFree
//
//  Created by 이주훈 on 2023/07/16.
//

import UIKit
import SnapKit
import Then
import Kingfisher

final class RecipeDetailCell: UICollectionViewCell, Identifiable {
    private let imageView = UIImageView().then {
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 15
        $0.backgroundColor = .refreeColor.lightGray
    }
    private let descriptionLabel = UILabel().then {
        $0.textAlignment = .left
        $0.numberOfLines = 0
        $0.text = ""
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
            $0.width.equalTo(100)
            $0.height.equalToSuperview()
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.top.trailing.bottom.equalToSuperview()
            $0.height.greaterThanOrEqualTo(80)
            $0.height.lessThanOrEqualTo(150)
            $0.leading.equalTo(imageView.snp.trailing).offset(12)
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = UIImage(named: "ReFree_non")
        descriptionLabel.text = ""
    }
    
    func configCell(manual: Manual) {
        let url = URL(string: manual.imageURL)
        imageView.kf.setImage(with: url)
        descriptionLabel.text = manual.describe
    }
}
