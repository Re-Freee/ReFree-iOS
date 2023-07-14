//
//  SearchBar.swift
//  ReFree
//
//  Created by 이주훈 on 2023/07/11.
//

import UIKit
import SnapKit
import Then

final class RFSearchBar: UIView {
    private let textField = UITextField().then {
        $0.placeHolder(
            string: "재료명, 음식명으로 검색",
            color: UIColor.refreeColor.text1
        )
        $0.textColor = .refreeColor.text1
    }
    
    private let searchStart = UIImageView(
        image: UIImage(named: "Search")
    )
    
    init(height: CGFloat = .zero) {
        super.init(frame: .zero)
        if height == .zero {
            layout(height: 50)
        } else {
            layout(height: height)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        addShadow()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layout(height: CGFloat) {
        let cornerRadius = height / 2
        let searchHeight = height / 5 * 3
        let inset = (height-searchHeight) / 2
        
        backgroundColor = .refreeColor.button4
        layer.cornerRadius = cornerRadius
        
        addSubviews([textField, searchStart])
        
        snp.makeConstraints {
            $0.height.equalTo(height)
        }
        
        textField.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.leading.equalToSuperview().inset(24)
        }
        
        searchStart.snp.makeConstraints {
            $0.top.equalToSuperview().inset(inset)
            $0.trailing.equalToSuperview().inset(12)
            $0.width.height.equalTo(searchHeight)
            $0.leading.equalTo(textField.snp.trailing).offset(Constant.spacing10)
        }
    }
}
