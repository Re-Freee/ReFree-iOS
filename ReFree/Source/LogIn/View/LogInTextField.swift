//
//  LogInTextField.swift
//  ReFree
//
//  Created by 김형석 on 2023/07/18.
//

import UIKit
import SnapKit
import Then

class LogInTextField: UIView {
    private let textField = UITextField().then {
        $0.textColor = .refreeColor.text2
        $0.font = .pretendard.extraLight15
        $0.autocapitalizationType = .none
    }
    
    init(message: String,
         isPassword: Bool = false,
         height: CGFloat = .zero
    ) {
        super.init(frame: .zero)
        if height == .zero {
            layout(message: message, isPassword: isPassword, height: 50)
        } else {
            layout(message: message, isPassword: isPassword, height: height)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layout(
        message: String,
        isPassword: Bool,
        height: CGFloat
    ) {
        let cornerRadius = height / 2
        
        textField.isSecureTextEntry = isPassword
        textField.placeHolder(string: message, color: .refreeColor.text1)
        layer.cornerRadius = cornerRadius
        backgroundColor = .refreeColor.button4
        
        addSubview(textField)
        
        snp.makeConstraints {
            $0.height.equalTo(height)
        }
        
        textField.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(Constant.spacing12)
        }
    }
}
