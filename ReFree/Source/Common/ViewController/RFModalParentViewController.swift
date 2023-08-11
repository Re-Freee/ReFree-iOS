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
import Kingfisher

final class RFModalParentViewController: UIViewController {
    private let backgroundImageView = UIImageView().then {
        $0.clipsToBounds = true
        $0.contentMode = .scaleToFill
    }
    
    private let type: RFModalViewController.ContentType
    private let disposeBag = DisposeBag()
    let endSubject = PublishSubject<Void>()
    
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
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    private func config() {
        configImage()
        layout()
        showModal()
    }
    
    private func configImage() {
        switch type {
        case .detail(let ingredient):
            guard let imageURL = ingredient.imageURL else { return }
            backgroundImageView.kf.setImage(with: URL(string: imageURL))
        case .recipe(let recipe):
            let imageURL = recipe.imageURL
            backgroundImageView.kf.setImage(with: URL(string: imageURL))
        }
    }
    
    private func layout() {
        view.gradientBackground(type: .mainAxial)
        view.backgroundColor = .clear
        view.addSubview(backgroundImageView)
        backgroundImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
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
                self?.endSubject.onNext(())
            }
            .disposed(by: disposeBag)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .microseconds(10)) { [weak self] in
            self?.present(halfModal, animated: true)
        }
    }
}
