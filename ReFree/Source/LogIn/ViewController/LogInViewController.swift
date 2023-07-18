//
//  LogInViewController.swift
//  ReFree
//
//  Created by 김형석 on 2023/07/18.
//

import UIKit

class LogInViewController: UIViewController {
    private let test = LogInMainTab(frame: .zero)

    override func viewDidLoad() {
        super.viewDidLoad()
        config()
    }
    
    private func config() {
        view.gradientBackground(type: .mainConic)
        layout()
    }
    
    private func layout() {
        self.view.addSubview(test)
        
        test.snp.makeConstraints {
            $0.top.leading.bottom.trailing.equalTo(view.safeAreaLayoutGuide)
        }
    }
}
