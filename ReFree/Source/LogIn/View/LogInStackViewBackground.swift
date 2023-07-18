//
//  LogInStackViewBackground.swift
//  ReFree
//
//  Created by 김형석 on 2023/07/19.
//

import UIKit
import SnapKit
import Then

class LogInStackViewBackground: UIView {
    init(height: CGFloat) {
        super.init(frame: .zero)
        layout(height: height)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layout(height: CGFloat) {
        let cornerRadius = height / 8
        
        layer.cornerRadius = cornerRadius
        backgroundColor = .white
        
        snp.makeConstraints {
            $0.height.equalTo(height)
        }
    }
}
