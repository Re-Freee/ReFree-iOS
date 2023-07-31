//
//  CategoryTableViewCell.swift
//  ReFree
//
//  Created by 이주훈 on 2023/07/31.
//

import UIKit
import SnapKit
import Then
import RxSwift
import RxCocoa

final class CategoryTableViewCell: UITableViewCell, Identifiable {
    var cetegory: String {
        categoryTitleLabel.text ?? "기타"
    }
    
    private let categoryTitleLabel = UILabel().then {
        $0.backgroundColor = .clear
        $0.textAlignment = .left
        $0.font = .pretendard.bold20
        $0.textColor = .refreeColor.main
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layout() {
        addSubview(categoryTitleLabel)
        
        categoryTitleLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.top.bottom.equalToSuperview().inset(12)
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        categoryTitleLabel.text = nil
    }
    
    func cellConfig(category: String) {
        categoryTitleLabel.text = category
    }
}
