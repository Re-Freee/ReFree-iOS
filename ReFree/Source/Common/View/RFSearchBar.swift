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
    let textField = UITextField().then {
        $0.placeHolder(
            string: "Search",
            color: UIColor.refreeColor.text1
        )
        $0.textColor = .refreeColor.text2
        $0.font = .pretendard.extraLight20
    }
    
    let searchStart = UIButton().then {
        $0.setImage(UIImage(named: "Search"), for: .normal)
    }
    
    private let shadow: Bool
    
    init(height: CGFloat = 40, shadow: Bool = true) {
        self.shadow = shadow
        super.init(frame: .zero)
        layout(height: height)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if shadow {
            addShadow()
        }
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
