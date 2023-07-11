//
//  ViewController.swift
//  ReFree
//
//  Created by 이주훈 on 2023/07/01.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    let headerView = RecipeTabHeader(frame: .zero)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.gradientBackground(type: .mainAxial)
        
        view.addSubview(headerView)
        
        headerView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(Constant.spacing24)
            $0.top.equalTo(view.safeAreaLayoutGuide)
        }
    }
}
