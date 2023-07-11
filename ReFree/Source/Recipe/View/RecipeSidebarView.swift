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
    
    init() {
        super.init(frame: .zero)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layout() {
        backgroundColor = .white
        addSubview(buttonStack)
        
        addShadow(
            right: 3,
            down: 0,
            color: .gray,
            opacity: 0.4,
            radius: 2
        )
        
        line.backgroundColor = .black
        line.snp.makeConstraints {
            $0.height.equalTo(0.5)
        }
        
        buttonStack.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.centerY.equalToSuperview().offset(-50)
        }
    }
}
