//
//  RefrigeratorTapHeader.swift
//  ReFree
//
//  Created by hwijinjeong on 2023/07/22.
//

import UIKit
import SnapKit
import Then

final class RefrigeratorTabHeader: UIView {
    private let titleLabel = UILabel().then {
        $0.textColor = .refreeColor.main
        $0.font = .pretendard.extraBold30
        $0.textAlignment = .left
        $0.text = "000님의 냉장고"
    }
    
    private let searchBar = RFSearchBar(height: 40)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layout() {
        self.addSubviews([
                titleLabel,
                searchBar
        ])

        titleLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview()
        }
        
        searchBar.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(titleLabel.snp.bottom).offset(Constant.spacing30)
        }
        
        
    }
}
