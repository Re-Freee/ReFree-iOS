//
//  LineView.swift
//  ReFree
//
//  Created by 이주훈 on 2023/07/14.
//

import UIKit
import SnapKit

final class LineView: UIView {
    init(height: CGFloat = 0.5) {
        super.init(frame: .zero)
        backgroundColor = .gray
        snp.makeConstraints {
            $0.height.equalTo(height)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
