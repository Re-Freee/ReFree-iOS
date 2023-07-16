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

final class RecipeDetailHeaderView: UITableViewHeaderFooterView, Identifiable {
    private let titleLabel = UILabel().then {
        $0.textColor = .refreeColor.main
        $0.font = .pretendard.extraBold30
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
    
//    private let textField
    
    private var isBookmarked: Bool = false {
        didSet {
            bookmarkButton.updateConfiguration()
        }
    }
    
    init( ) {
        super.init(reuseIdentifier: RecipeDetailHeaderView.identifier)
        config()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func config() {
        bookmarkButton.configurationUpdateHandler = {
            var config = UIButton.Configuration.plain()
            config.image = self.isBookmarked ? UIImage(systemName: "heart.fill") : UIImage(systemName: "heart")
            $0.configuration = config
        }
    }
}
