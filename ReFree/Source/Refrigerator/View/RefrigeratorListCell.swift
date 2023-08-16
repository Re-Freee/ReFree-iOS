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
        $0.contentMode = .scaleAspectFill
        $0.layer.opacity = 1
    }
    
    lazy var gradientWhiteView = UIView().then {
        $0.backgroundColor = .white
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
            imageView,
            gradientWhiteView,
            gradientView
        ])
        
        gradientWhiteView.addSubviews([
            titleLabel,
            expirationDateLabel,
        ])
        
        imageView.snp.makeConstraints {
            $0.height.equalToSuperview().multipliedBy(0.55)
            $0.top.leading.trailing.equalToSuperview()
        }
        
        gradientWhiteView.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview().inset(12)
            $0.trailing.equalToSuperview()
        }
        
        expirationDateLabel.snp.makeConstraints{
            $0.top.equalTo(titleLabel.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview().inset(12)
        }
        
        gradientView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
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
