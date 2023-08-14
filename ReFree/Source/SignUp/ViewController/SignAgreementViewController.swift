//
//  SignAgreementViewController.swift
//  ReFree
//
//  Created by 이주훈 on 2023/08/14.
//

import UIKit
import SnapKit
import Then
import RxSwift
import WebKit

final class SignAgreementViewController: UIViewController {
    private let titleLabel = UILabel().then {
        $0.textAlignment = .center
        $0.textColor = .refreeColor.main
        $0.font = .pretendard.extraBold30
        $0.text = "Re:Free 약관 동의"
    }
    
    private let whiteBackgroundView = UIView().then {
        $0.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        $0.layer.cornerRadius = 30
        $0.backgroundColor = .white
    }
    
    private lazy var totalAgreementButton = UIButton(
        configuration:  checkButtonConfiguration(isChecked: false)
    )
    
    private let totalAgreementLabel = UILabel().then {
        $0.textColor = .refreeColor.main
        $0.font = .pretendard.bold20
        $0.text = "전체 약관 모두 동의"
    }
    
    private lazy var serviceAgreementButton = UIButton(
        configuration:  checkButtonConfiguration(isChecked: false)
    )
    
    private let serviceAgreementLabel = UILabel().then {
        $0.textColor = .refreeColor.main
        $0.font = .pretendard.bold15
        $0.text = "서비스 이용 약관 동의 (필수)"
    }
    
    private lazy var showServicePolicyButton = UIButton(
        configuration: chevronButtonConfiguration()
    )
    
    private lazy var privacyAgreementButton = UIButton(
        configuration:  checkButtonConfiguration(isChecked: false)
    )
    
    private let privacyAgreementLabel = UILabel().then {
        $0.textColor = .refreeColor.main
        $0.font = .pretendard.bold15
        $0.text = "개인정보 처리 방침 (필수)"
    }
    
    private lazy var showPrivacyPolicyBuuton = UIButton(
        configuration: chevronButtonConfiguration()
    )
    
    private let continueButton = UIButton().then {
        $0.layer.cornerRadius = 20
        $0.setTitle("Continue", for: .normal)
        $0.backgroundColor = UIColor.refreeColor.main
        $0.titleLabel?.font = .pretendard.bold15
    }
    
    private let arrowImageView = UIImageView().then {
        let symbolName = "arrow.forward"
        let symbolConfig = UIImage.SymbolConfiguration(pointSize: 15.0, weight: .bold)
        let symbolImage = UIImage(systemName: symbolName, withConfiguration: symbolConfig)
        $0.image = symbolImage
        $0.contentMode = .scaleAspectFit
        $0.tintColor = .white
    }
    
    private var disposeBag = DisposeBag()
    private var isServicePolicyChecked = false
    private var isPrivacyPolicyChecked = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        config()
    }
    
    private func config() {
        layout()
        bind()
    }
    
    private func layout() {
        navigationItem.backButtonTitle = "Sign"
        layoutBackground()
        layoutWhiteBackground()
        layoutContinueButton()
    }
    
    private func layoutBackground() {
        view.gradientBackground(type: .mainConic)
        view.addSubviews([
            titleLabel,
            whiteBackgroundView
        ])
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(36)
            $0.leading.trailing.equalToSuperview()
        }
        
        whiteBackgroundView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(36)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.bottom.equalToSuperview()
        }
    }
    
    
    private func layoutWhiteBackground() {
        whiteBackgroundView.addSubviews([
            totalAgreementButton,
            totalAgreementLabel,
            serviceAgreementButton,
            serviceAgreementLabel,
            showServicePolicyButton,
            privacyAgreementButton,
            privacyAgreementLabel,
            showPrivacyPolicyBuuton,
            continueButton
        ])
        
        totalAgreementButton.snp.makeConstraints {
            $0.top.equalToSuperview().inset(24)
            $0.leading.equalToSuperview().inset(24)
            $0.width.height.equalTo(30)
        }
        
        totalAgreementLabel.snp.makeConstraints {
            $0.centerY.equalTo(totalAgreementButton.snp.centerY)
            $0.leading.equalTo(totalAgreementButton.snp.trailing).offset(20)
            $0.trailing.equalToSuperview().offset(24)
        }
        
        serviceAgreementButton.snp.makeConstraints {
            $0.top.equalTo(totalAgreementButton.snp.bottom).offset(60)
            $0.leading.equalToSuperview().inset(24)
            $0.width.height.equalTo(30)
        }
        
        serviceAgreementLabel.snp.makeConstraints {
            $0.centerY.equalTo(serviceAgreementButton.snp.centerY)
            $0.leading.equalTo(serviceAgreementButton.snp.trailing).offset(20)
        }
        
        showServicePolicyButton.snp.makeConstraints {
            $0.centerY.equalTo(serviceAgreementLabel.snp.centerY)
            $0.leading.equalTo(serviceAgreementLabel.snp.trailing)
            $0.trailing.equalToSuperview().inset(24)
            $0.width.height.equalTo(20)
        }
        
        privacyAgreementButton.snp.makeConstraints {
            $0.top.equalTo(serviceAgreementButton.snp.bottom).offset(30)
            $0.leading.equalToSuperview().inset(24)
            $0.width.height.equalTo(30)
        }
        
        privacyAgreementLabel.snp.makeConstraints {
            $0.centerY.equalTo(privacyAgreementButton.snp.centerY)
            $0.leading.equalTo(privacyAgreementButton.snp.trailing).offset(20)
        }
        
        showPrivacyPolicyBuuton.snp.makeConstraints {
            $0.centerY.equalTo(privacyAgreementLabel.snp.centerY)
            $0.leading.equalTo(privacyAgreementLabel.snp.trailing)
            $0.trailing.equalToSuperview().inset(24)
            $0.width.height.equalTo(20)
        }
        
        continueButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(48)
            $0.leading.trailing.equalToSuperview().inset(52)
            $0.height.equalTo(40)
        }
    }
    
    private func layoutContinueButton() {
        continueButton.addSubview(arrowImageView)
        
        arrowImageView.snp.makeConstraints {
            $0.width.height.equalTo(25)
            $0.centerY.equalTo(continueButton.snp.centerY)
            $0.trailing.equalTo(continueButton.snp.trailing).offset(-10)
        }
    }
    
    private func bind() {
        bindTotalAgreement()
        bindServiceAgreement()
        bindPrivacyAgreement()
        bindContinueButton()
    }
    
    private func bindTotalAgreement() {
        totalAgreementButton.rx.tap
            .bind(onNext: { [weak self] in
                guard let self else { return }
                if self.isServicePolicyChecked && self.isPrivacyPolicyChecked {
                    self.totalPolicyIsChecked(isChecked: false)
                } else {
                    self.totalPolicyIsChecked(isChecked: true)
                }
            })
            .disposed(by: disposeBag)
    }
    
    private func bindServiceAgreement() {
        serviceAgreementButton.rx.tap
            .bind(onNext: { [weak self] in
                guard let self else { return }
                self.isServicePolicyChecked = !self.isServicePolicyChecked
                self.serviceAgreementButton.configuration = checkButtonConfiguration(
                    isChecked: self.isServicePolicyChecked
                )
                checkTotalButtonConfiguration()
            })
            .disposed(by: disposeBag)
        
        Observable.merge(
            [
                showServicePolicyButton.rx.tap.map { _ in return Void() },
                serviceAgreementLabel.rx.tapGesture().when(.recognized).map { _ in return Void() }
            ]
        ).bind(onNext: { [weak self] _ in
            guard let self else { return }
            guard
                let url = URL(string: Network.servicePolicy),
                UIApplication.shared.canOpenURL(url)
            else {
                Alert.errorAlert(
                    viewController: self,
                    errorMessage: "약관을 확인할 수 없습니다.\n Instargram @refree._.official에 문의해주세요!"
                )
                return
            }
            self.navigationController?.pushViewController(
                RFWebViewController(url: url),
                animated: true
            )
        })
        .disposed(by: disposeBag)
    }
    
    private func bindPrivacyAgreement() {
        privacyAgreementButton.rx.tap
            .bind(onNext: { [weak self] in
                guard let self else { return }
                self.isPrivacyPolicyChecked = !self.isPrivacyPolicyChecked
                self.privacyAgreementButton.configuration = checkButtonConfiguration(
                    isChecked: self.isPrivacyPolicyChecked
                )
                checkTotalButtonConfiguration()
            })
            .disposed(by: disposeBag)
        
        Observable.merge(
            [
                showPrivacyPolicyBuuton.rx.tap.map { _ in return Void() },
                privacyAgreementLabel.rx.tapGesture().when(.recognized).map { _ in return Void() }
            ]
        )
        .bind(onNext: { [weak self] in
            guard let self else { return }
            guard
                let url = URL(string: Network.privacyPolicy),
                UIApplication.shared.canOpenURL(url)
            else {
                Alert.errorAlert(
                    viewController: self,
                    errorMessage: "약관을 확인할 수 없습니다.\n Instargram @refree._.official에 문의해주세요!"
                )
                return
            }
            self.navigationController?.pushViewController(
                RFWebViewController(url: url),
                animated: true
            )
        })
        .disposed(by: disposeBag)
    }
    
    private func bindContinueButton() {
        continueButton.rx.tap
            .bind(onNext: { [weak self] in
                guard let self else { return }
                if self.isServicePolicyChecked && self.isPrivacyPolicyChecked {
                    self.navigationController?.pushViewController(
                        SignUpViewController(),
                        animated: true
                    )
                } else {
                    Alert.checkAlert(
                        viewController: self,
                        title: "약관을 읽고 모두 동의해주세요.",
                        message: ""
                    )
                }
            })
            .disposed(by: disposeBag)
    }
    
    private func checkTotalButtonConfiguration() {
        if self.isServicePolicyChecked && self.isPrivacyPolicyChecked {
            totalAgreementButton.configuration = checkButtonConfiguration(isChecked: true)
        } else {
            totalAgreementButton.configuration = checkButtonConfiguration(isChecked: false)
        }
    }
    
    private func totalPolicyIsChecked(isChecked: Bool) {
        isServicePolicyChecked = isChecked
        isPrivacyPolicyChecked = isChecked
        totalAgreementButton.configuration = checkButtonConfiguration(isChecked: isChecked)
        serviceAgreementButton.configuration = checkButtonConfiguration(isChecked: isChecked)
        privacyAgreementButton.configuration = checkButtonConfiguration(isChecked: isChecked)
    }
}

extension SignAgreementViewController {
    typealias ButtonConfiguratioin = UIButton.Configuration
    
    func checkButtonConfiguration(isChecked: Bool) -> ButtonConfiguratioin {
        let image = isChecked ?
        UIImage(systemName: "checkmark.circle.fill") : UIImage(systemName: "checkmark.circle")
        
        var config = UIButton.Configuration.plain()
        config.imagePadding = 0
        config.image = image?.withTintColor(.refreeColor.main, renderingMode: .alwaysOriginal)
        
        return config
    }
    
    func chevronButtonConfiguration() -> ButtonConfiguratioin {
        let image = UIImage(systemName: "chevron.right")
        var config = UIButton.Configuration.plain()
        config.imagePadding = 0
        config.image = image?.withTintColor(.refreeColor.main, renderingMode: .alwaysOriginal)
        
        return config
    }
}
