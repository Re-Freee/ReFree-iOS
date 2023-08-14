//
//  AppInitViewController.swift
//  ReFree
//
//  Created by 이주훈 on 2023/08/02.
//

import UIKit
import SnapKit
import Then
import RxSwift
import RxGesture

final class AppInitViewController: UIViewController {
    private let logoImageView = UIImageView(
        image: UIImage(named: "LaunchImage.png")
    ).then {
        $0.contentMode = .scaleToFill
    }
    
    private let logoTitleLabel = UILabel().then {
        $0.textColor = .refreeColor.main
        $0.font = .pretendard.extraBold50
        $0.text = "Re:Free"
    }
    
    private let signInButton = UIButton().then {
        $0.layer.cornerRadius = 10
        $0.layer.maskedCorners = CACornerMask(arrayLiteral: .layerMinXMinYCorner, .layerMinXMaxYCorner)
        $0.backgroundColor = .refreeColor.button1
        $0.setTitle("Log In", for: .normal)
        $0.setTitleColor(.refreeColor.text3, for: .normal)
    }
    
    private let registerButton = UIButton().then {
        $0.layer.cornerRadius = 10
        $0.layer.maskedCorners = CACornerMask(arrayLiteral: .layerMaxXMinYCorner, .layerMaxXMaxYCorner)
        $0.backgroundColor = .refreeColor.button2
        $0.setTitle("Register", for: .normal)
        $0.setTitleColor(.refreeColor.text3, for: .normal)
    }
    
    private lazy var buttonStack = UIStackView(
        arrangedSubviews: [signInButton, registerButton]
    ).then {
        $0.distribution = .fillEqually
        $0.alignment = .fill
        $0.spacing = 0
        $0.axis = .horizontal
    }
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        config()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    
    private func config() {
        view.gradientBackground(type: .mainConic)
        configNavitaion()
        layout()
        bind()
    }
    
    private func configNavitaion() {
        navigationItem.backButtonTitle = "뒤로"
    }
    
    private func layout() {
        view.addSubviews([
            logoImageView,
            logoTitleLabel,
            buttonStack
        ])
        
        logoImageView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.equalTo(200)
            $0.height.equalTo(logoImageView.snp.width)
        }
        
        logoTitleLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(logoImageView.snp.bottom)
        }
        
        buttonStack.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(logoTitleLabel.snp.bottom).offset(50)
            $0.width.equalTo(250)
        }
    }
    
    private func bind() {
        signInButton.rx.tap
            .bind { [weak self] _ in
                let signInVC = LogInViewController()
                self?.navigationController?.pushViewController(signInVC, animated: true)
            }
            .disposed(by: disposeBag)
        
        registerButton.rx.tap
            .subscribe { [weak self] _ in
                let signAgreementVC = SignAgreementViewController()
                self?.navigationController?.pushViewController(signAgreementVC, animated: true)
            }
            .disposed(by: disposeBag)
    }
}
