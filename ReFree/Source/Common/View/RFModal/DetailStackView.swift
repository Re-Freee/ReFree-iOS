//
//  DetailStackView.swift
//  ReFree
//
//  Created by 이주훈 on 2023/07/14.
//

import UIKit
import SnapKit
import Then

final class DetailStackView: UIStackView {
    enum Kind: String {
        case category = "카테고리"
        case expire = "소비기한"
        case count = "수량"
    }
    
    private let titleLabel = UILabel().then {
        $0.textColor = .refreeColor.text1
        $0.font = .pretendard.bold18
        $0.textAlignment = .left
    }
    
    private let descriptionLabel = UILabel().then {
        $0.textColor = .refreeColor.text1
        $0.font = .pretendard.extraLight16
        $0.textAlignment = .right
        $0.text = "안녕"
    }
    
    private var kind: Kind
    
    init(kind: Kind, description: String? = nil) {
        self.kind = kind
        super.init(frame: .zero)
        titleLabel.text = kind.rawValue
        descriptionLabel.text = description
        axis = .horizontal
        distribution = .equalSpacing
        addArrangedSubviews([titleLabel, descriptionLabel])
        config()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func config() {
        // TODO: 각 타입별 Action 할당
        switch kind {
        case .category:
            break
        case .expire:
            break
        case .count:
            break
        }
    }
}
