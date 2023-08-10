//
//  SignUpCompleteViewController.swift
//  ReFree
//
//  Created by hwijinjeong on 2023/07/19.
//

import UIKit
import SnapKit
import Then
import RxSwift

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

    private var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        view.gradientBackground(type: .mainConic)
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
    
    private func config(){
        layout()
        bind()
    }
    
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
            $0.size.equalTo(Constant.someViewSize)
            $0.centerX.equalToSuperview()
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
    
    private func bind() {
        continueButton.rx.tap
            .bind { [weak self] in
                let signInVC = LogInViewController()
                self?.navigationController?.pushViewController(signInVC, animated: true)
            }
            .disposed(by: disposeBag)
    }
}
