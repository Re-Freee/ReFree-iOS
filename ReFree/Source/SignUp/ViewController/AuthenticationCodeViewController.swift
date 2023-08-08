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
        $0.font = .pretendard.extraBold30
        $0.textColor = UIColor.refreeColor.main
        $0.text = "ABC123"
        $0.textAlignment = .center
    }
    
    let continueButton = UIButton().then {
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
            authenticationImageView1,
            authenticationImageView2,
            authenticationContainerView,
            authenticaitionLabel,
            authenticationLongLabel,
            codeLabelContainerView,
            continueButton,
            imageView
            ])
        
        codeLabelContainerView.addSubview(codeLabel)
        
        authenticationImageView1.snp.makeConstraints{
            $0.width.equalTo(144)
            $0.height.equalTo(140)
            $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(40)
            $0.leading.equalTo(self.view.safeAreaLayoutGuide.snp.leading).offset(24)
        }
        
        authenticationImageView2.snp.makeConstraints{
            $0.width.equalTo(144)
            $0.height.equalTo(140)
            $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(40)
            $0.trailing.equalTo(self.view.safeAreaLayoutGuide.snp.trailing).offset(-24)
        }
        
        authenticationContainerView.snp.makeConstraints {
            $0.height.equalToSuperview().dividedBy(2.5)
            $0.top.equalTo(authenticationImageView1.snp.bottom).offset(7)
            $0.leading.equalTo(self.view.safeAreaLayoutGuide.snp.leading).offset(35)
            $0.trailing.equalTo(self.view.safeAreaLayoutGuide.snp.trailing).offset(-35)
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
            $0.leading.equalTo(authenticaitionLabel)
            $0.trailing.equalTo(authenticationContainerView.snp.trailing).offset(-20)
        }

        codeLabelContainerView.snp.makeConstraints {
            $0.height.equalTo(authenticationContainerView).dividedBy(4.5)
            $0.top.equalTo(authenticationLongLabel.snp.bottom).offset(20)
            $0.leading.trailing.equalTo(authenticationContainerView).inset(20)
        }

        codeLabel.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(20)
            $0.leading.trailing.equalToSuperview().inset(40)
        }
        
        continueButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(authenticationContainerView.snp.bottom).offset(-40)
            $0.leading.trailing.equalTo(authenticationContainerView).inset(40)
            $0.height.equalTo(30)
        }

        imageView.snp.makeConstraints {
            $0.width.height.equalTo(20)
            $0.centerY.equalTo(continueButton.snp.centerY)
            $0.trailing.equalTo(continueButton.snp.trailing).offset(-10)
        }
        
    }
    
    
    
}
