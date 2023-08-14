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
        $0.setTitle("회원탈퇴", for: .normal)
        $0.backgroundColor = UIColor.refreeColor.main
        $0.titleLabel?.font = .pretendard.bold18
        $0.layer.cornerRadius = 15
        $0.layer.masksToBounds = true
    }
    
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
        
    }
}
