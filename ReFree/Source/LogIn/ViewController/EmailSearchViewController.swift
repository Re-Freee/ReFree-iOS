//
//  PasswordFindViewController.swift
//  ReFree
//
//  Created by 김형석 on 2023/07/21.
//

import UIKit
import SnapKit
import Then

class EmailSearchViewController: UIViewController {
    private let header = PasswordFindTabHeader(frame: .zero)
    
    private let stackViewBackground = LogInStackViewBackground(height: 280)
    
    private let passwordFindStackView = UIStackView().then {
        $0.spacing = 40
        $0.axis = .vertical
    }
    
    private let wrongEmailLabel = UILabel().then {
        $0.text = "존재하지 않는 계정입니다"
        $0.font = .pretendard.extraLight12
        $0.textColor = .refreeColor.red
        $0.isHidden = true
    }
    
    private let wrongEmailImage = UIImageView().then {
        $0.image = UIImage(named: "CircleX")
        $0.contentMode = .scaleToFill
        $0.isHidden = true
    }
    
    private let passwordFindEmailText = LogInTextField(message: "이메일", height: 40)
    
    private let passwordFindButton = LogInButton(message: "Submit", height: 40)
    
    private let passwordFindLabel = UILabel().then {
        $0.text = "비밀번호 찾기"
        $0.font = .pretendard.extraBold30
        $0.textColor = .refreeColor.main
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        config()
    }
    
    private func config() {
        view.gradientBackground(type: .mainConic)
        layout()
        passwordFindButton.button.addTarget(self, action: #selector(submitButtonTapped), for: .touchUpInside)
    }
    
    private func layout() {
        view.addSubviews(
            [
                header,
                stackViewBackground,
                passwordFindStackView,
                wrongEmailImage,
                wrongEmailLabel
            ]
        )
        
        passwordFindStackView.addArrangedSubviews(
            [
                passwordFindLabel,
                passwordFindEmailText,
                passwordFindButton
            ]
        )
        
        header.snp.makeConstraints {
            $0.top.leading.bottom.trailing.equalTo(view.safeAreaLayoutGuide)
        }
        
        stackViewBackground.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(200)
            $0.leading.trailing.equalToSuperview().inset(Constant.spacing24)
        }
        
        wrongEmailLabel.snp.makeConstraints {
            $0.top.equalTo(passwordFindEmailText.snp.bottom).offset(12)
            $0.leading.equalTo(stackViewBackground.snp.leading).offset(32)
        }
        
        passwordFindStackView.snp.makeConstraints {
            $0.top.equalTo(stackViewBackground.snp.top).offset(40)
            $0.leading.equalTo(stackViewBackground.snp.leading).offset(32)
            $0.trailing.equalTo(stackViewBackground.snp.trailing).offset(-32)
        }
        
        wrongEmailImage.snp.makeConstraints {
            $0.top.equalTo(passwordFindLabel.snp.bottom).offset(50)
            $0.leading.equalTo(passwordFindEmailText.snp.trailing).offset(5)
        }
    }
    
    @objc private func submitButtonTapped() {
        wrongEmailLabel.isHidden = false
        wrongEmailImage.isHidden = false
    }
}
