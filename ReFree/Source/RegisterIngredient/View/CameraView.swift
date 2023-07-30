//
//  CameraView.swift
//  ReFree
//
//  Created by 이주훈 on 2023/07/29.
//

import UIKit
import SnapKit
import Then

final class CameraView: UIView {
    private let imageView = UIImageView(image: UIImage(named: "Camera1")).then {
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 15
        $0.backgroundColor = .refreeColor.text1
        $0.contentMode = .center
    }
    
    var currentImage: UIImage? {
        return imageView.image
    }
    
    init() {
        super.init(frame: .zero)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layout() {        
        addSubview(imageView)
        
        imageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func setImage(image: UIImage) {
        imageView.image = image
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .clear
    }
    
    func setDefault() {
        imageView.image = UIImage(named: "Camera1")
        imageView.backgroundColor = .refreeColor.text1
        imageView.contentMode = .center
    }

}
