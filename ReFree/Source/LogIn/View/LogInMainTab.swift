//
//  LogInMainTab.swift
//  ReFree
//
//  Created by 김형석 on 2023/07/18.
//

import UIKit
import SnapKit
import Then

class LogInMainTab: UIView {
    private let mainLogoImage = UIImageView().then {
        $0.image = UIImage(named: "RefreeLogo")
        $0.contentMode = .scaleToFill
    }
    
    private let stackViewBackground = LogInStackViewBackground(height: 280)
    
    private let logInStackView = UIStackView().then {
        $0.spacing = 20
        $0.axis = .vertical
    }
    
    private let logInLabel = UILabel().then {
        $0.textColor = UIColor.refreeColor.main
        $0.font = .pretendard.extraBold30
        $0.text = "로그인"
    }
    
    private let logInEmailText = LogInTextField(message: "이메일", height: 40)
    
    private let logInPasswordText = LogInTextField(message: "비밀번호", isPassword: true, height: 40)
    
    private let logInButton = LogInButton(message: "Get started!", height: 40)
    
    private let passwordFindButton = UIButton().then {
        $0.setTitle("비밀번호를 잊으셨나요?", for: .normal)
        $0.setTitleColor(UIColor.refreeColor.text1, for: .normal)
        $0.titleLabel?.font = .pretendard.bold15
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layout() {
        self.addSubviews([
            mainLogoImage,
            stackViewBackground,
            logInStackView,
            passwordFindButton
        ]
        )
        
        logInStackView.addArrangedSubviews(
            [
                logInLabel,
                logInEmailText,
                logInPasswordText,
                logInButton
            ]
        )
        
        mainLogoImage.snp.makeConstraints {
            $0.top.equalToSuperview().offset(120)
            $0.leading.trailing.equalToSuperview()
        }
        
        stackViewBackground.snp.makeConstraints {
            $0.top.equalTo(mainLogoImage.snp.bottom).offset(Constant.spacing8)
            $0.leading.trailing.equalToSuperview().inset(Constant.spacing24)
        }
    
        logInStackView.snp.makeConstraints {
            $0.top.equalTo(stackViewBackground.snp.top).offset(Constant.spacing24)
            $0.leading.equalTo(stackViewBackground.snp.leading).offset(Constant.spacing24)
            $0.trailing.equalTo(stackViewBackground.snp.trailing).offset(-Constant.spacing24)
        }
        
        passwordFindButton.snp.makeConstraints {
            $0.top.equalTo(stackViewBackground.snp.bottom).offset(Constant.spacing6)
            $0.leading.equalTo(logInStackView.snp.leading)
        }
    }
}
