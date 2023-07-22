//
//  LoadingView.swift
//  ReFree
//
//  Created by 이주훈 on 2023/07/23.
//

import UIKit
import SnapKit
import Then
import Lottie

final class LoadingView: UIView {
     private let loadingView = LottieAnimationView(name: "LoadingAnimation").then {
        $0.loopMode = .loop
        $0.play()
    }
    
    private let loadingLabel = UILabel().then {
        $0.textColor = .refreeColor.main
        $0.font = .pretendard.extraBold30
        $0.text = "Loading..."
        $0.textAlignment = .center
    }
    
    private let descriptionLabel = UILabel().then {
        $0.textColor = .refreeColor.main
        $0.font = .pretendard.bold18
        $0.numberOfLines = 3
        $0.text = "OOO님을 위한\n레시피를 추천드릴게요!"
        $0.textAlignment = .center
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layout() {
        addSubviews([
            loadingView,
            loadingLabel,
            descriptionLabel
        ])
        
        loadingView.snp.makeConstraints {
            $0.centerY.equalToSuperview().offset(-100)
            $0.centerX.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(0.6)
            $0.height.equalTo(loadingView.snp.width).multipliedBy(0.7)
        }
        
        loadingLabel.snp.makeConstraints {
            $0.top.equalTo(loadingView.snp.bottom)
            $0.centerX.equalToSuperview()
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(loadingLabel.snp.bottom).offset(50)
            $0.centerX.equalToSuperview()
        }
    }
    
    func setName(_ name: String) {
        descriptionLabel.text = "\(name)님을 위한\n레시피를 추천드릴게요!"
    }
    
    func play() {
        loadingView.play()
    }
    
    func stop() {
        loadingView.stop()
    }
}
