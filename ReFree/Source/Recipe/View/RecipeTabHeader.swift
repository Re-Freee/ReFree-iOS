//
//  RecipeTabHeader.swift
//  ReFree
//
//  Created by 이주훈 on 2023/07/11.
//

import UIKit
import SnapKit

final class RecipeTabHeader: UIView {
    private let sideBarToggleButton: UIButton = {
       let button = UIButton()
        button.setImage(UIImage(named: "hamberger_button"), for: .normal)
        
        return button
    }()
    
    private let bookmarkButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "heart"), for: .normal)
        
        return button
    }()
    
    private let searchBar = UISearchBar() // TODO: 커스텀 searchBar로 변경
    
    private let titleLabel: UILabel = {
       let label = UILabel()
        
        label.text = "OOO님을 위한 추천 레시피"
//        label.font = UIFont() // TODO: 폰트 수정 필요
        
        return label
    }()
    
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
                bookmarkButton,
                searchBar,
                titleLabel
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
        
        searchBar.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(Constant.spacing50)
            $0.top.equalTo(sideBarToggleButton.snp.bottom).inset(Constant.spacing12)
        }
        
        titleLabel.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.top.equalTo(searchBar.snp.bottom).offset(Constant.spacing50)
            $0.height.equalTo(Constant.spacing60)
        }
    }
}
