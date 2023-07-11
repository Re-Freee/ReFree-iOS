//
//  RecipeSidebarView.swift
//  ReFree
//
//  Created by 이주훈 on 2023/07/12.
//

import UIKit
import SnapKit
import Then

final class RecipeSidebarView: UIView {
    private let bowlStack = FoodKindView(kind: .bowl)
    private let soupStack = FoodKindView(kind: .soup)
    private let sideStack = FoodKindView(kind: .sideMenu)
    private let dessertStack = FoodKindView(kind: .dessert)
    private let line = UIView()
    private let saveStack = FoodKindView(kind: .save)
    
    private lazy var buttonStack = UIStackView(
        arrangedSubviews: [
            bowlStack,
            soupStack,
            sideStack,
            dessertStack,
            line,
            saveStack
        ]
    ).then {
        $0.alignment = .fill
        $0.spacing = 5
        $0.axis = .vertical
    }
    
    private let backButton = UIButton().then {
        $0.tintColor = .white
        $0.backgroundColor = .refreeColor.recipeBack1
        $0.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        $0.layer.cornerRadius = 15
    }
    
    init() {
        super.init(frame: .zero)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        addShadow(
            right: 8,
            down: 0,
            color: .gray,
            opacity: 0.4,
            radius: 2
        )
    }
    
    private func layout() {
        backgroundColor = .white
        addSubviews([buttonStack, backButton])
        
        line.backgroundColor = .black
        line.snp.makeConstraints {
            $0.height.equalTo(0.5)
        }
        
        backButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().offset(12)
            $0.width.height.equalTo(30)
            $0.top.equalToSuperview().offset(100)
        }
        
        buttonStack.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(8)
            $0.centerY.equalToSuperview().offset(-50)
        }
    }
}
