//
//  CameraView.swift
//  ReFree
//
//  Created by 이주훈 on 2023/07/29.
//

import UIKit
import SnapKit
import RxSwift
import Then
import Kingfisher

final class CameraView: UIView {
    private let imageView = UIImageView(image: UIImage(named: "Camera1")).then {
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 15
        $0.backgroundColor = .refreeColor.text1
        $0.contentMode = .center
    }
    
    let currentImage = BehaviorSubject(value: Constant.reFreeLogo)
    
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
        currentImage.onNext(image)
        imageView.image = image
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .clear
    }
    
    func setDefault() {
        currentImage.onNext(Constant.reFreeLogo)
        imageView.image = UIImage(named: "Camera1")
        imageView.backgroundColor = .refreeColor.text1
        imageView.contentMode = .center
    }
    
    func setIngredient(ingredient: Ingredient) {
        guard
            let urlString = ingredient.imageURL,
            let url = URL(string: urlString)
        else { return }
        
        KingfisherManager.shared.retrieveImage(with: url) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let value):
                setImage(image: value.image)
            case .failure(_):
                Alert.errorAlert(
                    targetView: self,
                    errorMessage: "이미지를 불러오지 못했습니다."
                )
            }
        }
    }
}
