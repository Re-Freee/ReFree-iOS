//
//  CarouselCell.swift
//  ReFree
//
//  Created by 이주훈 on 2023/07/11.
//

import UIKit
import SnapKit
import Then

final class CarouselCell: UICollectionViewCell, Identifiable {
    private let titleLabel = UILabel().then {
        $0.text = "요리 이름"
        $0.textColor = .white
        // TODO: Font
    }
    
    private let indicator = UIImageView(image: UIImage(systemName: "chevron.right"))
    
    private let materialLabel = UILabel().then {
        $0.text = "재료"
        $0.textColor = .white
        // TODO: Font
    }
    
    private let materialLists = UILabel().then {
        $0.text = "연어, 오이, 당근, 양상추, 발사믹 소스"
        $0.textColor = .white
        // TODO: Font
    }
    
    private let imageView = UIImageView()
    
    private lazy var titleStack = UIStackView(
        arrangedSubviews: [titleLabel, indicator]
    ).then {
        $0.distribution = .equalSpacing
        $0.axis = .horizontal
    }
    
    private lazy var materialStack = UIStackView(
        arrangedSubviews: [materialLabel, materialLists]
    ).then {
        $0.distribution = .equalSpacing
        $0.axis = .vertical
    }
    
    private lazy var verticalStack = UIStackView(
        arrangedSubviews: [titleStack, materialStack, imageView]
    ).then {
        $0.distribution = .equalSpacing
        $0.axis = .vertical
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func layout() {
        gradientBackground(type: .blackAxial)
        layer.cornerRadius = 15
        clipsToBounds = true
        
        addSubview(verticalStack)
        
        verticalStack.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(Constant.spacing24)
        }
        
        imageView.snp.makeConstraints {
            $0.height.equalTo(imageView.snp.width)
        }
    }
    
    // Struct로 데이터를 받아올 예정
    func setData() {
        imageView.image = UIImage(named: "rocket")
    }
}
