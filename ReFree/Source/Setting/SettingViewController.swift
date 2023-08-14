//
//  SettingViewController.swift
//  ReFree
//
//  Created by 이주훈 on 2023/08/14.
//

import UIKit
import SnapKit
import Then
import RxSwift

final class SettingViewController: UIViewController {
    private let titleLabel = UILabel().then {
        $0.textColor = .refreeColor.main
        $0.font = .pretendard.extraBold30
        $0.text = "설정"
    }
    
    private let logoutButton = UIButton().then {
        $0.setTitle("로그아웃", for: .normal)
        $0.backgroundColor = UIColor.refreeColor.main
        $0.titleLabel?.font = .pretendard.bold18
        $0.layer.cornerRadius = 15
        $0.layer.masksToBounds = true
    }
    
    private let withdrawButton = UIButton().then {
        $0.setTitle("회원 탈퇴", for: .normal)
        $0.backgroundColor = UIColor.refreeColor.main
        $0.titleLabel?.font = .pretendard.bold18
        $0.layer.cornerRadius = 15
        $0.layer.masksToBounds = true
    }
    
    private let signRepository = SignRepository()
    private let userRepository = UserRepository()
    private var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        config()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    private func config() {
        layout()
        bind()
    }
    
    private func layout() {
        view.gradientBackground(type: .mainAxial)
        view.addSubviews([
            titleLabel,
            logoutButton,
            withdrawButton
        ])
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.equalTo(view.safeAreaLayoutGuide).inset(24)
        }
        
        logoutButton.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(24)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(24)
            $0.height.equalTo(50)
        }
        
        withdrawButton.snp.makeConstraints {
            $0.top.equalTo(logoutButton.snp.bottom).offset(8)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(24)
            $0.height.equalTo(50)
        }
    }
    
    private func bind() {
        logoutButton.rx.tap
            .bind(onNext: { [weak self] in
                self?.logoutAlert()
            })
            .disposed(by: disposeBag)
        
        withdrawButton.rx.tap
            .bind(onNext: { [weak self] in
                self?.withdrawAlert()
            })
            .disposed(by: disposeBag)
    }
    
    private func logoutAlert() {
        let alert = AlertView(
            title: "로그아웃 하시겠습니까?",
            description: "",
            alertType: .question
        )
        
        alert.successButton.rx.tap
            .bind(onNext: { [weak self] in
                guard
                    let self,
                    let sceneDelegate = self.view.window?.windowScene?.delegate as? SceneDelegate
                else { return }
                self.userRepository.deleteUserNickName()
                try? KeyChain.shared.deleteToken(kind: .accessToken)
                Alert.checkAlert(
                    viewController: self,
                    title: "로그아웃 완료!",
                    message: ""
                )
                sceneDelegate.popToRootViewController()
            })
            .disposed(by: disposeBag)
        
        addsubViewToWindow(view: alert)
    }
    
    private func withdrawAlert() {
        let alert = AlertView(
            title: "회원 탈퇴를 하시겠습니까?",
            description: "회원 탈퇴 시 계정은 복구가 불가능합니다.",
            alertType: .question
        )
        
        alert.successButton.rx.tap
            .bind(onNext: { [weak self] in
                self?.withdrawRequest()
            })
            .disposed(by: disposeBag)
        
        addsubViewToWindow(view: alert)
    }
    
    private func withdrawRequest() {
        signRepository.request(withdrawUser: .withDraw)
            .subscribe(onNext: { [weak self] response in
                guard
                    let self,
                    self.responseCheck(response: response),
                    let sceneDelegate = self.view.window?.windowScene?.delegate as? SceneDelegate
                else { return }
                self.userRepository.deleteUserNickName()
                try? KeyChain.shared.deleteToken(kind: .accessToken)
                Alert.checkAlert(
                    viewController: self,
                    title: "회원 탈퇴 완료!",
                    message: "Re:Free를 다시 찾아주세요!"
                )
                sceneDelegate.popToRootViewController()
            }, onError: { [weak self] error in
                guard let self else { return }
                Alert.errorAlert(viewController: self, errorMessage: error.localizedDescription)
            })
            .disposed(by: disposeBag)
    }
}
