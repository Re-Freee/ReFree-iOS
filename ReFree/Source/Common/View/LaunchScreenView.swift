//
//  LaunchScreenView.swift
//  ReFree
//
//  Created by 이주훈 on 2023/07/21.
//

import UIKit
import SnapKit
import Then

final class LaunchScreenView: UIView {
    private let backgroundImageView = UIImageView(
        image: UIImage(named: "LaunchView")
    )
    private let logoImageView = UIImageView(
        image: UIImage(named: "LaunchImage.png")
    )
    private let logoTitleLabel = UILabel().then {
        $0.layer.opacity = 0
        $0.textColor = .refreeColor.main
        $0.font = .pretendard.extraBold50
        $0.text = "Re:Free"
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        config()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func config() {
        backgroundColor = .white
        gradientBackground(type: .mainConic)
        layout()
        layoutAnimation()
    }
    
    private func layout() {
        addSubviews([
            backgroundImageView,
        ])
        
        backgroundImageView.addSubviews([
            logoImageView,
            logoTitleLabel
        ])
        
        backgroundImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        logoImageView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.equalTo(200)
            $0.height.equalTo(195)
        }
        
        logoTitleLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(logoImageView.snp.bottom)
        }
    }
    
    private func layoutAnimation() {
        UIView.animate(withDuration: 2, delay: 0.5) { [weak self] in
            self?.logoTitleLabel.layer.opacity = 1
        } completion: { [weak self] _ in
            self?.removeView()
        }
    }
    
    private func removeView() {
        UIView.animate(withDuration: 0.5) { [weak self] in
            self?.layer.opacity = 0
        } completion: { [weak self] _ in
            self?.removeFromSuperview()
        }
    }
}
