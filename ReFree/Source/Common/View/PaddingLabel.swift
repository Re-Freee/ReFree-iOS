//
//  PaddingLabel.swift
//  ReFree
//
//  Created by 이주훈 on 2023/07/30.
//

import UIKit

final class PaddingLabel: UILabel {
    private let topInset: CGFloat
    private let rightInset: CGFloat
    private let bottomInset: CGFloat
    private let leftInset: CGFloat
    
    init(top: CGFloat = 0, right: CGFloat = 10, bottom: CGFloat = 0, left: CGFloat = 10) {
        topInset = top
        rightInset = right
        bottomInset = bottom
        leftInset = left
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
        super.drawText(in: rect.inset(by: insets))
    }
    override var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        return CGSize(width: size.width + leftInset + rightInset, height: size.height + topInset + bottomInset)
    }
    override var bounds: CGRect {
        didSet { preferredMaxLayoutWidth = bounds.width - (leftInset + rightInset) }
    }
}
