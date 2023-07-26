//
//  SignUpViewController.swift
//  ReFree
//
//  Created by hwijinjeong on 2023/07/14.
//

import UIKit
import SnapKit
import Then
import RxSwift

class SignUpViewController: UIViewController {
    let signUpImageView1 = UIImageView().then {
        $0.image = UIImage(named: "FourCircle")
        $0.contentMode = .scaleAspectFit
    }
    
    let signUpImageView2 = UIImageView().then {
        $0.image = UIImage(named: "thread")
        $0.contentMode = .scaleAspectFit
    }
    
    let signUpContainerView = UIView().then {
        $0.backgroundColor = .white
    }
    
    let signUpLabel = UILabel().then {
        $0.font = .pretendard.extraBold30
        $0.textColor = UIColor.refreeColor.main
        $0.text = "회원가입"
        $0.textAlignment = .center
    }
    
    let emailView = UIView().then {
        $0.backgroundColor = .clear
    }
    
    let emailTextField = UITextField().then {
        $0.borderStyle = .roundedRect
        $0.textColor = .black
        $0.returnKeyType = .done
        $0.backgroundColor = UIColor.refreeColor.textFrame
        $0.placeHolder(string: "이메일", color: UIColor.refreeColor.text1)
        $0.font = .pretendard.extraLight12
        $0.borderStyle = .none
        $0.addLeftPadding()
    }
    
    let emailLabel = UILabel().then {
        $0.font = .pretendard.extraLight12
        $0.textColor = UIColor.refreeColor.red
        $0.text = "이미 존재하는 계정입니다."
        $0.textAlignment = .center
        $0.isHidden = true
    }
    
    let passwordView = UIView().then {
        $0.backgroundColor = .clear
    }
    
    let passwordTextField = UITextField().then {
        $0.borderStyle = .roundedRect
        $0.textColor = .black
        $0.returnKeyType = .done
        $0.backgroundColor = UIColor.refreeColor.textFrame
        $0.placeHolder(string: "비밀번호", color: UIColor.refreeColor.text1)
        $0.font = .pretendard.extraLight12
        $0.borderStyle = .none
        $0.addLeftPadding()
    }
    
    let confirmPasswordView = UIView().then {
        $0.backgroundColor = .clear
    }
    
    
    let confirmPasswordTextField = UITextField().then {
        $0.borderStyle = .roundedRect
        $0.textColor = .black
        $0.returnKeyType = .done
        $0.backgroundColor = UIColor.refreeColor.textFrame
        $0.placeHolder(string: "비밀번호 확인", color: UIColor.refreeColor.text1)
        $0.font = .pretendard.extraLight12
        $0.borderStyle = .none
        $0.addLeftPadding()
    }
    
    let confirmPasswordLabel = UILabel().then {
        $0.font = .pretendard.extraLight12
        $0.textColor = UIColor.refreeColor.red
        $0.text = "비밀번호가 일치하지 않습니다."
        $0.textAlignment = .center
        $0.isHidden = true
    }
    
    let nicknameView = UIView().then {
        $0.backgroundColor = .clear
    }
    
    let nicknameTextField = UITextField().then {
        $0.borderStyle = .roundedRect
        $0.textColor = .black
        $0.returnKeyType = .done
        $0.backgroundColor = UIColor.refreeColor.textFrame
        $0.placeHolder(string: "닉네임", color: UIColor.refreeColor.text1)
        $0.font = .pretendard.extraLight12
        $0.borderStyle = .none
        $0.addLeftPadding()
    }
    
    let createAccountButton = UIButton().then {
        $0.setTitle("Create Account", for: .normal)
        $0.backgroundColor = UIColor.refreeColor.main
        $0.titleLabel?.font = .pretendard.bold15
    }
    
    let stackView = UIStackView().then {
        $0.axis = .vertical
        $0.distribution = .fill
        $0.alignment = .fill
        let nicknameView = UIView()
        $0.setCustomSpacing(23, after: nicknameView)
    }
    
    let emailValidityCheckButton = UIImageView().then {
            $0.image = UIImage(named: "CircleCheck")
            $0.contentMode = .scaleAspectFit
            $0.isHidden = true
        }
    
    let passwordCheckButton = UIImageView().then {
            $0.image = UIImage(named: "CircleCheck")
            $0.contentMode = .scaleAspectFit
            $0.isHidden = true
        }
    
    let confirmpPasswordCheckButton = UIImageView().then {
            $0.image = UIImage(named: "CircleCheck")
            $0.contentMode = .scaleAspectFit
            $0.isHidden = true
        }
    
    let nicknameCheckButton = UIImageView().then {
            $0.image = UIImage(named: "CircleCheck")
            $0.contentMode = .scaleAspectFit
            $0.isHidden = true
        }
    
    let passwordErrorButton = UIImageView().then {
        $0.image = UIImage(named: "CircleX")
        $0.contentMode = .scaleAspectFit
        $0.isHidden = true
    }
    
    let borderView = UIView().then {
        $0.backgroundColor = UIColor.refreeColor.text1
    }
    
    let logInButton = UIButton().then {
        $0.setTitle("이미 계정이 있으신가요? Log In", for: .normal)
        $0.setTitleColor(UIColor.refreeColor.text1, for: .normal)
        $0.titleLabel?.font = .pretendard.extraLight12
    }
    
    private var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.gradientBackground(type: .mainConic)
        config()
        bind()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    
    private func config(){
        layout()
    }
    
    private func layout(){
        view.addSubviews([
            signUpImageView1,
            signUpImageView2,
            signUpContainerView,
            signUpLabel,
            emailTextField,
            stackView,
            borderView,
            logInButton
        ])
        
        emailView.addSubviews([
            emailTextField,
            emailLabel,
            emailValidityCheckButton,
        ])
        passwordView.addSubviews([
            passwordTextField,
            passwordCheckButton
        ])
        
        confirmPasswordView.addSubviews([
            confirmPasswordTextField,
            confirmPasswordLabel,
            passwordErrorButton,
            confirmpPasswordCheckButton
        ])
        
        nicknameView.addSubviews([
            nicknameTextField,
            nicknameCheckButton
        ])
        
        stackView.addArrangedSubviews([
            emailView,
            passwordView,
            confirmPasswordView,
            nicknameView,
            createAccountButton
        ])
        
        signUpImageView1.snp.makeConstraints{ make in
            make.width.equalTo(144)
            make.height.equalTo(140)
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(40)
            make.leading.equalTo(self.view.safeAreaLayoutGuide.snp.leading).offset(24)
        }
        
        signUpImageView2.snp.makeConstraints{ make in
            make.width.equalTo(144)
            make.height.equalTo(140)
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(40)
            make.trailing.equalTo(self.view.safeAreaLayoutGuide.snp.trailing).offset(-24)
        }
        
        signUpContainerView.snp.makeConstraints { make in
            make.height.equalToSuperview().dividedBy(2)
            make.top.equalTo(signUpImageView1.snp.bottom).offset(7)
            make.leading.equalTo(self.view.safeAreaLayoutGuide.snp.leading).offset(35)
            make.trailing.equalTo(self.view.safeAreaLayoutGuide.snp.trailing).offset(-35)
        }
        
        signUpContainerView.layer.cornerRadius = 26
        signUpContainerView.layer.borderWidth = 5
        signUpContainerView.layer.borderColor = UIColor.clear.cgColor
        signUpContainerView.layer.masksToBounds = false
        signUpContainerView.layer.shadowColor = UIColor.gray.cgColor
        signUpContainerView.layer.shadowOffset = CGSize(width: 0, height: 4)
        signUpContainerView.layer.shadowOpacity = 1
        signUpContainerView.layer.shadowRadius = 4
        
        
        emailTextField.layer.cornerRadius = 13
        emailTextField.layer.masksToBounds = true
        
        passwordTextField.layer.cornerRadius = 13
        passwordTextField.layer.masksToBounds = true
        
        confirmPasswordTextField.layer.cornerRadius = 13
        confirmPasswordTextField.layer.masksToBounds = true
        
        nicknameTextField.layer.cornerRadius = 13
        nicknameTextField.layer.masksToBounds = true
        
        createAccountButton.layer.cornerRadius = 13
        createAccountButton.layer.masksToBounds = true
 
        signUpLabel.snp.makeConstraints { make in
            make.top.equalTo(signUpContainerView.snp.top).offset(23)
            make.leading.equalTo(signUpContainerView.snp.leading).offset(31)
        }
        
        emailView.snp.makeConstraints { make in
            make.height.equalTo(55)
            make.width.equalTo(signUpContainerView).multipliedBy(274.0 / 323.0)
        }
        
        passwordView.snp.makeConstraints { make in
            make.height.equalTo(55)
            make.width.equalTo(signUpContainerView).multipliedBy(274.0 / 323.0)
        }
        
        confirmPasswordView.snp.makeConstraints { make in
            make.height.equalTo(55)
            make.width.equalTo(signUpContainerView).multipliedBy(274.0 / 323.0)
        }
        
        nicknameView.snp.makeConstraints { make in
            make.height.equalTo(55)
            make.width.equalTo(signUpContainerView).multipliedBy(274.0 / 323.0)
        }
        
        
        emailTextField.snp.makeConstraints { make in
            make.height.equalTo(30)
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview().offset(-28)
        }
        
        emailLabel.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(4)
            make.leading.equalTo(emailTextField.snp.leading).offset(9)
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.height.equalTo(30)
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview().offset(-28)
        }
        
        confirmPasswordTextField.snp.makeConstraints { make in
            make.height.equalTo(30)
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview().offset(-28)
        }
        
        confirmPasswordLabel.snp.makeConstraints { make in
            make.top.equalTo(confirmPasswordTextField.snp.bottom).offset(4)
            make.leading.equalTo(emailTextField.snp.leading).offset(9)
        }
        
        nicknameTextField.snp.makeConstraints { make in
            make.height.equalTo(30)
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview().offset(-28)
        }
        
        stackView.snp.makeConstraints { make in
            make.top.equalTo(signUpLabel.snp.bottom).offset(23)
            make.leading.equalTo(signUpContainerView.snp.leading).offset(29)
        }
        
        emailValidityCheckButton.snp.makeConstraints { make in
            make.width.height.equalTo(22)
            make.centerY.equalTo(emailTextField)
            make.trailing.equalToSuperview()
        }
        
        passwordErrorButton.snp.makeConstraints { make in
            make.width.height.equalTo(22)
            make.centerY.equalTo(confirmPasswordTextField)
            make.trailing.equalToSuperview()
        }
        
        passwordCheckButton.snp.makeConstraints { make in
            make.width.height.equalTo(22)
            make.centerY.equalTo(passwordTextField)
            make.trailing.equalToSuperview()
        }
        
        confirmpPasswordCheckButton.snp.makeConstraints { make in
            make.width.height.equalTo(22)
            make.centerY.equalTo(confirmPasswordTextField)
            make.trailing.equalToSuperview()
        }
        
        nicknameCheckButton.snp.makeConstraints { make in
            make.width.height.equalTo(22)
            make.centerY.equalTo(nicknameTextField)
            make.trailing.equalToSuperview()
        }
        
        createAccountButton.snp.makeConstraints { make in
            make.height.equalTo(30)
            make.width.equalTo(signUpContainerView).multipliedBy(274.0 / 323.0)
            make.leading.equalToSuperview()
        }
        
        borderView.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.bottom.equalTo(signUpContainerView.snp.bottom).offset(-60)
            make.width.equalTo(createAccountButton)
            make.leading.equalTo(createAccountButton)
            make.trailing.equalTo(createAccountButton)
        }
        
        logInButton.snp.makeConstraints { make in
            make.top.equalTo(borderView.snp.bottom).offset(2)
            make.leading.equalTo(borderView.snp.leading).offset(16)
        }
    }
    
    private func bind() {
        logInButton.rx.tap
            .bind { [weak self] _ in
                self?.touchLoginButton()
            }
            .disposed(by: disposeBag)
    }
    
    private func touchLoginButton() {
        navigationController?.pushViewController(LogInViewController(), animated: true)
        navigationItem.backButtonTitle = "Sign"
    }
}
