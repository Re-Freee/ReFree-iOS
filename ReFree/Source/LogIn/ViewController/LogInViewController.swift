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

class LogInViewController: UIViewController {
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
    
    private let disposeBag = DisposeBag()
    
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
        logInButton.button.addTarget(self, action: #selector(logInButtonTapped), for: .touchUpInside)
        passwordFindButton.addTarget(self, action: #selector(passwordFindButtonTapped), for: .touchUpInside)
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
    }
    
    @objc func logInButtonTapped() {
        let tabBarController = HomeTabViewController()
        navigationController?.pushViewController(
            tabBarController,
            animated: true
        )
    }
    
    @objc func passwordFindButtonTapped() {
        
    }
}
