//
//  FoodTableViewCell.swift
//  ReFree
//
//  Created by 김형석 on 2023/07/24.
//

import UIKit
import SnapKit
import Then

final class FoodTableViewCell: UITableViewCell, Identifiable {
    private let foodImage = UIImageView()
    
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
    
    override func layoutSubviews() {
        super.layoutSubviews()
//        layer.masksToBounds = false
//        layer.shadowOffset = CGSize(width: 0, height: 2
//        )
//        layer.shadowOpacity = 1
//        layer.shadowRadius = 4
//        layer.shadowColor = UIColor.gray.cgColor
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
            let image = ingredient.image,
            let title = ingredient.title,
            let expireDate = ingredient.expireDate
        else { return }
        
        
        foodImage.image = image
        foodTitleLabel.text = title
        foodUsedByDateLabel.text = "소비기한 " + expireDate
        foodRemainDateLabel.text = "N일 남았습니다!" // TODO: expireDate와 현재 시간을 계산해서 적용
    }
}
