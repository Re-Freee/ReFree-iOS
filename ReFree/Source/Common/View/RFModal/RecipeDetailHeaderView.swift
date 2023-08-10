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
        // TODO: Remove
        $0.text = "음식 이름"
    }
    
    let bookmarkButton = UIButton().then {
        var config = UIButton.Configuration.plain()
        config.baseForegroundColor = .refreeColor.main
        config.image = UIImage(systemName: "heart")?
            .withTintColor(.refreeColor.main, renderingMode: .alwaysOriginal)
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
        $0.text = "재료 목록"
    }
    
    private let recipeTitle = UILabel().then {
        $0.font = .pretendard.bold20
        $0.textColor = .refreeColor.main
        $0.text = "조리순서"
    }
    
    var isBookmarked: Bool = false {
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
            print("\(self.isBookmarked) 북마크드")
            let image = self.isBookmarked
            ? UIImage(systemName: "heart.fill") : UIImage(systemName: "heart")
            config.image = image?.withTintColor(.refreeColor.main, renderingMode: .alwaysOriginal)
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
    
    func configHeader(recipe: Recipe) {
        titleLabel.text = recipe.title
        ingredientsLists.text = recipe.ingredients
        
        let bookmarkImage = recipe.isHeart ?
        UIImage(systemName: "heart.fill") : UIImage(systemName: "heart")
        
        var config = UIButton.Configuration.plain()
        config.baseForegroundColor = .refreeColor.main
        config.image = bookmarkImage?
            .withTintColor(.refreeColor.main, renderingMode: .alwaysOriginal)
        bookmarkButton.configuration = config
    }
    
    func toggleBookmark(isHeart: Bool) {
        let currentIsHeart = !isHeart
        let bookmarkImage = currentIsHeart ?
        UIImage(systemName: "heart.fill") : UIImage(systemName: "heart")
        var config = UIButton.Configuration.plain()
        config.baseForegroundColor = .refreeColor.main
        config.image = bookmarkImage?
            .withTintColor(.refreeColor.main, renderingMode: .alwaysOriginal)
        bookmarkButton.configuration = config
    }
}
