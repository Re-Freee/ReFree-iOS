//
//  CategorySelectLabel.swift
//  ReFree
//
//  Created by 이주훈 on 2023/07/31.
//

import UIKit

final class CategorySelectLabel: PaddingLabel {
    init() {
        super.init()
        textColor = .refreeColor.text2
        clipsToBounds = true
        backgroundColor = .refreeColor.textFrame
        layer.cornerRadius = 10
        isHidden = true
        textAlignment = .center
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
