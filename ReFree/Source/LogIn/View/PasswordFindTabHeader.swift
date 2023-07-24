//
//  PasswordFindTabHeader.swift
//  ReFree
//
//  Created by 김형석 on 2023/07/21.
//

import UIKit
import SnapKit
import Then

final class PasswordFindTabHeader: UIView {
    private let fourCircleImage = UIImageView().then {
        $0.image = UIImage(named: "FourCircle")
        $0.contentMode = .scaleToFill
    }
    
    private let threadImage = UIImageView().then {
        $0.image = UIImage(named: "Thread")
        $0.contentMode = .scaleToFill
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        config()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func config() {
        layout()
    }
    
    private func layout() {
        self.addSubviews(
            [
                fourCircleImage,
                threadImage
            ]
        )
        
        fourCircleImage.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().offset(24)
            $0.trailing.equalTo(snp.centerX).offset(-24)
        }
        
        threadImage.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.trailing.equalToSuperview().offset(-24)
            $0.leading.equalTo(snp.centerX).offset(24)
        }
    }
}
