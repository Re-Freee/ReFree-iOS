//
//  SignUpViewController.swift
//  ReFree
//
//  Created by hwijinjeong on 2023/07/14.
//

import UIKit
import SnapKit

class SignUpViewController: UIViewController {
    let signUpImageView1 = {
        let view = UIImageView()
        view.image = UIImage(named: "four_circle")
        view.contentMode = .scaleAspectFill
        
        return view
    }()
    
    let signUpImageView2 = {
        let view = UIImageView()
        view.image = UIImage(named: "thread")
        view.contentMode = .scaleAspectFill
        
        return view
    }()
    
    let signUpContainerView = {
        let view = UIView()
        view.backgroundColor = .white
        
        return view
    }()
    
    let signUpLabel = {
        let label = UILabel()
        label.font = .pretendard.basic24
        label.font = .systemFont(ofSize: 30, weight: .bold)
        label.textColor = .black
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
        textField.placeholder = "이메일"
        textField.borderStyle = .roundedRect
        textField.textColor = .black
//        textField.returnKeyType = .done
        
        return textField
    }()
    
    let emailLabel = {
        let label = UILabel()
        label.font = UIFont(name: "Pretendard", size: 12)
        label.font = .systemFont(ofSize: 12)
        label.textColor = UIColor(red:208.0/255.0, green:0.0/255.0, blue:0.0/255.0, alpha:1.0)
        label.text = "이미 존재하는 계정입니다."
        label.textAlignment = .center
        
        return label
    }()
    
    let passwordView = {
        let view = UIView()
        view.backgroundColor = .clear
        
        return view
    }()
    
    let passwordTextField = {
        let textField = UITextField()
        textField.placeholder = "비밀번호"
        textField.borderStyle = .roundedRect
        textField.textColor = .black
//        textField.returnKeyType = .done
        
        return textField
    }()
    
    let confirmPasswordView = {
        let view = UIView()
        view.backgroundColor = .clear
        
        return view
    }()
    
    let confirmPasswordTextField = {
        let textField = UITextField()
        textField.placeholder = "비밀번호 확인"
        textField.borderStyle = .roundedRect
        textField.textColor = .black
//        textField.returnKeyType = .done
        
        return textField
    }()
    
    let confirmPasswordLabel = {
        let label = UILabel()
        label.font = UIFont(name: "Pretendard", size: 12)
        label.font = .systemFont(ofSize: 12)
        label.textColor = UIColor(red:208.0/255.0, green:0.0/255.0, blue:0.0/255.0, alpha:1.0)
        label.text = "비밀번호가 일치하지 않습니다."
        label.textAlignment = .center
        
        return label
    }()
    
    let nicknameView = {
        let view = UIView()
        view.backgroundColor = .clear
        
        return view
    }()
    
    let nicknameTextField = {
        let textField = UITextField()
        textField.placeholder = "닉네임"
        textField.borderStyle = .roundedRect
        textField.textColor = .black
//        textField.returnKeyType = .done
        
        return textField
    }()
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical // default
        stackView.distribution = .fill // default
        stackView.alignment = .fill // default

        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.gradientBackground(type: .mainConic)
        config()
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
            stackView
        ])
        
        signUpImageView1.snp.makeConstraints{ make in
            make.width.equalTo(144)
            make.height.equalTo(140)
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(50)
            make.leading.equalTo(self.view.safeAreaLayoutGuide.snp.leading).offset(24)
        }
        
        signUpImageView2.snp.makeConstraints{ make in
            make.width.equalTo(144)
            make.height.equalTo(140)
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(50)
            make.trailing.equalTo(self.view.safeAreaLayoutGuide.snp.trailing).offset(-24)
        }
        
        signUpContainerView.snp.makeConstraints { make in
            make.top.equalTo(signUpImageView1.snp.bottom).offset(7)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).offset(-150)
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
        
        signUpLabel.snp.makeConstraints { make in
            make.top.equalTo(signUpContainerView.snp.top).offset(34)
            make.leading.equalTo(signUpContainerView.snp.leading).offset(31)
        }
        
        emailView.addSubview(emailTextField)
        emailView.addSubview(emailLabel)
        passwordView.addSubview(passwordTextField)
        confirmPasswordView.addSubview(confirmPasswordTextField)
        confirmPasswordView.addSubview(confirmPasswordLabel)
        nicknameView.addSubview(nicknameTextField)
        
        stackView.addArrangedSubview(emailView)
        stackView.addArrangedSubview(passwordView)
        stackView.addArrangedSubview(confirmPasswordView)
        stackView.addArrangedSubview(nicknameView)
        
        emailView.snp.makeConstraints { make in
            make.height.equalTo(55)
            make.width.equalTo(246)
        }
        
        passwordView.snp.makeConstraints { make in
            make.height.equalTo(55)
            make.width.equalTo(246)
        }
        
        confirmPasswordView.snp.makeConstraints { make in
            make.height.equalTo(55)
            make.width.equalTo(246)
        }
        
        nicknameView.snp.makeConstraints { make in
            make.height.equalTo(55)
            make.width.equalTo(246)
        }
        
        
        emailTextField.snp.makeConstraints { make in
            make.height.equalTo(30)
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
        
        emailLabel.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(5)
            make.leading.equalTo(emailTextField.snp.leading).offset(9)
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.height.equalTo(30)
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
        
        confirmPasswordTextField.snp.makeConstraints { make in
            make.height.equalTo(30)
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
        
        confirmPasswordLabel.snp.makeConstraints { make in
            make.top.equalTo(confirmPasswordTextField.snp.bottom).offset(5)
            make.leading.equalTo(emailTextField.snp.leading).offset(9)
        }
        
        nicknameTextField.snp.makeConstraints { make in
            make.height.equalTo(30)
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
        
        stackView.snp.makeConstraints { make in
            make.top.equalTo(signUpLabel.snp.bottom).offset(23)
            make.leading.equalTo(signUpContainerView.snp.leading).offset(29)
            make.trailing.equalTo(signUpContainerView.snp.leading).offset(-48)
        }
        

        
    }
    


}

