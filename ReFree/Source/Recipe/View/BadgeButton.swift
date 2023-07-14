//
//  BadgeButton.swift
//  ReFree
//
//  Created by 이주훈 on 2023/07/11.
//

import UIKit
import SnapKit
import Then

final class BadgeButton: UIView {
    private let heartButton = UIButton().then {
        $0.setImage(UIImage(named: "Heart"), for: .normal)
    }
    
    private let redBadge = UIView().then {
        $0.backgroundColor = .red
        $0.layer.cornerRadius = CGFloat(Constant.spacing6)
    }
    
    private let badgeCount = UILabel().then {
        $0.textAlignment = .center
        $0.textColor = .white
        $0.text = "0"
        // TODO: Font
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layout() {
        clipsToBounds = false
        addSubviews([heartButton, redBadge, badgeCount])
        
        heartButton.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        redBadge.snp.makeConstraints {
            $0.top.equalToSuperview().inset(Constant.spacing10)
            $0.trailing.equalToSuperview().inset(Constant.spacing8)
            $0.width.height.equalTo(Constant.spacing12)
        }
        
        badgeCount.snp.makeConstraints {
            $0.center.equalTo(redBadge)
            $0.width.height.equalTo(redBadge.snp.width)
        }
    }
    
    func setCount(count: Int) {
        guard count < 10 else { badgeCount.text = "+"; return}
        badgeCount.text = "\(count)"
    }
}
