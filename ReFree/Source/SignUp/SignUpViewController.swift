//
//  SignUpViewController.swift
//  ReFree
//
//  Created by hwijinjeong on 2023/07/14.
//

import UIKit
import SnapKit

class SignUpViewController: UIViewController {
    let rocketImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "Rocket")
        view.contentMode = .scaleAspectFill
        
        return view
    }()
    
    let signupContainerView = {
        let view = UIView()
        view.backgroundColor = .white
        
        return view
    }()
    
    let signUpLabel = {
        let label = UILabel()
        label.font = UIFont(name: "Pretendard", size: 30)
        label.font = .systemFont(ofSize: 30, weight: .bold)
        label.textColor = .black
        label.text = "Sign Up"
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
    
    
    
    lazy var stackView: UIStackView = {
            let stackView = UIStackView(arrangedSubviews: [emailView, passwordView, confirmPasswordView, nicknameView])
            stackView.axis = .vertical // default
            stackView.distribution = .fill // default
            stackView.alignment = .fill // default
            view.addSubview(stackView)

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
        view.addSubview(rocketImageView)
        view.addSubview(signupContainerView)
        view.addSubview(signUpLabel)
        view.addSubview(emailTextField)
        
        emailView.addSubview(emailTextField)
        emailView.addSubview(emailLabel)
        passwordView.addSubview(passwordTextField)
        confirmPasswordView.addSubview(confirmPasswordTextField)
        confirmPasswordView.addSubview(confirmPasswordLabel)
        nicknameView.addSubview(nicknameTextField)
        
        view.addSubview(stackView)
        
        rocketImageView.snp.makeConstraints{ make in
            make.width.equalTo(170)
            make.height.equalTo(164)
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(42)
            make.centerX.equalToSuperview()
        }
        
        signupContainerView.snp.makeConstraints { make in
            make.top.equalTo(rocketImageView.snp.bottom).offset(7)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).offset(-150)
            make.leading.equalTo(self.view.safeAreaLayoutGuide.snp.leading).offset(35)
            make.trailing.equalTo(self.view.safeAreaLayoutGuide.snp.trailing).offset(-35)
        }
        
        signupContainerView.layer.cornerRadius = 26
        
        signupContainerView.layer.borderWidth = 5
        signupContainerView.layer.borderColor = UIColor.clear.cgColor
        signupContainerView.layer.masksToBounds = false
        signupContainerView.layer.shadowColor = UIColor.gray.cgColor
        signupContainerView.layer.shadowOffset = CGSize(width: 0, height: 4)
        signupContainerView.layer.shadowOpacity = 1
        signupContainerView.layer.shadowRadius = 4
        
        signUpLabel.snp.makeConstraints { make in
            make.top.equalTo(signupContainerView.snp.top).offset(34)
            make.leading.equalTo(signupContainerView.snp.leading).offset(31)
        }
        
        stackView.snp.makeConstraints { make in
            make.top.equalTo(signUpLabel.snp.bottom).offset(30)
            
        }
        
        
    }
    


}

