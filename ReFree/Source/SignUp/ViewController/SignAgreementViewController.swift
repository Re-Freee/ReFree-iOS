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
