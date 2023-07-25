//
//  PasswordChangeViewController.swift
//  ReFree
//
//  Created by 김형석 on 2023/07/21.
//

import UIKit
import SnapKit
import Then
import RxSwift

class PasswordChangeViewController: UIViewController, UITextFieldDelegate {
    private let header = PasswordFindTabHeader(frame: .zero)
    
    private let stackViewBackground = LogInStackViewBackground(height: 340)
    
    private let newPasswordStackView = UIStackView().then {
        $0.spacing = 12
        $0.axis = .vertical
    }
    
    private let notSamePasswordLabel = UILabel().then {
        $0.text = "비밀번호가 일치하지 않습니다."
        $0.font = .pretendard.extraLight12
        $0.textColor = .refreeColor.red
        $0.isHidden = true
    }
    
    private let newPasswordCheckImage = UIImageView().then {
        $0.image = UIImage(named: "CircleCheck")
        $0.contentMode = .scaleToFill
        $0.isHidden = true
    }
    
    private let newPasswordXImage = UIImageView().then {
        $0.image = UIImage(named: "CircleX")
        $0.contentMode = .scaleToFill
        $0.isHidden = true
    }
    
    private let confirmNewPasswordCheckImage = UIImageView().then {
        $0.image = UIImage(named: "CircleCheck")
        $0.contentMode = .scaleToFill
        $0.isHidden = true
    }
    
    private let confirmNewPasswordXImage = UIImageView().then {
        $0.image = UIImage(named: "CircleX")
        $0.contentMode = .scaleToFill
        $0.isHidden = true
    }
    
    private let newPasswordText = LogInTextField(message: "새로운 비밀번호 (8자 이상)", isPassword: true, height: 40)
    
    private let confirmNewPasswordText = LogInTextField(message: "비밀번호 확인", isPassword: true, height: 40)
    
    private let newPasswordSettingButton = LogInButton(message: "Continue", height: 40)
    
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
        
        newPasswordText.textField.delegate = self
        confirmNewPasswordText.textField.delegate = self
        
        newPasswordSettingButton.button.addTarget(self, action: #selector(newPasswordSettingButtonTapped), for: .touchUpInside)
        newPasswordText.textField.addTarget(self, action: #selector(newPasswordTextFieldDidChange(_:)), for: .editingChanged)
        confirmNewPasswordText.textField.addTarget(self, action: #selector(confirmNewPasswordTextFieldDidChange(_:)), for: .editingChanged)
    }
    
    private func layout() {
        view.addSubviews(
            [
                header,
                stackViewBackground,
                newPasswordStackView,
                passwordFindLabel,
                newPasswordSettingButton,
                newPasswordCheckImage,
                newPasswordXImage,
                confirmNewPasswordCheckImage,
                confirmNewPasswordXImage
            ]
        )
        
        newPasswordStackView.addArrangedSubviews(
            [
                newPasswordText,
                confirmNewPasswordText,
                notSamePasswordLabel
            ]
        )
        
        header.snp.makeConstraints {
            $0.top.leading.bottom.trailing.equalTo(view.safeAreaLayoutGuide)
        }
        
        passwordFindLabel.snp.makeConstraints {
            $0.top.equalTo(stackViewBackground.snp.top).offset(40)
            $0.leading.equalTo(stackViewBackground.snp.leading).offset(32)
        }
        
        stackViewBackground.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(200)
            $0.leading.trailing.equalToSuperview().inset(Constant.spacing24)
        }
        
        newPasswordStackView.snp.makeConstraints {
            $0.top.equalTo(passwordFindLabel.snp.bottom).offset(40)
            $0.leading.equalTo(stackViewBackground.snp.leading).offset(32)
            $0.trailing.equalTo(stackViewBackground.snp.trailing).offset(-32)
        }
        
        newPasswordCheckImage.snp.makeConstraints {
            $0.top.equalTo(passwordFindLabel.snp.bottom).offset(50)
            $0.leading.equalTo(newPasswordText.snp.trailing).offset(5)
        }
        
        newPasswordXImage.snp.makeConstraints {
            $0.top.equalTo(passwordFindLabel.snp.bottom).offset(50)
            $0.leading.equalTo(newPasswordText.snp.trailing).offset(5)
        }
        
        confirmNewPasswordCheckImage.snp.makeConstraints {
            $0.top.equalTo(passwordFindLabel.snp.bottom).offset(105)
            $0.leading.equalTo(confirmNewPasswordText.snp.trailing).offset(5)
        }
        
        confirmNewPasswordXImage.snp.makeConstraints {
            $0.top.equalTo(passwordFindLabel.snp.bottom).offset(105)
            $0.leading.equalTo(confirmNewPasswordText.snp.trailing).offset(5)
        }
        
        newPasswordSettingButton.snp.makeConstraints {
            $0.top.equalTo(confirmNewPasswordText.snp.bottom).offset(50)
            $0.leading.equalTo(stackViewBackground.snp.leading).offset(32)
            $0.trailing.equalTo(stackViewBackground.snp.trailing).offset(-32)
        }
    }
    
    @objc func newPasswordTextFieldDidChange(_ textField: UITextField) {
        if textField.text?.count ?? 0 < 8 {
            newPasswordXImage.isHidden = false
            newPasswordCheckImage.isHidden = true
        } else {
            newPasswordCheckImage.isHidden = false
            newPasswordXImage.isHidden = true
        }
    }
    
    @objc func confirmNewPasswordTextFieldDidChange(_ textField: UITextField) {
        if newPasswordText.textField.text == confirmNewPasswordText.textField.text {
            confirmNewPasswordCheckImage.isHidden = false
            confirmNewPasswordXImage.isHidden = true
            notSamePasswordLabel.isHidden = true
        } else {
            confirmNewPasswordXImage.isHidden = false
            confirmNewPasswordCheckImage.isHidden = true
            notSamePasswordLabel.isHidden = false
        }
    }
    
    @objc private func newPasswordSettingButtonTapped() {
        
    }
}
