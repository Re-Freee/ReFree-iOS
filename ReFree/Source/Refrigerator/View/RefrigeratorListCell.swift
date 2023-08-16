//
//  RefrigeratorListCellCollectionViewCell.swift
//  ReFree
//
//  Created by hwijinjeong on 2023/07/28.
//

import UIKit
import SnapKit
import Then
import Kingfisher

final class RefrigeratorListCell: UICollectionViewCell, Identifiable {
    static let identifier = "RefrigeratorListCellIdentifier"
    
    lazy var imageView = UIImageView(image: UIImage(named: "FourCircle")).then {
        $0.contentMode = .scaleToFill
        $0.layer.opacity = 1
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
    
    private let gradientView = UIView().then {
        $0.backgroundColor = .clear
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
         if gradientView.layer.sublayers == nil {
             gradientView.gradientBackground(type: .halfWhiteAxial)
        }
    }
    
    private func layout() {
        clipsToBounds = true
        layer.cornerRadius = 10
        
        addSubviews([
            stackView,
            titleLabel,
            expirationDateLabel,
            gradientView
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
        
        gradientView.snp.makeConstraints {
            $0.top.equalTo(stackView.snp.top)
            $0.leading.trailing.equalTo(gradientWhiteView)
            $0.bottom.equalTo(titleLabel.snp.top)
        }
    }
    
    func configCell(ingredient: Ingredient) {
        guard
            let urlString = ingredient.imageURL,
            let url = URL(string: urlString),
            let title = ingredient.title,
            let expireDate = ingredient.expireDate
        else { return }
        imageView.kf.setImage(with: url)
        titleLabel.text = title
        expirationDateLabel.text = "\(expireDate)까지"        
    }
}
