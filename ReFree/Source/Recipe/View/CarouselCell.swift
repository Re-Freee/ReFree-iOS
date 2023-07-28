//
//  CarouselCell.swift
//  ReFree
//
//  Created by 이주훈 on 2023/07/11.
//

import UIKit
import SnapKit
import Then
import Kingfisher

final class CarouselCell: UICollectionViewCell, Identifiable {
    private let titleLabel = UILabel().then {
        $0.text = "요리 이름"
        $0.textColor = .refreeColor.text3
        $0.font = .pretendard.bold20
    }
    
    private let indicator = UIImageView(
        image: UIImage(systemName: "chevron.right")
    ).then {
        $0.tintColor = .refreeColor.text3
    }
    
    private let materialLabel = UILabel().then {
        $0.text = "재료"
        $0.textColor = .refreeColor.text3
        $0.font = .pretendard.bold15
    }
    
    private let materialLists = UILabel().then {
        $0.text = "연어, 오이, 당근, 양상추, 발사믹 소스"
        $0.textColor = .refreeColor.text1
        $0.font = .pretendard.extraLight12
    }
    
    private let imageView = UIImageView(image: UIImage(named: "Rocket")).then {
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 15
    }
    
    private lazy var titleStack = UIStackView(
        arrangedSubviews: [titleLabel, indicator]
    ).then {
        $0.distribution = .equalSpacing
        $0.axis = .horizontal
    }
    
    private lazy var materialStack = UIStackView(
        arrangedSubviews: [materialLabel, materialLists]
    ).then {
        $0.spacing = 5
        $0.axis = .vertical
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func layout() {
        gradientBackground(type: .blackAxial)
        layer.cornerRadius = 15
        clipsToBounds = true
        
        addSubviews([titleStack, materialStack, imageView])
        
        titleStack.snp.makeConstraints {
            $0.top.trailing.leading.equalToSuperview().inset(24)
        }
        
        materialStack.snp.makeConstraints {
            $0.top.equalTo(titleStack.snp.bottom).offset(24)
            $0.leading.trailing.equalToSuperview().inset(24)
        }
        
        imageView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview().inset(24)
            $0.height.equalTo(imageView.snp.width)
        }
    }
    
    // Struct로 데이터를 받아올 예정
    func configCell(recipe: Recipe) {
        let url = URL(string: recipe.imageURL)
        imageView.kf.setImage(with: url)
        titleLabel.text = recipe.title
        materialLists.text = recipe.ingredients
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = ""
        materialLists.text = ""
        imageView.image = UIImage(named: "Rocket")
    }
}
