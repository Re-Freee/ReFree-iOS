//
//  FoodTableViewCell.swift
//  ReFree
//
//  Created by 김형석 on 2023/07/24.
//

import UIKit
import SnapKit
import Then
import Kingfisher

final class FoodTableViewCell: UITableViewCell, Identifiable {
    private let foodImage = UIImageView().then {
        $0.clipsToBounds = true
        $0.contentMode = .scaleAspectFill
        $0.layer.cornerRadius = 5
    }
    
    private let foodTitleLabel = UILabel().then {
        $0.textColor = .refreeColor.main
        $0.font = .pretendard.bold18
    }
    
    private var foodUsedByDate = "2023.06.30"
    
    private let foodUsedByDateLabel = UILabel().then {
        $0.textColor = .refreeColor.main
        $0.font = .pretendard.bold15
    }
    
    private let foodTitleStack = UIStackView().then {
        $0.spacing = 5
        $0.axis = .vertical
    }
    
    private var foodRemainDate = 3
    
    private let foodRemainDateLabel = UILabel().then {
        $0.textColor = .refreeColor.main
        $0.font = .pretendard.extraLight12
    }
    
    private let foodRemainDateStack = UIStackView().then {
        $0.distribution = .equalSpacing
        $0.axis = .horizontal
    }
    
    private let rightIndicator = UIImageView(
        image: UIImage(systemName: "chevron.right")
    ).then {
        $0.tintColor = .refreeColor.text1
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layout() {
        self.backgroundColor = .white
        layer.cornerRadius = 15
        
        addSubviews(
            [
                foodImage,
                foodTitleStack,
                foodRemainDateStack
            ]
        )
        
        foodTitleStack.addArrangedSubviews(
            [
                foodTitleLabel,
                foodUsedByDateLabel
            ]
        )
        
        foodRemainDateStack.addArrangedSubviews(
            [
                foodRemainDateLabel,
                rightIndicator
            ]
        )
        
        foodImage.snp.makeConstraints {
            $0.top.leading.bottom.equalToSuperview().inset(10)
            $0.width.equalTo(foodImage.snp.height)
        }
        
        foodTitleStack.snp.makeConstraints {
            $0.top.equalTo(foodImage.snp.top)
            $0.leading.equalTo(foodImage.snp.trailing).offset(10)
        }
        
        foodRemainDateStack.snp.makeConstraints {
            $0.bottom.equalTo(foodImage.snp.bottom)
            $0.leading.equalTo(foodImage.snp.trailing).offset(10)
            $0.trailing.equalToSuperview().offset(-10)
        }
    }
    
    public func setData(ingredient: Ingredient) {
        guard
            let imageURLString = ingredient.imageURL,
            let imageURL = URL(string: imageURLString),
            let title = ingredient.title,
            let expireDate = ingredient.expireDate
        else { return }
        
        foodImage.kf.setImage(with: imageURL)
        foodTitleLabel.text = title
        foodUsedByDateLabel.text = "소비기한 " + expireDate
        foodRemainDateLabel.text = remainDateString(expireDate: expireDate)
    }
    
    private func remainDateString(expireDate: String) -> String {
        let expireDate = expireDate.toDate()
        let remainTimeInterval = expireDate.timeIntervalSince(.now)
        let remainDay = Int(ceil(remainTimeInterval / 60 / 60 / 24))
        
        return "\(remainDay)일 남았습니다."
    }
}
