//
//  AuthenticationCodeViewController.swift
//  ReFree
//
//  Created by hwijinjeong on 2023/08/08.
//

import UIKit
import SnapKit
import Then
import RxSwift

class AuthenticationCodeViewController: UIViewController {

    let authenticationImageView1 = UIImageView().then {
        $0.image = UIImage(named: "FourCircle")
        $0.contentMode = .scaleAspectFit
    }
    
    let authenticationImageView2 = UIImageView().then {
        $0.image = UIImage(named: "Thread")
        $0.contentMode = .scaleAspectFit
    }
    
    private lazy var authImageStack = UIStackView(
        arrangedSubviews: [authenticationImageView1, authenticationImageView2]
    ).then {
        $0.distribution = .equalSpacing
        $0.alignment = .center
        $0.axis = .horizontal
    }
    
    let authenticationContainerView = UIView().then {
        $0.backgroundColor = .white
    }
    
    let authenticaitionLabel = UILabel().then {
        $0.font = .pretendard.extraBold30
        $0.textColor = UIColor.refreeColor.main
        $0.text = "인증코드"
        $0.textAlignment = .center
    }
    
    let authenticationLongLabel = UILabel().then {
        $0.font = .pretendard.extraLight15
        $0.textColor = UIColor.refreeColor.main
        $0.lineBreakMode = .byWordWrapping
        $0.numberOfLines = 0
        $0.text = "비밀번호 분실 시 이 코드를 사용하여\n회원님의 계정에 다시 로그인할 수 있습니다.\n분실되지 않도록 안전한 곳에 코드를 저장하세요."
        $0.textAlignment = .left
    }
    
    let codeLabelContainerView = UIView().then {
        $0.backgroundColor = UIColor.refreeColor.textFrame
        $0.layer.cornerRadius = 13
        $0.layer.masksToBounds = true
    }
    
    let codeLabel = UILabel().then {
        $0.numberOfLines = 2
        $0.font = .pretendard.bold18
        $0.textColor = UIColor.refreeColor.main
        $0.text = "" // ex) abcdefgh-1234-1234-1234-1ejdk4kfje93
        $0.textAlignment = .center
    }
    
    private let copyButton = UIButton().then {
        $0.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
        $0.setTitle("Copy", for: .normal)
        $0.backgroundColor = UIColor.refreeColor.main
        $0.titleLabel?.font = .pretendard.bold15
        $0.layer.cornerRadius = 13
        $0.layer.masksToBounds = true
    }
    
    private let captureButton = UIButton().then {
        $0.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
        $0.setTitle("Save Image", for: .normal)
        $0.backgroundColor = UIColor.refreeColor.main
        $0.titleLabel?.font = .pretendard.bold15
        $0.layer.cornerRadius = 13
        $0.layer.masksToBounds = true
    }
    
    private lazy var buttonStack = UIStackView(
        arrangedSubviews: [copyButton, captureButton]
    ).then {
        $0.alignment = .fill
        $0.distribution = .fillEqually
        $0.spacing = 2
        $0.axis = .horizontal
    }
    
    private let continueButton = UIButton().then {
        $0.setTitle("Continue", for: .normal)
        $0.backgroundColor = UIColor.refreeColor.main
        $0.titleLabel?.font = .pretendard.bold15
        $0.layer.cornerRadius = 13
        $0.layer.masksToBounds = true
    }
    
    let imageView = UIImageView().then {
        let symbolName = "arrow.forward"
        let symbolConfig = UIImage.SymbolConfiguration(pointSize: 15.0, weight: .bold)
        let symbolImage = UIImage(systemName: symbolName, withConfiguration: symbolConfig)
        $0.image = symbolImage
        $0.contentMode = .scaleAspectFit
        $0.tintColor = .white
    }
    
    private var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.gradientBackground(type: .mainConic)
        config()
    }
    
    private func config(){
        layout()
        bind()
    }

    private func layout(){
        view.addSubviews([
            authImageStack,
            authenticationContainerView
            ])
        
        authenticationContainerView.addSubviews([
            authenticaitionLabel,
            authenticationLongLabel,
            codeLabelContainerView,
            buttonStack,
            continueButton
        ])
        
        codeLabelContainerView.addSubview(codeLabel)
        continueButton.addSubview(imageView)
        
        authImageStack.snp.makeConstraints {
            $0.bottom.equalTo(authenticationContainerView.snp.top).offset(-24)
            $0.leading.trailing.equalToSuperview().inset(35)
        }
        
        authenticationImageView1.snp.makeConstraints{
            $0.width.equalTo(144)
            $0.height.equalTo(140)
        }
        
        authenticationImageView2.snp.makeConstraints{
            $0.width.equalTo(144)
            $0.height.equalTo(140)
        }
        
        authenticationContainerView.snp.makeConstraints {
            $0.centerY.equalToSuperview().multipliedBy(1.1)
            $0.leading.trailing.equalToSuperview().inset(35)
        }
        
        authenticationContainerView.layer.cornerRadius = 26
        authenticationContainerView.layer.borderWidth = 5
        authenticationContainerView.layer.borderColor = UIColor.clear.cgColor
        authenticationContainerView.layer.masksToBounds = false
        authenticationContainerView.layer.shadowColor = UIColor.gray.cgColor
        authenticationContainerView.layer.shadowOffset = CGSize(width: 0, height: 4)
        authenticationContainerView.layer.shadowOpacity = 1
        authenticationContainerView.layer.shadowRadius = 4
        
        authenticaitionLabel.snp.makeConstraints {
            $0.top.equalTo(authenticationContainerView.snp.top).offset(30)
            $0.leading.equalTo(authenticationContainerView.snp.leading).offset(20)
        }
        
        authenticationLongLabel.snp.makeConstraints {
            $0.top.equalTo(authenticaitionLabel.snp.bottom).offset(10)
            $0.leading.equalTo(authenticaitionLabel.snp.leading)
            $0.trailing.equalTo(authenticationContainerView.snp.trailing).offset(-20)
        }

        codeLabelContainerView.snp.makeConstraints {
            $0.height.equalTo(100)
            $0.top.equalTo(authenticationLongLabel.snp.bottom).offset(20)
            $0.leading.trailing.equalTo(authenticationContainerView).inset(20)
        }

        codeLabel.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(20)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        
        buttonStack.snp.makeConstraints {
            $0.top.equalTo(codeLabelContainerView.snp.bottom).offset(24)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.height.equalTo(35)
        }
        
        continueButton.snp.makeConstraints {
            $0.top.equalTo(buttonStack.snp.bottom).offset(12)
            $0.height.equalTo(35)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.bottom.equalToSuperview().inset(24)
        }

        imageView.snp.makeConstraints {
            $0.width.height.equalTo(20)
            $0.centerY.equalTo(continueButton.snp.centerY)
            $0.trailing.equalTo(continueButton.snp.trailing).offset(-10)
        }
    }
    
    private func bind() {
        copyButton.rx.tap
            .bind(onNext: { [weak self] in
                guard let self else { return }
                guard
                    let backupCode = self.codeLabel.text
                else {
                    Alert.errorAlert(
                        viewController: self,
                        errorMessage: "복사에 실패했습니다."
                    )
                    return
                }
                UIPasteboard.general.string = backupCode
                Alert.checkAlert(
                    viewController: self,
                    title: "복사완료",
                    message: "인증코드를 클립보드에 복사했습니다."
                )
            })
            .disposed(by: disposeBag)
        
        captureButton.rx.tap
            .bind(onNext: { [weak self] in
                guard let self else { return}
                guard
                    let image = self.authenticationContainerView.transfromToImage()
                else {
                    Alert.errorAlert(
                        viewController: self,
                        errorMessage: "이미지 저장에 실패했습니다."
                    )
                    return
                }
                
                let activityVC = UIActivityViewController(
                    activityItems: [image],
                    applicationActivities: nil
                )
                activityVC.excludedActivityTypes = [.saveToCameraRoll]
                self.present(activityVC, animated: true)
            })
            .disposed(by: disposeBag)
        
        continueButton.rx.tap
            .bind(onNext: { [weak self] _ in
                let signUpCompleteVC = SignUpCompleteViewController()
                self?.navigationController?.pushViewController(signUpCompleteVC, animated: true)
            })
            .disposed(by: disposeBag)
    }
}
