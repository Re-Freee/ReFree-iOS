//
//  RFModalParentViewController.swift
//  ReFree
//
//  Created by 이주훈 on 2023/08/04.
//

import UIKit
import SnapKit
import Then
import RxSwift

final class RFModalParentViewController: UIViewController {
    private let backgroundImageView = UIImageView(
        image: UIImage(named: "ReFree_non")
    ).then {
        $0.clipsToBounds = true
        $0.contentMode = .scaleToFill
    }
    
    private let type: RFModalViewController.ContentType
    private let disposeBag = DisposeBag()
    
    init(
        type: RFModalViewController.ContentType
    ) {
        self.type = type
        super.init(nibName: nil, bundle: Bundle.main)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        config()
    }
    
    private func config() {
        configImage()
        layout()
        showModal()
    }
    
    private func configImage() {
        switch type {
        case .detail(let ingredient):
            guard let _ = ingredient.imageURL else { return }
            // TODO: 이미지 설정
        case .recipe(let recipe):
            let _ = recipe.imageURL
            // TODO: 이미지 설정
        }
    }
    
    private func layout() {
        view.gradientBackground(type: .mainAxial)
        view.backgroundColor = .white
        view.addSubview(backgroundImageView)
        backgroundImageView.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(Constant.screenSize.height * 0.3)
        }
    }
    
    private func showModal() {
        let ratio = 0.7
        let height = Constant.screenSize.height
        
        let halfModal = RFModalViewController(
            modalHeight: height * ratio,
            type: type
        )
        halfModal.endsubject
            .subscribe { [weak self] _ in
                self?.navigationController?.popViewController(
                    animated: false
                )
            }
            .disposed(by: disposeBag)
        
        present(halfModal, animated: true)
    }
}
