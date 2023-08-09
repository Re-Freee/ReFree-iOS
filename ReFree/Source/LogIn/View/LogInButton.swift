//
//  LogInButton.swift
//  ReFree
//
//  Created by 김형석 on 2023/07/19.
//

import UIKit
import SnapKit
import Then

final class LogInButton: UIView {
    public let button = UIButton().then {
        $0.isEnabled = false
        $0.setTitleColor(UIColor.refreeColor.text1, for: .normal)
        $0.titleLabel?.font = .pretendard.bold15
        $0.contentHorizontalAlignment = .center
        $0.backgroundColor = .refreeColor.main
    }
    
    init(message: String,
         height: CGFloat = .zero
    ) {
        super.init(frame: .zero)
        if height == .zero {
            layout(message: message, height: 50)
        } else {
            layout(message: message, height: height)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layout(
        message: String,
        height: CGFloat
    ) {
        let cornerRadius = height / 2
        
        button.layer.cornerRadius = cornerRadius
        button.setTitle(message, for: .normal)
        
        addSubview(button)
        
        snp.makeConstraints {
            $0.height.equalTo(height)
        }
        
        button.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
        }
    }

}
