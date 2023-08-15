//
//  ExtendManualInfoView.swift
//  ReFree
//
//  Created by 이주훈 on 2023/08/13.
//

import UIKit
import SnapKit
import Then
import RxSwift
import RxGesture

final class ExtendManualInfoView: UIView {
    private let backgroundView = UIView().then {
        $0.layer.opacity = 0.7
        $0.backgroundColor = .black
    }
    
    private let infoBox = UIView().then {
        $0.backgroundColor = .refreeColor.background4
        $0.layer.cornerRadius = 15
    }
    
    private let imageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 15
        
    }
    
    private let descriptionLabel = UILabel().then {
        $0.numberOfLines = 0
        $0.textAlignment = .natural
        $0.font = .pretendard.bold18
        $0.textColor = .black
    }
    
    private let closeButton = UIButton().then {
        let attrString = NSAttributedString(
            string: "닫기",
            attributes: [.font: UIFont.pretendard.bold16 ?? UIFont.systemFont(ofSize: 16)]
        )
        $0.setAttributedTitle(attrString, for: .normal)
        $0.backgroundColor = .refreeColor.background3
        $0.setTitleColor(.refreeColor.main, for: .normal)
        $0.layer.borderWidth = 2
        $0.layer.borderColor = UIColor.refreeColor.main.cgColor
        $0.layer.cornerRadius = 10
    }
    
    private lazy var stack = UIStackView(
        arrangedSubviews: [
            imageView,
            descriptionLabel,
            closeButton
        ]
    ).then {
        $0.alignment = .fill
        $0.distribution = .equalSpacing
        $0.spacing = 12
        $0.axis = .vertical
    }
    
    private var disposeBag = DisposeBag()
    
    init(manual: Manual) {
        super.init(frame: .zero)
        config(manual: manual)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func config(manual: Manual) {
        closeButton.rx.tap
            .bind(onNext: { [weak self] in
                self?.finish()
            })
            .disposed(by: disposeBag)
        
        backgroundView.rx.tapGesture()
            .when(.recognized)
            .bind { [weak self] _ in
                self?.finish()
            }
            .disposed(by: disposeBag)
        
        imageView.kf.setImage(with: URL(string: manual.imageURL))
        descriptionLabel.text = manual.describe
    }
    
    private func layout() {
        addSubviews([backgroundView, infoBox])
        
        backgroundView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        infoBox.snp.makeConstraints {
            $0.width.equalToSuperview().multipliedBy(0.9)
            $0.center.equalToSuperview()
            $0.width.height.lessThanOrEqualToSuperview().multipliedBy(0.9)
        }
        
        infoBox.addSubviews([imageView, stack])
        
        imageView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview().inset(8)
            $0.height.equalTo(200)
        }
        
        stack.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(12)
            $0.leading.trailing.bottom.equalToSuperview().inset(8)
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.height.greaterThanOrEqualTo(50)
        }
        
        closeButton.snp.makeConstraints {
            $0.height.equalTo(50)
            $0.width.equalToSuperview()
        }
    }
    
    private func finish() {
        removeFromSuperview()
    }
}
