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
        $0.setImage(UIImage(named: "arrow.forward"), for: .normal)
    }

    override func viewDidLoad() {
        view.gradientBackground(type: .mainConic)
        config()
    }
    
    private func config(){
        layout()
    }
    
    private func layout(){
        view.addSubviews([
            rocketImageView,
            registerCompleteLabel,
            continueButton
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
        
    }
}
