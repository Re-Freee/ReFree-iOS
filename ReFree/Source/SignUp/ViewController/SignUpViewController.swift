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
        $0.image = UIImage(named: "Thread")
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
        $0.isSecureTextEntry = true
        $0.textContentType = .oneTimeCode
    }
    
    let passwordLabel = UILabel().then {
        $0.font = .pretendard.extraLight12
        $0.textColor = UIColor.refreeColor.red
        $0.text = "비밀번호는 8자 이상 입력하셔야 합니다."
        $0.textAlignment = .center
        $0.isHidden = true
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
        $0.isSecureTextEntry = true
        $0.textContentType = .oneTimeCode
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
    
    let nicknameLabel = UILabel().then {
        $0.font = .pretendard.extraLight12
        $0.textColor = UIColor.refreeColor.red
        $0.text = "닉네임은 2~8자 이내로 입력하셔야 합니다."
        $0.textAlignment = .center
        $0.isHidden = true
    }
    
    let createAccountButton = UIButton().then {
        $0.setTitle("Create Account", for: .normal)
        $0.backgroundColor = UIColor.refreeColor.main
        $0.titleLabel?.font = .pretendard.bold15
        $0.setTitleColor(UIColor.gray, for: .normal)
        $0.isEnabled = false
    }
    
//    createAccountButton.isEnabled = isEmailFormatValid && isPasswordFormatValid && isPasswordsMatch && isNicknameFormatValid
//    createAccountButton.setTitleColor(createAccountButton.isEnabled ? UIColor.white : UIColor.gray, for: .normal)
    
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
    
    let confirmPasswordErrorButton = UIImageView().then {
        $0.image = UIImage(named: "CircleX")
        $0.contentMode = .scaleAspectFit
        $0.isHidden = true
    }
    
    let nicknameErrorButton = UIImageView().then {
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
    private let signRepository = SignRepository()
    
    
    private func isEmailValid(_ email: String) -> Bool {
        // 간단한 이메일 유효성 검사를 수행하는 함수
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
    
    private func isPasswordValid(_ password: String) -> Bool {
        // 비밀번호가 8자 이상인지 검사하는 함수
        return password.count >= 8
    }
    
    private func isNicknameValid(_ nickname: String) -> Bool {
        // 닉네임이 2~8자인지 검사하는 함수
        return nickname.count >= 2 && nickname.count <= 8
    }
    
    // 두 텍스트필드 문자가 같은 지 확인
    func isSameBothTextField(_ first: UITextField,_ second: UITextField) -> Bool {
        if(first.text == second.text) {
            return true
        } else {
            return false
        }
    }
    
    
    @objc func TFdidChanged(_ sender: UITextField) {    
        // 이메일 유효성 검사
        if sender == emailTextField {
            emailValidityCheckButton.isHidden = !isEmailValid(sender.text ?? "")
        }
        
        // 비밀번호 유효성 검사
        if sender == passwordTextField {
            passwordCheckButton.isHidden = isPasswordValid(sender.text ?? "")
            
            // 비밀번호 길이 검사
            if passwordTextField.text?.count ?? 0 < 8 {
                passwordCheckButton.isHidden = true
            } else {
                // 비밀번호 확인 일치 여부 검사
                if isSameBothTextField(passwordTextField, confirmPasswordTextField) {
                    confirmpPasswordCheckButton.isHidden = false
                    confirmPasswordLabel.isHidden = true
                    confirmPasswordErrorButton.isHidden = true
                } else {
                    confirmpPasswordCheckButton.isHidden = true
                    confirmPasswordLabel.isHidden = false
                    confirmPasswordErrorButton.isHidden = false
                }
                passwordCheckButton.isHidden = false // 비밀번호가 8자 이상인 경우에만 활성화
            }
        }
        
        if sender == confirmPasswordTextField {
            if confirmPasswordTextField.text?.isEmpty ?? true {
                confirmPasswordErrorButton.isHidden = true
                confirmpPasswordCheckButton.isHidden = true
                confirmPasswordLabel.isHidden = true
            } else {
                if isSameBothTextField(passwordTextField, confirmPasswordTextField) {
                    confirmPasswordErrorButton.isHidden = true
                    confirmpPasswordCheckButton.isHidden = false
                    confirmPasswordLabel.isHidden = true
                    confirmPasswordErrorButton.isHidden = true
                } else {
                    confirmPasswordErrorButton.isHidden = false
                    confirmpPasswordCheckButton.isHidden = true
                    confirmPasswordLabel.isHidden = false
                    confirmPasswordErrorButton.isHidden = false
                }
            }
        }
        
        // 닉네임 유효성 검사
        if sender == nicknameTextField {
            nicknameCheckButton.isHidden = isNicknameValid(sender.text ?? "")
            
            if let nickname = sender.text, nickname.count >= 2 && nickname.count <= 8 {
                nicknameCheckButton.isHidden = false
                nicknameErrorButton.isHidden = true
                nicknameLabel.isHidden = true
            } else {
                nicknameCheckButton.isHidden = true
                nicknameErrorButton.isHidden = false
                nicknameLabel.isHidden = false
            }
        }
        
        // 모든 조건을 만족할 경우에만 버튼 활성화
        updateNextButton()
    }
    
    //'Create Account' 버튼 활성화/비활성화
    private func updateNextButton() {
        // 각 필드의 유효성 검사 결과를 가져와서 버튼 활성화 여부 결정
        let isEmailFormatValid = isEmailValid(emailTextField.text ?? "")
        let isPasswordFormatValid = isPasswordValid(passwordTextField.text ?? "")
        let isPasswordsMatch = isSameBothTextField(passwordTextField, confirmPasswordTextField)
        let isNicknameFormatValid = isNicknameValid(nicknameTextField.text ?? "")
        
        // 모든 조건을 만족할 경우에만 버튼 활성화
        createAccountButton.isEnabled = isEmailFormatValid && isPasswordFormatValid && isPasswordsMatch && isNicknameFormatValid
        createAccountButton.setTitleColor(createAccountButton.isEnabled ? UIColor.white : UIColor.gray, for: .normal)
    }
    
    private func addKeyboardNotification() {
        NotificationCenter.default.addObserver(
          self,
          selector: #selector(keyboardWillShow),
          name: UIResponder.keyboardWillShowNotification,
          object: nil
        )
        
        NotificationCenter.default.addObserver(
          self,
          selector: #selector(keyboardWillHide),
          name: UIResponder.keyboardWillHideNotification,
          object: nil
        )
      }
    
    @objc private func keyboardWillShow(_ notification: Notification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            
            // 이메일 텍스트 필드에 포커스가 있는 경우에만 뷰를 올림
            if emailTextField.isFirstResponder {
                self.view.window?.frame.origin.y -= (keyboardHeight / 2)
            }
        }
    }

    @objc private func keyboardWillHide(_ notification: Notification) {
        if let _: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
//            let keyboardRectangle = keyboardFrame.cgRectValue
//            let keyboardHeight = keyboardRectangle.height
            self.view.window?.frame.origin.y = 0
        }
    }

    // 키보드 바깥을 클릭할 경우
    private var tapGestureRecognizer: UITapGestureRecognizer!
    
    @objc private func handleTapOutsideKeyboard() {
        view.endEditing(true)
    }
    
    private func ifTapOutside() {
        tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTapOutsideKeyboard))
        tapGestureRecognizer.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGestureRecognizer)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.gradientBackground(type: .mainConic)
        config()
        bind()
        
        signUpValidation()
        addKeyboardNotification()
        ifTapOutside()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    private func config(){
        layout()
    }
    
    private func signUpValidation(){
        emailTextField.delegate = self
        passwordTextField.delegate = self
        confirmPasswordTextField.delegate = self
        nicknameTextField.delegate = self
        
        emailTextField.addTarget(
            self,
            action: #selector(self.TFdidChanged(_:)),
            for: .editingChanged
        )
        passwordTextField.addTarget(
            self,
            action: #selector(self.TFdidChanged(_:)),
            for: .editingChanged
        )
        confirmPasswordTextField.addTarget(
            self,
            action: #selector(self.TFdidChanged(_:)),
            for: .editingChanged
        )
        nicknameTextField.addTarget(
            self,
            action: #selector(self.TFdidChanged(_:)),
            for: .editingChanged
        )
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
            passwordCheckButton,
            passwordLabel,
            passwordErrorButton
        ])
        
        confirmPasswordView.addSubviews([
            confirmPasswordTextField,
            confirmPasswordLabel,
            confirmPasswordErrorButton,
            confirmpPasswordCheckButton
        ])
        
        nicknameView.addSubviews([
            nicknameTextField,
            nicknameCheckButton,
            nicknameLabel,
            nicknameErrorButton
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
        
        passwordLabel.snp.makeConstraints {
            $0.top.equalTo(passwordTextField.snp.bottom).offset(4)
            $0.leading.equalTo(emailTextField.snp.leading).offset(9)
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
        
        nicknameLabel.snp.makeConstraints{
            $0.top.equalTo(nicknameTextField.snp.bottom).offset(4)
            $0.leading.equalTo(emailTextField.snp.leading).offset(9)
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
        
        passwordErrorButton.snp.makeConstraints{
            $0.width.height.equalTo(22)
            $0.centerY.equalTo(passwordTextField)
            $0.trailing.equalToSuperview()
        }
        
        confirmPasswordErrorButton.snp.makeConstraints { make in
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
        
        nicknameErrorButton.snp.makeConstraints { make in
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
        
        createAccountButton.rx.tap
            .bind { [weak self] in
                self?.touchCreatAccountButton()
            }
            .disposed(by: disposeBag)
    }
    
    private func touchLoginButton() {
        let loginVC = LogInViewController()
        navigationController?.pushViewController(loginVC, animated: true)
        navigationItem.backButtonTitle = "회원가입"
    }
    
    private func touchCreatAccountButton() {
        guard
            let email = emailTextField.text,
            let password = passwordTextField.text,
            let checkPassword = confirmPasswordTextField.text,
            let nickName = nicknameTextField.text
        else {
            Alert.errorAlert(viewController: self, errorMessage: "채워주세요.")
            return
        }
        
        signRepository.request(
            signUp: .signUp(
                signUpData: SignUpData(
                    email: email,
                    password: password,
                    checkPassword: checkPassword,
                    nickName: nickName
                )
            )
        )
        .subscribe(onNext: { [weak self] (response, backupCode) in
            guard let self else { return }
            // 다 200이 정상인데 얘만 201이 정상.. 주의하기
            guard response.code == "201" else {
                Alert.errorAlert(viewController: self, errorMessage: response.message)
                return
            }
            
            let AuthenticationCodeVC = AuthenticationCodeViewController()
            AuthenticationCodeVC.codeLabel.text = backupCode
            self.navigationController?.pushViewController(AuthenticationCodeVC, animated: true)
        }, onError: { [weak self] error in
            guard let self else { return }
            Alert.errorAlert(
                viewController: self,
                errorMessage: error.localizedDescription
            )
        })
        .disposed(by: disposeBag)
    }
}

extension SignUpViewController: UITextFieldDelegate {
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    if textField == emailTextField {
      passwordTextField.becomeFirstResponder()
    } else if textField == passwordTextField {
        confirmPasswordTextField.becomeFirstResponder()
    } else if textField == confirmPasswordTextField {
        nicknameTextField.becomeFirstResponder()
    } else {
      nicknameTextField.resignFirstResponder()
    }
    return true
  }
}
