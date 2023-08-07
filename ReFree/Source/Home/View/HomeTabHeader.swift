//
//  HomeTabHeader.swift
//  ReFree
//
//  Created by 김형석 on 2023/07/14.
//

import UIKit
import SnapKit
import Then

class HomeTabHeader: UIView {
    private let colors: [CGColor] = [
        UIColor.refreeColor.button5.cgColor,
        UIColor.refreeColor.button6.cgColor
    ]
    
    private let gradientLayer = CAGradientLayer()
    
    private let searchBar = RFSearchBar()
    
    public let imminentFoodButton = UIButton().then {
        $0.setTitle("소비기한 임박 음식", for: .normal)
        $0.setTitleColor(UIColor.refreeColor.main, for: .normal)
        $0.backgroundColor = UIColor.refreeColor.button2
    }
    
    public let expiredFoodButton = UIButton().then {
        $0.setTitle("소비기한 만료 음식", for: .normal)
        $0.setTitleColor(UIColor.refreeColor.main, for: .normal)
        $0.backgroundColor = UIColor.refreeColor.button3
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        config()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        setButtonShadow(button: imminentFoodButton)
        setButtonShadow(button: expiredFoodButton, isSelected: true)
        setGradientButtonLayer(button: imminentFoodButton)
    }
    
    private func config() {
        layout()
    }
    
    private func layout() {
        imminentFoodButton.layer.cornerRadius = imminentFoodButton.intrinsicContentSize.height / 2
        expiredFoodButton.layer.cornerRadius = expiredFoodButton.intrinsicContentSize.height / 2
        
        expiredFoodButton.layer.borderColor = UIColor.refreeColor.button3.cgColor
        
        self.addSubviews(
            [
                searchBar,
                imminentFoodButton,
                expiredFoodButton
            ]
        )
        
        searchBar.snp.makeConstraints {
            $0.top.equalToSuperview().offset(20)
            $0.leading.trailing.equalToSuperview().inset(Constant.spacing24)
        }
        
        imminentFoodButton.snp.makeConstraints {
            $0.top.equalTo(searchBar.snp.bottom).offset(Constant.spacing24)
            $0.leading.equalToSuperview().offset(Constant.spacing24)
            $0.trailing.equalTo(snp.centerX).offset(-1)
        }
        
        expiredFoodButton.snp.makeConstraints {
            $0.top.equalTo(searchBar.snp.bottom).offset(Constant.spacing24)
            $0.trailing.equalToSuperview().offset(-Constant.spacing24)
            $0.leading.equalTo(snp.centerX).offset(1)
        }
    }
    
    public func setButtonShadow(
        button:UIButton,
        isSelected: Bool = false
    ) {
        if !isSelected {
            button.addShadow(right: 0, down: 2, color: .gray, opacity: 0.6, radius: 8)
        } else {
            button.addShadow(right: 0, down: 0, color: .gray, opacity: 0.3, radius: 8)
        }
    }
    
    public func setGradientButtonLayer(
        button: UIButton,
        isApplied: Bool = false
    ) {
        if !isApplied {
            gradientLayer.frame = button.bounds
            gradientLayer.cornerRadius = button.layer.cornerRadius
            gradientLayer.colors = colors
            gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
            gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)
            gradientLayer.type = .axial
            
            let mask = CAShapeLayer()
            mask.lineWidth = 4
            mask.path = UIBezierPath(roundedRect: button.bounds, cornerRadius: button.layer.cornerRadius).cgPath
            mask.strokeColor = UIColor.black.cgColor
            mask.fillColor = UIColor.clear.cgColor
            
            gradientLayer.mask = mask
            button.layer.addSublayer(gradientLayer)
        } else {
            gradientLayer.removeFromSuperlayer()
        }
    }
}
