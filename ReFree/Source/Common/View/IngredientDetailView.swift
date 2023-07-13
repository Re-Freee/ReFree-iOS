//
//  IngredientDetailView.swift
//  ReFree
//
//  Created by 이주훈 on 2023/07/14.
//

import UIKit
import SnapKit
import Then

final class IngredientDetailView: UIView {
    private let titleLabel = UILabel().then {
        // TODO: Font
        $0.textAlignment = .center
        $0.text = "방울토마토"
    }
    private let category = DetailStackView(title: "카테고리")
    private let expireDate = DetailStackView(title: "유통기한")
    private let productCount = DetailStackView(title: "수량")
    private let memoLabel = UILabel().then {
        $0.text = "메모"
    }
    private lazy var contentStack = UIStackView(
        arrangedSubviews: [
            titleLabel,
            lineView(height: 0.5),
            category,
            lineView(height: 0.5),
            expireDate,
            lineView(height: 0.5),
            productCount,
            lineView(height: 0.5),
            memoLabel
        ]
    ).then {
        $0.alignment = .fill
        $0.spacing = 8
        $0.axis = .vertical
    }
    
    private let memoTextField = UITextField().then {
        // TODO: Font
        $0.contentVerticalAlignment = .top
        $0.text = "가나다라마바사"
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layout() {
        addSubviews([
            contentStack,
            memoTextField
        ])
        
        titleLabel.snp.makeConstraints {
            $0.height.equalTo(80)
        }
        
        memoLabel.snp.makeConstraints {
            $0.height.equalTo(50)
        }
        
        contentStack.snp.makeConstraints {
            $0.top.equalToSuperview().inset(48)
            $0.leading.trailing.equalToSuperview().inset(48)
        }
        
        memoTextField.snp.makeConstraints {
            $0.top.equalTo(contentStack.snp.bottom).offset(12)
            $0.leading.trailing.equalToSuperview().inset(48)
            $0.bottom.equalToSuperview()
        }
    }
    
}

final class lineView: UIView {
    init(height: CGFloat = 0.5) {
        super.init(frame: .zero)
        backgroundColor = .gray
        snp.makeConstraints {
            $0.height.equalTo(height)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


final class DetailStackView: UIStackView {
    private let titleLabel = UILabel().then {
        $0.textAlignment = .left
    }
    private let descriptionLabel = UILabel().then {
        $0.textAlignment = .right
    }
    
    init(title: String, description: String? = nil) {
        super.init(frame: .zero)
        titleLabel.text = title
        descriptionLabel.text = description
        axis = .horizontal
        distribution = .equalSpacing
        addArrangedSubviews([titleLabel, descriptionLabel])
        
        snp.makeConstraints {
            $0.height.equalTo(50)
        }
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
