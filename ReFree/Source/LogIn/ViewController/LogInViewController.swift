//
//  LogInViewController.swift
//  ReFree
//
//  Created by 김형석 on 2023/07/18.
//

import UIKit
import RxSwift

class LogInViewController: UIViewController {
    private let loginTab = LogInMainTab(frame: .zero)
    private var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        config()
    }
    
    private func config() {
        view.gradientBackground(type: .mainConic)
        layout()
        bind()
    }
    
    private func layout() {
        self.view.addSubview(loginTab)
        
        loginTab.snp.makeConstraints {
            $0.top.leading.bottom.trailing.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func bind() {
        loginTab.logInButton.rx
            .touchDownGesture()
            .when(.ended)
            .bind { [weak self] _ in
                self?.touchLoginButton()
            }
            .disposed(by: disposeBag)
    }
    
    private func touchLoginButton() {
        // TODO: 뷰 이동용 임시 Alert
        let alertVC = UIAlertController(
            title: "로그인 하실?",
            message: nil,
            preferredStyle: .alert
        )
        let login = UIAlertAction(
            title: "ㅇㅇ",
            style: .default) { [weak self] _ in
                self?.navigationController?.pushViewController(
                    HomeTabViewController(),
                    animated: true
                )
                self?.navigationController?.isNavigationBarHidden = true
            }
        alertVC.addAction(login)
        
        let cancel = UIAlertAction(
            title: "ㄴㄴ",
            style: .destructive
        )
        alertVC.addAction(cancel)
        
        present(alertVC, animated: true)
    }
}
