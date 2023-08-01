//
//  RefrigeratorListCellCollectionViewCell.swift
//  ReFree
//
//  Created by hwijinjeong on 2023/07/28.
//

import UIKit
import SnapKit
import Then

final class RefrigeratorListCell: UICollectionViewCell, Identifiable {
    static let identifier = "RefrigeratorListCellIdentifier"
    
    lazy var imageView = UIImageView(image: UIImage(named: "FourCircle")).then {
        $0.layer.opacity = 0.8
    }
    
    lazy var gradientWhiteView = UIView().then {
        $0.backgroundColor = .white
    }
    
    private let stackView = UIStackView().then {
        $0.axis = .vertical
        $0.distribution = .fill
        $0.alignment = .fill
    }
    
    private let titleLabel = UILabel().then {
        $0.numberOfLines = 1
        $0.text = "서울우유"
        $0.textColor = .refreeColor.main
        $0.font = .pretendard.bold18
    }
    
    private let expirationDateLabel = UILabel().then {
        $0.numberOfLines = 1
        $0.text = "2023.06.07까지"
        $0.textColor = .refreeColor.text1
        $0.font = .pretendard.extraLight12
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        gradientBackground(type: .halfWhiteAxial)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layout() {
        clipsToBounds = true
        layer.cornerRadius = 10
        
        addSubviews([
            stackView,
            titleLabel,
            expirationDateLabel
        ])
        
        stackView.addArrangedSubviews([
            imageView,
            gradientWhiteView,
        ])
        
        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        imageView.snp.makeConstraints {
            $0.height.equalTo(stackView).multipliedBy(0.5)
            $0.width.equalTo(stackView)
        }

        gradientWhiteView.snp.makeConstraints {
            $0.height.equalTo(stackView).multipliedBy(0.5)
            $0.width.equalTo(stackView)
        }
        
        titleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(14)
            $0.width.equalToSuperview().multipliedBy(0.6)
            $0.top.equalTo(gradientWhiteView.snp.top).offset(15)
        }
        
        expirationDateLabel.snp.makeConstraints{
            $0.top.equalTo(titleLabel.snp.top).offset(30)
            $0.leading.equalToSuperview().inset(14)
        }
        
    func configCell(ingredient: Ingredient) {
        else { return }
            let expireDate = ingredient.expireDate
            let title = ingredient.title,
            let image = ingredient.image,
        guard
//        let gradientLayer = CAGradientLayer()
//            gradientLayer.colors = [UIColor.white.cgColor, UIColor.clear.cgColor]
//            gradientLayer.locations = [0.0, 1.0]
//            gradientLayer.frame = gradientWhiteView.bounds
//
//        gradientWhiteView.layer.addSublayer(gradientLayer)
        
        imageView.image = image
        titleLabel.text = title
        expirationDateLabel.text = "\(expireDate)까지"
    }
}


