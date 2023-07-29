//
//  AlertView.swift
//  ReFree
//
//  Created by 이주훈 on 2023/07/29.
//

import UIKit
import SnapKit
import Then
import RxSwift
import RxGesture
import RxCocoa

final class AlertView: UIView {
    enum AlertType {
        case question
        case check
    }
    
    enum ButtonKind {
        case success
        case cancel
    }
    
    private let backgroundView = UIView().then {
        $0.layer.opacity = 0.8
        $0.backgroundColor = .black
    }
    
    private let alertBox = UIView().then {
        $0.backgroundColor = .refreeColor.background4
        $0.layer.cornerRadius = 15
    }
    
    private let titleLabel = UILabel().then {
        $0.textAlignment = .center
        $0.font = .pretendard.bold24
        $0.textColor = .black
    }
    
    private let descriptionLabel = UILabel().then {
        $0.numberOfLines = 5
        $0.textAlignment = .center
        $0.font = .pretendard.extraLight18
        $0.textColor = .black
    }
    
    let cancelButton = UIButton().then {
        let attrString = NSAttributedString(
            string: "아니요",
            attributes: [.font: UIFont.pretendard.bold16 ?? UIFont.systemFont(ofSize: 16)]
        )
        $0.setAttributedTitle(attrString, for: .normal)
        $0.backgroundColor = .refreeColor.background4
        $0.setTitleColor(.refreeColor.main, for: .normal)
        $0.layer.borderWidth = 2
        $0.layer.borderColor = UIColor.refreeColor.main.cgColor
        $0.layer.cornerRadius = 10
    }
    
    let successButton = UIButton().then {
        let attrString = NSAttributedString(
            string: "네",
            attributes: [.font: UIFont.pretendard.bold16 ?? UIFont.systemFont(ofSize: 16)]
        )
        $0.setAttributedTitle(attrString, for: .normal)
        $0.backgroundColor = .refreeColor.main
        $0.setTitleColor(.refreeColor.text3, for: .normal)
        $0.layer.borderWidth = 2
        $0.layer.borderColor = UIColor.refreeColor.main.cgColor
        $0.layer.cornerRadius = 10
    }
    
    private lazy var buttonStack = UIStackView(
        arrangedSubviews: [cancelButton, successButton]
    ).then {
        $0.distribution = .fillEqually
        $0.alignment = .fill
        $0.spacing = 8
        $0.axis = .horizontal
    }
    
    private var disposeBag = DisposeBag()
    private var alertType: AlertType
    
    init(title: String, description: String, alertType: AlertType = .question) {
        self.alertType = alertType
        super.init(frame: .zero)
        titleLabel.text = title
        descriptionLabel.text = description
        config()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layout()
    }
    
    private func config() {
        successButton.rx.tap
            .subscribe { [weak self] _ in
                self?.finishAlert()
            }.disposed(by: disposeBag)
        
        cancelButton.rx.tap
            .subscribe { [weak self] _ in
                self?.finishAlert()
            }.disposed(by: disposeBag)
        
        backgroundView.rx.tapGesture()
            .when(.recognized)
            .bind { [weak self] _ in
                self?.finishAlert()
            }
            .disposed(by: disposeBag)
    }
    
    private func layout() {
        if alertType == .check {
            buttonStack.removeArrangedSubview(cancelButton)
            let attrString = NSAttributedString(
                string: "확인했습니다!",
                attributes: [.font: UIFont.pretendard.bold16 ?? UIFont.systemFont(ofSize: 16)]
            )
            successButton.setAttributedTitle(attrString, for: .normal)
        }
        
        addSubviews([
            backgroundView,
            alertBox
        ])
        
        snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        alertBox.addSubviews([
            titleLabel,
            descriptionLabel,
            buttonStack
        ])
        
        backgroundView.snp.makeConstraints { 
            $0.edges.equalToSuperview()
        }
        
        alertBox.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(0.6)
        }
        
        titleLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(12)
            $0.top.equalToSuperview().inset(12)
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview().inset(12)
        }
        
        buttonStack.snp.makeConstraints {
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(12)
            $0.height.equalTo(40)
            $0.leading.trailing.bottom.equalToSuperview().inset(12)
        }
    }
    
    private func finishAlert() {
        removeFromSuperview()
    }
    
    func addAction(kind: ButtonKind, action: @escaping () -> ()) {
        switch kind {
        case .success:
            successButton.rx.tap
                .bind { _ in
                    action()
                }
                .disposed(by: disposeBag)
        case .cancel:
            cancelButton.rx.tap
                .bind { _ in
                    action()
                }
                .disposed(by: disposeBag)
        }
    }
}
