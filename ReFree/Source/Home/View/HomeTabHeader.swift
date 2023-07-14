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
        $0.backgroundColor = UIColor.refreeColor.button1
    }
    
    private let expiredFoodButton = UIButton().then {
        $0.setTitle("소비기한 만료 음식", for: .normal)
        $0.setTitleColor(UIColor.refreeColor.main, for: .normal)
        $0.backgroundColor = UIColor.refreeColor.button4
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        // 선택되지 않은 버튼(TEST)
        imminentFoodButton.addShadow(right: 0, down: 0, color: UIColor.gray, opacity: 0.3, radius: 8)
        // 선택된 버튼(TEST)
        expiredFoodButton.addShadow(right: 4, down: 4, color: UIColor.gray, opacity: 0.5, radius: 8)
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
        
        searchBar.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(Constant.spacing50)
            make.leading.trailing.equalToSuperview().inset(Constant.spacing24)
        }
        
        imminentFoodButton.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom).offset(Constant.spacing24)
            make.leading.equalToSuperview().offset(Constant.spacing24)
            make.trailing.equalTo(snp.centerX).offset(-4)
        }
        
        expiredFoodButton.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom).offset(Constant.spacing24)
            make.trailing.equalToSuperview().offset(-Constant.spacing24)
            make.leading.equalTo(snp.centerX).offset(4)
        }
    }
    
    // TODO: 소비기한 임박 음식 & 소비기한 만료 음식 버튼 그림자 설정
    private func foodButtonShadow(
        
    ) {
        
    }
    
    // TODO: 소비기한 임박 음식 & 소비기한 만료 음식 버튼 속성 설정
    private func foodButtonAttribute(
        
    ) {
        
    }
}
