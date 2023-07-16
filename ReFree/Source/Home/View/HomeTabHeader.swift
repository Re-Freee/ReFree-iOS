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
    private let searchBar = RFSearchBar(height: 40)
    
    private let imminentFoodButton = UIButton().then {
        $0.setTitle("소비기한 임박 음식", for: .normal)
        $0.setTitleColor(UIColor.refreeColor.main, for: .normal)
        $0.backgroundColor = UIColor.refreeColor.button2
        $0.layer.borderColor = UIColor.refreeColor.button3.cgColor      // TODO: 소비기한 임박 & 만료 음식 버튼 선택시 경계 색깔 설정
        $0.layer.borderWidth = 1
    }
    
    private let expiredFoodButton = UIButton().then {
        $0.setTitle("소비기한 만료 음식", for: .normal)
        $0.setTitleColor(UIColor.refreeColor.main, for: .normal)
        $0.backgroundColor = UIColor.refreeColor.button3
        $0.layer.borderColor = UIColor.refreeColor.button3.cgColor
        $0.layer.borderWidth = 1
    }
    
    private var isImminentFoodButtonSelected: Bool = true
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
        
        imminentFoodButton.addTarget(self, action: #selector(imminentFoodButtonTapped), for: .touchUpInside)
        expiredFoodButton.addTarget(self, action: #selector(expiredFoodButtonTapped), for: .touchUpInside)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        imminentFoodButton.addShadow(right: 4, down: 4, color: UIColor.gray, opacity: 0.5, radius: 8)
        expiredFoodButton.addShadow(right: 0, down: 0, color: UIColor.gray, opacity: 0.2, radius: 8)
    }
    
    private func layout() {
        imminentFoodButton.layer.cornerRadius = imminentFoodButton.intrinsicContentSize.height / 2
        expiredFoodButton.layer.cornerRadius = expiredFoodButton.intrinsicContentSize.height / 2
        
        self.addSubviews(
            [
                searchBar,
                imminentFoodButton,
                expiredFoodButton
            ]
        )
        
        searchBar.snp.makeConstraints {
            $0.top.equalToSuperview().offset(Constant.spacing50)
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
    
    @objc private func imminentFoodButtonTapped() {
        if !isImminentFoodButtonSelected {
            imminentFoodButton.backgroundColor = UIColor.refreeColor.button2
            imminentFoodButton.layer.borderColor = UIColor.refreeColor.button3.cgColor      // TODO: 소비기한 임박 & 만료 음식 버튼 선택시 경계 색깔 설정
            expiredFoodButton.backgroundColor = UIColor.refreeColor.button3
            expiredFoodButton.layer.borderColor = UIColor.refreeColor.button3.cgColor
            
            imminentFoodButton.addShadow(right: 4, down: 4, color: UIColor.gray, opacity: 0.5, radius: 8)
            expiredFoodButton.addShadow(right: 0, down: 0, color: UIColor.gray, opacity: 0.2, radius: 8)
            
            isImminentFoodButtonSelected = true
        }
    }
    
    @objc private func expiredFoodButtonTapped() {
        if isImminentFoodButtonSelected {
            expiredFoodButton.backgroundColor = UIColor.refreeColor.button2
            expiredFoodButton.layer.borderColor = UIColor.refreeColor.button3.cgColor       // TODO: 소비기한 임박 & 만료 음식 버튼 선택시 경계 색깔 설정
            imminentFoodButton.backgroundColor = UIColor.refreeColor.button3
            imminentFoodButton.layer.borderColor = UIColor.refreeColor.button3.cgColor
            
            imminentFoodButton.addShadow(right: 0, down: 0, color: UIColor.gray, opacity: 0.2, radius: 8)
            expiredFoodButton.addShadow(right: 4, down: 4, color: UIColor.gray, opacity: 0.5, radius: 8)
            
            
            isImminentFoodButtonSelected = false
        }
    }
}
