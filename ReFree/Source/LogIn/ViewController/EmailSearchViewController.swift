//
//  PasswordFindViewController.swift
//  ReFree
//
//  Created by 김형석 on 2023/07/21.
//

import UIKit
import SnapKit
import Then
import RxSwift

class EmailSearchViewController: UIViewController, UITextFieldDelegate {
    private let header = PasswordFindTabHeader(frame: .zero)
    
    private let stackViewBackground = LogInStackViewBackground(height: 340)
    
    private let passwordFindStackView = UIStackView().then {
        $0.spacing = 35
        $0.axis = .vertical
    }
    
    private let wrongEmailLabel = UILabel().then {
        $0.text = "존재하지 않는 계정입니다."
        $0.font = .pretendard.extraLight12
        $0.textColor = .refreeColor.red
        $0.isHidden = true
    }
    
    private let wrongVerificationCodeLabel = UILabel().then {
        $0.text = "인증코드가 일치하지 않습니다."
        $0.font = .pretendard.extraLight12
        $0.textColor = .refreeColor.red
        $0.isHidden = true
    }
    
    private let wrongEmailXImage = UIImageView().then {
        $0.image = UIImage(named: "CircleX")
        $0.contentMode = .scaleToFill
        $0.isHidden = true
    }
    
    private let wrongEmailCheckImage = UIImageView().then {
        $0.image = UIImage(named: "CircleCheck")
        $0.contentMode = .scaleToFill
        $0.isHidden = true
    }
    
    private let wrongVerificationCodeXImage = UIImageView().then {
        $0.image = UIImage(named: "CircleX")
        $0.contentMode = .scaleToFill
        $0.isHidden = true
    }
    
    private let wrongVerificationCodeCheckImage = UIImageView().then {
        $0.image = UIImage(named: "CircleCheck")
        $0.contentMode = .scaleToFill
        $0.isHidden = true
    }
    
    private let passwordFindEmailText = LogInTextField(message: "이메일", height: 40)
    
    private let verificationCodeText = LogInTextField(
        message: "인증코드",
        isVerificationCode: true
    )
    
    private let passwordFindButton = LogInButton(message: "Submit", height: 40)
    
    private let passwordFindLabel = UILabel().then {
        $0.text = "비밀번호 찾기"
        $0.font = .pretendard.extraBold30
        $0.textColor = .refreeColor.main
    }

    private let signRepository = SignRepository()
    private var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        config()
    }
    
    private func config() {
        view.gradientBackground(type: .mainConic)
        layout()
        passwordFindEmailText.textField.delegate = self
        verificationCodeText.textField.delegate = self
        
        passwordFindButton.button.addTarget(
            self,
            action: #selector(submitButtonTapped),
            for: .touchUpInside
        )
        passwordFindEmailText.textField.addTarget(
            self,
            action: #selector(passwordFindEmailTextFieldDidChange(_:)),
            for: .editingChanged
        )
        verificationCodeText.textField.addTarget(
            self,
            action: #selector(verificationCodeTextFieldDidChange(_:)),
            for: .editingChanged
        )
    }
    
    private func layout() {
        view.addSubviews(
            [
                header,
                stackViewBackground,
                passwordFindStackView,
                wrongEmailXImage,
                wrongEmailCheckImage,
                wrongVerificationCodeXImage,
                wrongVerificationCodeCheckImage,
                wrongEmailLabel,
                wrongVerificationCodeLabel
            ]
        )
        
        passwordFindStackView.addArrangedSubviews(
            [
                passwordFindLabel,
                passwordFindEmailText,
                verificationCodeText,
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
            $0.top.equalTo(passwordFindEmailText.snp.bottom).offset(8)
            $0.leading.equalTo(stackViewBackground.snp.leading).offset(40)
        }
        
        wrongVerificationCodeLabel.snp.makeConstraints {
            $0.top.equalTo(verificationCodeText.snp.bottom).offset(8)
            $0.leading.equalTo(stackViewBackground.snp.leading).offset(40)
        }
        
        passwordFindStackView.snp.makeConstraints {
            $0.top.equalTo(stackViewBackground.snp.top).offset(40)
            $0.leading.equalTo(stackViewBackground.snp.leading).offset(32)
            $0.trailing.equalTo(stackViewBackground.snp.trailing).offset(-32)
        }
        
        wrongEmailXImage.snp.makeConstraints {
            $0.top.equalTo(passwordFindLabel.snp.bottom).offset(44)
            $0.leading.equalTo(passwordFindEmailText.snp.trailing).offset(5)
        }
        
        wrongEmailCheckImage.snp.makeConstraints {
            $0.top.equalTo(passwordFindLabel.snp.bottom).offset(44)
            $0.leading.equalTo(passwordFindEmailText.snp.trailing).offset(5)
        }
        
        wrongVerificationCodeXImage.snp.makeConstraints {
            $0.top.equalTo(passwordFindLabel.snp.bottom).offset(124)
            $0.leading.equalTo(verificationCodeText.snp.trailing).offset(5)
        }
        
        wrongVerificationCodeCheckImage.snp.makeConstraints {
            $0.top.equalTo(passwordFindLabel.snp.bottom).offset(124)
            $0.leading.equalTo(verificationCodeText.snp.trailing).offset(5)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        passwordFindEmailText.textField.resignFirstResponder()
        verificationCodeText.textField.resignFirstResponder()
    }
    
    @objc private func submitButtonTapped() {
        guard
            let email = passwordFindEmailText.textField.text,
            let certification = verificationCodeText.textField.text
        else {
            Alert.checkAlert(
                viewController: self,
                title: "알림!",
                message: "Email과 인증코드를 입력해주세요!"
            )
            return
        }
        
        signRepository.request(
            findPassword: .findPassword(
                email: email,
                certification: certification
            )
        )
        .subscribe(onNext: { [weak self] commonResponse in
            guard
                let self,
                self.responseCheck(response: commonResponse)
            else { return }
            
            let passwordChangeVC = PasswordChangeViewController(email: email)
            self.navigationController?.pushViewController(
                passwordChangeVC,
                animated: true
            )
        }, onError: { error in
            Alert.errorAlert(viewController: self, errorMessage: error.localizedDescription)
        })
        .disposed(by: disposeBag)
    }
    
    @objc private func passwordFindEmailTextFieldDidChange(_ textField: UITextField) {
        guard textField.text != nil && textField.text!.validateEmail() else {
            wrongEmailXImage.isHidden = false
            wrongEmailCheckImage.isHidden = true
            
            passwordFindButton.button.setTitleColor(.refreeColor.text1, for: .normal)
            passwordFindButton.button.isEnabled = false
            return
        }
        
        wrongEmailXImage.isHidden = true
        wrongEmailCheckImage.isHidden = false
        
        if !wrongEmailCheckImage.isHidden && !wrongVerificationCodeCheckImage.isHidden {
            passwordFindButton.button.setTitleColor(.refreeColor.text3, for: .normal)
            passwordFindButton.button.isEnabled = true
        }
    }
    
    @objc private func verificationCodeTextFieldDidChange(_ textField: UITextField) {
        guard textField.text != nil && textField.text!.validateVerificationCode() else {
            wrongVerificationCodeXImage.isHidden = false
            wrongVerificationCodeCheckImage.isHidden = true
            
            passwordFindButton.button.setTitleColor(.refreeColor.text1, for: .normal)
            passwordFindButton.button.isEnabled = false
            return
        }
        
        wrongVerificationCodeXImage.isHidden = true
        wrongVerificationCodeCheckImage.isHidden = false
        
        if !wrongEmailCheckImage.isHidden && !wrongVerificationCodeCheckImage.isHidden {
            passwordFindButton.button.setTitleColor(.refreeColor.text3, for: .normal)
            passwordFindButton.button.isEnabled = true
        }
    }
}
