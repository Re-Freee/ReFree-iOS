//
//  IngredientDetailView.swift
//  ReFree
//
//  Created by 이주훈 on 2023/07/14.
//

import UIKit
import SnapKit
import Then
import RxSwift

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
            LineView(height: 0.5),
            category,
            LineView(height: 0.5),
            expireDate,
            LineView(height: 0.5),
            productCount,
            LineView(height: 0.5),
            memoLabel
        ]
    ).then {
        $0.alignment = .fill
        $0.spacing = 8
        $0.axis = .vertical
    }
    
    private let memoTextField = UITextField().then {
        // TODO: Font
        $0.isUserInteractionEnabled = false
        $0.contentVerticalAlignment = .top
        $0.text = "가나다라마바사"
    }
    
    let deleteButton = UIButton().then {
        $0.layer.borderColor = UIColor.refreeColor.background3.cgColor
        $0.layer.borderWidth = 0.5
        $0.layer.cornerRadius = 25
        $0.setTitleColor(.black, for: .normal)
        $0.setTitle("삭제", for: .normal)
    }
    
    let editButton = UIButton().then {
        $0.backgroundColor = .refreeColor.background3
        $0.layer.cornerRadius = 25
        $0.setTitle("수정", for: .normal)
        $0.setTitleColor(.white, for: .normal)
    }
    
    private lazy var buttonStack = UIStackView(
        arrangedSubviews: [
            deleteButton,
            editButton
        ]
    ).then {
        $0.axis = .horizontal
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
            memoTextField,
            buttonStack
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
        }
        
        [deleteButton, editButton].forEach {
            $0.snp.makeConstraints {
                $0.width.equalTo(100)
                $0.height.equalTo(50)
            }
        }
        
        buttonStack.snp.makeConstraints {
            $0.top.equalTo(memoTextField.snp.bottom)
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().inset(48)
        }
    }
}
