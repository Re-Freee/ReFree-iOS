//
//  SignUpCompleteViewController.swift
//  ReFree
//
//  Created by hwijinjeong on 2023/07/19.
//

import UIKit
import SnapKit
import Then

class SignUpCompleteViewController: UIViewController {
    private enum Constant {
        static let someViewSize = UIScreen.main.isWiderThan375pt ? CGSize(width: 290, height: 360) : CGSize(width: 260, height: 322)
      }
    
    let rocketImageView = UIImageView().then {
        $0.image = UIImage(named: "Rocket")
        $0.contentMode = .scaleAspectFit
    }
    
    let registerCompleteLabel = UILabel().then {
        $0.font = .pretendard.extraBold45
        $0.textColor = UIColor.refreeColor.main
        $0.text = "Registration\nComplete"
        $0.textAlignment = .center
        $0.lineBreakMode = .byWordWrapping
        $0.numberOfLines = 0
    }
    
    let continueButton = UIButton().then {
        $0.setTitle("Continue", for: .normal)
        $0.backgroundColor = UIColor.refreeColor.main
        $0.titleLabel?.font = .pretendard.bold15
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
        view.gradientBackground(type: .mainConic)
        config()
    }
    
    private func config(){
        layout()
//        addPaddingToButton()
    }
    
//    private func addPaddingToButton() {
//        if #available(iOS 15.0, *) {
//            var config = UIButton.Configuration.plain()
//            config.imagePadding = 30
//            config.titlePadding = 10
//            config.baseForegroundColor = .white
//            continueButton.configuration = config
//        } else {
//            continueButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 0)
//            continueButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 30)
//        }
//    }
    
    private func layout(){
        view.addSubviews([
            rocketImageView,
            registerCompleteLabel,
            continueButton,
            imageView
        ])
        
        continueButton.layer.cornerRadius = 13
        continueButton.layer.masksToBounds = true
        
        rocketImageView.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide).offset(30)
            $0.leading.equalToSuperview().offset(50)
            $0.trailing.equalToSuperview().offset(-50)
            $0.size.equalTo(Constant.someViewSize)
        }
        
        registerCompleteLabel.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.top.equalTo(rocketImageView.snp.bottom)
        }
        
        continueButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(registerCompleteLabel.snp.bottom).offset(40)
            $0.leading.equalToSuperview().offset(70)
            $0.trailing.equalToSuperview().offset(-70)
            $0.height.equalTo(35)
        }
        
        imageView.snp.makeConstraints {
            $0.width.height.equalTo(20)
            $0.centerY.equalTo(continueButton.snp.centerY)
            $0.trailing.equalTo(continueButton.snp.trailing).offset(-10)
        }
    }
}
