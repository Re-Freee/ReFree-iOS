//
//  LogInStackViewBackground.swift
//  ReFree
//
//  Created by 김형석 on 2023/07/19.
//

import UIKit
import SnapKit
import Then

final class LogInStackViewBackground: UIView {
    init(height: CGFloat) {
        super.init(frame: .zero)
        layout(height: height)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.masksToBounds = false
        layer.shadowOffset = CGSize(width: 0, height: 4)
        layer.shadowOpacity = 1
        layer.shadowRadius = 4
        layer.shadowColor = UIColor.gray.cgColor
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
