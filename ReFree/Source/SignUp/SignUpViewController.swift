//
//  SignUpViewController.swift
//  ReFree
//
//  Created by hwijinjeong on 2023/07/14.
//

import UIKit
import SnapKit
import RxSwift

class SignUpViewController: UIViewController {
    let signUpImageView1 = {
        let view = UIImageView()
        view.image = UIImage(named: "FourCircle")
        view.contentMode = .scaleAspectFit
        
        return view
    }()
    
    let signUpImageView2 = {
        let view = UIImageView()
        view.image = UIImage(named: "thread")
        view.contentMode = .scaleAspectFit
        
        return view
    }()
    
    let signUpContainerView = {
        let view = UIView()
        view.backgroundColor = .white
        
        return view
    }()
    
    let signUpLabel = {
        let label = UILabel()
        label.font = .pretendard.extraBold30
        label.textColor = UIColor.refreeColor.main
        label.text = "회원가입"
        label.textAlignment = .center
        
        return label
    }()
    
    let emailView = {
        let view = UIView()
        view.backgroundColor = .clear
        
        return view
    }()
    
    let emailTextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.textColor = .black
        textField.returnKeyType = .done
        textField.backgroundColor = UIColor.refreeColor.textFrame
        textField.placeHolder(string: "이메일", color: UIColor.refreeColor.text1)
        textField.font = .pretendard.extraLight12
        textField.borderStyle = .none
        textField.addLeftPadding()
        
        return textField
    }()
    
    let emailLabel = {
        let label = UILabel()
        label.font = .pretendard.extraLight12
        label.textColor = UIColor.refreeColor.red
        label.text = "이미 존재하는 계정입니다."
        label.textAlignment = .center
        label.isHidden = true
        
        return label
    }()
    
    let passwordView = {
        let view = UIView()
        view.backgroundColor = .clear
        
        return view
    }()
    
    let passwordTextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.textColor = .black
        textField.returnKeyType = .done
        textField.backgroundColor = UIColor.refreeColor.textFrame
        textField.placeHolder(string: "비밀번호", color: UIColor.refreeColor.text1)
        textField.font = .pretendard.extraLight12
        textField.borderStyle = .none
        textField.addLeftPadding()
        
        return textField
    }()
    
    let confirmPasswordView = {
        let view = UIView()
        view.backgroundColor = .clear
        
        return view
    }()
    
    let confirmPasswordTextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.textColor = .black
        textField.returnKeyType = .done
        textField.backgroundColor = UIColor.refreeColor.textFrame
        textField.placeHolder(string: "비밀번호 확인", color: UIColor.refreeColor.text1)
        textField.font = .pretendard.extraLight12
        textField.borderStyle = .none
        textField.addLeftPadding()
        
        return textField
    }()
    
    let confirmPasswordLabel = {
        let label = UILabel()
        label.font = .pretendard.extraLight12
        label.textColor = UIColor.refreeColor.red
        label.text = "비밀번호가 일치하지 않습니다."
        label.textAlignment = .center
        label.isHidden = true
        
        return label
    }()
    
    let nicknameView = {
        let view = UIView()
        view.backgroundColor = .clear
        
        return view
    }()
    
    let nicknameTextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.textColor = .black
        textField.returnKeyType = .done
        textField.backgroundColor = UIColor.refreeColor.textFrame
        textField.placeHolder(string: "닉네임", color: UIColor.refreeColor.text1)
        textField.font = .pretendard.extraLight12
        textField.borderStyle = .none
        textField.addLeftPadding()
        
        return textField
    }()
    
    let createAccountButton = {
        let button = UIButton()
        button.setTitle("Create Account", for: .normal)
        button.backgroundColor = UIColor.refreeColor.main
        button.titleLabel?.font = .pretendard.bold15
        
        return button
    }()
    
    let stackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        let nicknameView = UIView()
        stackView.setCustomSpacing(23, after: nicknameView)

        return stackView
    }()
    
    let emailValidityCheckButton = {
            let view = UIImageView()
            view.image = UIImage(named: "CircleCheck")
            view.contentMode = .scaleAspectFit
            view.isHidden = true
            
            return view
        }()
    
    let passwordCheckButton = {
            let view = UIImageView()
            view.image = UIImage(named: "CircleCheck")
            view.contentMode = .scaleAspectFit
            view.isHidden = true
            
            return view
        }()
    
    let confirmpPasswordCheckButton = {
            let view = UIImageView()
            view.image = UIImage(named: "CircleCheck")
            view.contentMode = .scaleAspectFit
            view.isHidden = true
            
            return view
        }()
    
    let nicknameCheckButton = {
            let view = UIImageView()
            view.image = UIImage(named: "CircleCheck")
            view.contentMode = .scaleAspectFit
            view.isHidden = true
            
            return view
        }()
    
    let passwordErrorButton = {
        let view = UIImageView()
        view.image = UIImage(named: "CircleX")
        view.contentMode = .scaleAspectFit
        view.isHidden = true
        
        return view
    }()
    
    let borderView = {
        let view = UIView()
        view.backgroundColor = UIColor.refreeColor.text1
        
        return view
    }()
    
    let logInButton = {
        let button = UIButton()
        button.setTitle("이미 계정이 있으신가요? Log In", for: .normal)
        button.setTitleColor(UIColor.refreeColor.text1, for: .normal)
        button.titleLabel?.font = .pretendard.extraLight12
        
        return button
    }()
    
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
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview().offset(-28)
        }
        
        borderView.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.bottom.equalTo(signUpContainerView.snp.bottom).offset(-60)
            make.width.equalTo(createAccountButton)
            make.leading.equalTo(createAccountButton)
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
