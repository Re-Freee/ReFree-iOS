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
import RxGesture

final class RegisterIngredientViewController: UIViewController {
    private let scrollVIew = UIScrollView().then {
        $0.showsHorizontalScrollIndicator = false
    }
    private let scrollContentView = UIView()
    private let titleLabel = UILabel().then {
        $0.textColor = .refreeColor.main
        $0.font = .pretendard.extraBold30
        $0.text = "음식 추가"
    }
    private let cameraView = CameraView()
    private let ingredientInfoView = IngredientInfoView()
    
    private var disposeBag = DisposeBag()
    
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
        view.addSubview(scrollVIew)
        scrollVIew.addSubview(scrollContentView)
        scrollContentView.addSubviews([titleLabel, cameraView, ingredientInfoView])
        
        scrollVIew.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        scrollContentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalTo(Constant.screenSize.width)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
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
            $0.bottom.equalToSuperview()
        }
    }
    
    private func bind() {
        scrollVIew.rx.touchDownGesture()
            .when(.began)
            .bind { [weak self] _ in
                self?.view.endEditing(true)
            }
            .disposed(by: disposeBag)
        
        ingredientInfoView.saveButton.rx.tapGesture()
            .when(.recognized)
            .bind { [weak self] _ in
                let alert = AlertView(
                    title: "잠깐!",
                    description: "그대로 저장하시겠습니까?"
                )
                alert.addAction(kind: .success) {
                    print("저장!")
                }
                alert.addAction(kind: .cancel) {
                    print("취소!")
                }
                self?.view.addSubview(alert)
            }.disposed(by: disposeBag)
    }
}
