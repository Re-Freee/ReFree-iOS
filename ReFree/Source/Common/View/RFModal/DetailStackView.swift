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
    private let titleLabel = UILabel().then {
        $0.textAlignment = .left
    }
    private let descriptionLabel = UILabel().then {
        $0.textAlignment = .right
    }
    
    init(title: String, description: String? = nil) {
        super.init(frame: .zero)
        titleLabel.text = title
        descriptionLabel.text = description
        axis = .horizontal
        distribution = .equalSpacing
        addArrangedSubviews([titleLabel, descriptionLabel])
        
        snp.makeConstraints {
            $0.height.equalTo(50)
        }
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
