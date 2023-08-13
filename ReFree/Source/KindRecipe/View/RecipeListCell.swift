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
    private let overlayView = UIView()
    private let imageView = UIImageView(image: UIImage(named: "ReFree_non")).then {
        $0.contentMode = .scaleAspectFill
        $0.layer.opacity = 0.8
    }
    private let titleLabel = UILabel().then {
        $0.numberOfLines = 1
        $0.text = "돼지고기 김치찌개"
        $0.textColor = .refreeColor.text3
        $0.font = .pretendard.bold15
    }
    private let heartImageView = UIImageView(
        image: UIImage(systemName: "heart")?
            .withTintColor(.white, renderingMode: .alwaysOriginal)
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
        
        imageView.addSubviews([overlayView])
        
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
        
        overlayView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        overlayView.backgroundColor = .black
        overlayView.layer.opacity = 0.3
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = ""
        imageView.image = UIImage(named: "ReFree_non")
        heartImageView.image = UIImage(systemName: "heart")?
            .withTintColor(.white, renderingMode: .alwaysOriginal)
    }
    
    func configCell(recipe: Recipe) {
        let url = URL(string: recipe.imageURL)
        imageView.kf.setImage(with: url)
        titleLabel.text = recipe.title
        let isHeartImage = recipe.isHeart ? UIImage(systemName: "heart.fill") : UIImage(systemName: "heart")
        heartImageView.image = isHeartImage?.withTintColor(.white, renderingMode: .alwaysOriginal)
    }
    
    func isHeartChange(isHeart: Bool) {
        let isHeartImage = isHeart ? UIImage(systemName: "heart.fill") : UIImage(systemName: "heart")
        heartImageView.image = isHeartImage?.withTintColor(.white, renderingMode: .alwaysOriginal)
    }
}
