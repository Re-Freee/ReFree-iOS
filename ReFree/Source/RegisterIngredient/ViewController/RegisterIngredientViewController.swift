//
//  RegisterIngredientViewController.swift
//  ReFree
//
//  Created by 이주훈 on 2023/07/29.
//

import UIKit
import SnapKit
import Then
import RxSwift

final class RegisterIngredientViewController: UIViewController {
    private let titleLabel = UILabel().then {
        $0.textColor = .refreeColor.main
        $0.font = .pretendard.extraBold30
        $0.text = "음식 추가"
    }
    private let cameraView = CameraView()
    private let ingredientInfoView = IngredientInfoView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.gradientBackground(type: .mainAxial)
        config()
    }
    
    private func config() {
        layout()
        bind()
    }
    
    private func layout() {
        view.addSubviews([titleLabel, cameraView, ingredientInfoView])
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview().inset(24)
        }
        
        cameraView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(24)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.height.equalTo(150)
        }
        
        ingredientInfoView.snp.makeConstraints {
            $0.top.equalTo(cameraView.snp.bottom).offset(12)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func bind() {
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}
