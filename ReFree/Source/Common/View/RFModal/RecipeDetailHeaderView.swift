//
//  RecipeDetailHeaderView.swift
//  ReFree
//
//  Created by 이주훈 on 2023/07/16.
//

import UIKit
import SnapKit
import Then
import RxSwift

final class RecipeDetailHeaderView: UICollectionReusableView, Identifiable {
    private let titleLabel = UILabel().then {
        $0.textAlignment = .center
        $0.numberOfLines = 0
        $0.textColor = .refreeColor.main
        $0.font = .pretendard.extraBold30
        $0.text = "돼지고기 김치찌개"
    }
    
    private let bookmarkButton = UIButton().then {
//        $0.tintColor = .refreeColor.main
        var config = UIButton.Configuration.plain()
        config.baseForegroundColor = .refreeColor.main
        config.image = UIImage(systemName: "heart")
        $0.configuration = config
    }
    
    private let ingredientTitle = UILabel().then {
        $0.font = .pretendard.bold20
        $0.textColor = .refreeColor.main
        $0.text = "재료"
    }
    
    private let ingredientsLists = UILabel().then {
        $0.numberOfLines = 0
        $0.textColor = .refreeColor.text1
        $0.font = .pretendard.extraLight12
        // TODO: 테스트 용 긴 문자열로 실제 정보 받을땐 제거 예정
        $0.text = "물(250ml 기준) 구매2컵. 돼지고기 찌개용 또는 목살 구매250g. 신김치 구매200g. 김칫국물 구매5큰술. 참기름 구매1작은술. 양파 구매1/2개. 청고추 구매2개. 대파물(250ml 기준) 구매2컵. 돼지고기 찌개용 또는 목살 구매250g. 신김치 구매200g. 김칫국물 구매5큰술. 참기름 구매1작은술. 양파 구매1/2개. 청고추 구매2개. 대파물(250ml 기준) 구매2컵. 돼지고기 찌개용 또는 목살 구매250g. 신김치 구매200g. 김칫국물 구매5큰술. 참기름 구매1작은술. 양파 구매1/2개. 청고추 구매2개. 대파물(250ml 기준) 구매2컵. 돼지고기 찌개용 또는 목살 구매250g. 신김치 구매200g. 김칫국물 구매5큰술. 참기름 구매1작은술. 양파 구매1/2개. 청고추 구매2개. 대파물(250ml 기준) 구매2컵. 돼지고기 찌개용 또는 목살 구매250g. 신김치 구매200g. 김칫국물 구매5큰술. 참기름 구매1작은술. 양파 구매1/2개. 청고추 구매2개. 대파물(250ml 기준) 구매2컵. 돼지고기 찌개용 또는 목살 구매250g. 신김치 구매200g. 김칫국물 구매5큰술. 참기름 구매1작은술. 양파 구매1/2개. 청고추 구매2개. 대파"
    }
    
    private let recipeTitle = UILabel().then {
        $0.font = .pretendard.bold20
        $0.textColor = .refreeColor.main
        $0.text = "조리순서"
    }
    
    private var isBookmarked: Bool = false {
        didSet {
            bookmarkButton.updateConfiguration()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        config()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func config() {
        bookmarkButton.configurationUpdateHandler = {
            var config = UIButton.Configuration.plain()
            config.image = self.isBookmarked
            ? UIImage(systemName: "heart.fill") : UIImage(systemName: "heart")
            
            $0.configuration = config
        }
        
        layout()
    }
    
    private func layout() {
        addSubviews([
            titleLabel,
            bookmarkButton,
            ingredientTitle,
            ingredientsLists,
            recipeTitle
        ])
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(48)
            $0.centerX.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(0.6)
        }
        
        bookmarkButton.snp.makeConstraints {
            $0.top.equalToSuperview().inset(48)
            $0.trailing.equalToSuperview().inset(12)
        }
        
        ingredientTitle.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(24)
            $0.leading.trailing.equalToSuperview()
        }
        
        ingredientsLists.snp.makeConstraints {
            $0.top.equalTo(ingredientTitle.snp.bottom).offset(12)
            $0.leading.equalToSuperview().offset(24)
            $0.trailing.equalToSuperview().offset(-24)
        }
        
        recipeTitle.snp.makeConstraints {
            $0.top.equalTo(ingredientsLists.snp.bottom).offset(12)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-12)
        }
    }
}
