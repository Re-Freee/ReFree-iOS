//
//  RecipeTabHeader.swift
//  ReFree
//
//  Created by 이주훈 on 2023/07/11.
//

import UIKit
import SnapKit
import Then

final class RecipeTabHeader: UIView {
    let sideBarToggleButton = UIButton().then {
        $0.setImage(UIImage(named: "HambergerButton"), for: .normal)
    }
    let bookmarkButton = BadgeButton(frame: .zero)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layout() {
        self.addSubviews(
            [
                sideBarToggleButton,
                bookmarkButton
            ]
        )
        
        sideBarToggleButton.snp.makeConstraints {
            $0.top.leading.equalToSuperview()
            $0.width.height.equalTo(Constant.spacing50)
        }
        
        bookmarkButton.snp.makeConstraints {
            $0.top.trailing.equalToSuperview()
            $0.width.height.equalTo(Constant.spacing50)
        }
    }
}
