//
//  LogInViewController.swift
//  ReFree
//
//  Created by 김형석 on 2023/07/18.
//

import UIKit
import RxSwift
import SnapKit
import Then

class LogInViewController: UIViewController, UITextFieldDelegate {
    private var isEmailValidate = false
    private var isPasswordValidate = false
    
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
        $0.text = "로그인"
        $0.font = .pretendard.extraBold30
        $0.textColor = .refreeColor.main
    }
    
    private let logInEmailText = LogInTextField(message: "이메일", height: 40)
    
    private let logInPasswordText = LogInTextField(message: "비밀번호", isPassword: true, height: 40)
    
    private let logInButton = LogInButton(message: "Get started!", height: 40)
    
    private let passwordFindButton = UIButton().then {
        $0.setTitle("비밀번호를 잊으셨나요?", for: .normal)
        $0.setTitleColor(UIColor.refreeColor.text1, for: .normal)
        $0.titleLabel?.font = .pretendard.bold15
    }
    
    private let signRepository = SignRepository()
    private let joinMembershipButton = UIButton().then {
        $0.setTitle("회원가입", for: .normal)
        $0.setTitleColor(UIColor.refreeColor.text1, for: .normal)
        $0.titleLabel?.font = .pretendard.bold15
    }
    
    private let disposeBag = DisposeBag()
    private let userRepotiroy = UserRepository()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        config()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    
    private func config() {
        view.gradientBackground(type: .mainConic)
        configNavigation()
        layout()
        logInEmailText.textField.delegate = self
        logInPasswordText.textField.delegate = self
        
        logInButton.button.addTarget(self, action: #selector(logInButtonTapped), for: .touchUpInside)
        passwordFindButton.addTarget(self, action: #selector(passwordFindButtonTapped), for: .touchUpInside)
        joinMembershipButton.addTarget(self, action: #selector(joinMembershipButtonTapped), for: .touchUpInside)
        logInEmailText.textField.addTarget(self, action: #selector(logInEmailTextFieldDidChange(_:)), for: .editingChanged)
        logInPasswordText.textField.addTarget(self, action: #selector(logInPasswordTextFieldDidChange(_:)), for: .editingChanged)
    }
    
    private func configNavigation() {
        let backButton = UIBarButtonItem(
            title: "시작 화면으로",
            style: .plain,
            target: self,
            action: #selector(toRootViewController)
        )
        navigationItem.leftBarButtonItem = backButton
    }
    
    @objc private func toRootViewController() {
        navigationController?.popToRootViewController(animated: true)
    }
    
    private func layout() {
        view.addSubviews(
            [
                mainLogoImage,
                stackViewBackground,
                logInStackView,
                passwordFindButton,
                joinMembershipButton
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
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(100)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide)
        }
        
        stackViewBackground.snp.makeConstraints {
            $0.top.equalTo(mainLogoImage.snp.bottom).offset(Constant.spacing8)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(Constant.spacing24)
        }
        
        logInStackView.snp.makeConstraints {
            $0.top.equalTo(stackViewBackground.snp.top).offset(Constant.spacing24)
            $0.leading.equalTo(stackViewBackground.snp.leading).offset(32)
            $0.trailing.equalTo(stackViewBackground.snp.trailing).offset(-32)
        }
        
        passwordFindButton.snp.makeConstraints {
            $0.top.equalTo(stackViewBackground.snp.bottom).offset(Constant.spacing8)
            $0.leading.equalTo(logInStackView.snp.leading)
        }
        
        joinMembershipButton.snp.makeConstraints {
            $0.top.equalTo(stackViewBackground.snp.bottom).offset(Constant.spacing8)
            $0.trailing.equalTo(logInStackView.snp.trailing)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        logInEmailText.textField.resignFirstResponder()
        logInPasswordText.textField.resignFirstResponder()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case logInEmailText.textField:
            logInEmailText.textField.resignFirstResponder()
            logInPasswordText.textField.becomeFirstResponder()
        case logInPasswordText.textField:
            logInPasswordText.textField.resignFirstResponder()
            logInButtonTapped()
        default:
            view.endEditing(true)
        }
        
        textField.resignFirstResponder()
        
        return true
    }
    
    @objc func logInButtonTapped() {
        guard
            let id = logInEmailText.textField.text,
            let password = logInPasswordText.textField.text
        else {
            Alert.checkAlert(
                viewController: self,
                title: "확인해주세요!",
                message: "이메일과 비밀번호를 채워주세요!"
            )
            return
        }
        
        signRepository.request(signIn: .signIn(id: id, password: password))
            .subscribe(onNext: { [weak self] (response, token) in
                guard
                    let self,
                    self.responseCheck(response: response)
                else { return }
                
                self.userRepotiroy.deleteUserNickName()
                do {
                    try KeyChain.shared.deleteToken(kind: .accessToken)
                    try KeyChain.shared.addToken(kind: .accessToken, token: token)
                } catch {
                    Alert.errorAlert(
                        viewController: self,
                        errorMessage: error.localizedDescription
                    )
                }
                
                let tabBarController = HomeTabViewController()
                self.navigationController?.pushViewController(
                    tabBarController,
                    animated: true
                )
            }, onError: { error in
                Alert.errorAlert(
                    viewController: self,
                    errorMessage: error.localizedDescription
                )
            })
            .disposed(by: disposeBag)
    }
    
    @objc func passwordFindButtonTapped() {
        let emailSearchVC = EmailSearchViewController()
        navigationController?.pushViewController(
            emailSearchVC,
            animated: true
        )
    }
    
    @objc func joinMembershipButtonTapped() {
        let signAgreementVC = SignAgreementViewController()
        navigationController?.pushViewController(
            signAgreementVC,
            animated: true
        )
    }
    
    @objc func logInEmailTextFieldDidChange(_ textField: UITextField) {
        guard textField.text != nil && textField.text!.validateEmail() else {
            logInButton.button.setTitleColor(.refreeColor.text1, for: .normal)
            logInButton.button.isEnabled = false
            isEmailValidate = false
            return
        }
        
        isEmailValidate = true
        
        if isEmailValidate && isPasswordValidate {
            logInButton.button.setTitleColor(.refreeColor.text3, for: .normal)
            logInButton.button.isEnabled = true
        }
    }
    
    @objc func logInPasswordTextFieldDidChange(_ textField: UITextField) {
        guard textField.text != nil else {
            logInButton.button.setTitleColor(.refreeColor.text1, for: .normal)
            logInButton.button.isEnabled = false
            isPasswordValidate = false
            return
        }
        
        isPasswordValidate = true
        
        if isEmailValidate && isPasswordValidate {
            logInButton.button.setTitleColor(.refreeColor.text3, for: .normal)
            logInButton.button.isEnabled = true
        }
    }
}
