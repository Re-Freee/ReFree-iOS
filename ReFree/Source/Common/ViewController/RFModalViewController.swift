//
//  RFModalViewController.swift
//  ReFree
//
//  Created by 이주훈 on 2023/07/13.
//

import UIKit
import SnapKit
import RxSwift

final class RFModalViewController: UIViewController {
    
    enum ContentType {
        case detail(Ingredient)
        case recipe(Recipe)
    }
    
    private var contentView: UIView?
    let endsubject = PublishSubject<Void>()
    private var disposeBag = DisposeBag()
    
    init(modalHeight: CGFloat, type: ContentType) {
        super.init(nibName: nil, bundle: Bundle.main)
        config(height: modalHeight, type: type)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        endsubject.onNext(())
    }
    
    private func config(height: CGFloat, type: ContentType) {
        switch type {
        case .detail(let ingredient):
            let view = IngredientDetailView(ingredient: ingredient)
            view.errorSubject.subscribe(onNext: { [weak self] errorDiscription in
                guard let self else { return }
                Alert.erroAlert(viewController: self, errorMessage: errorDiscription)
            })
            .disposed(by: disposeBag)
            view.alertSubject.subscribe(onNext: { [weak self] alertMessage in
                guard let self else { return }
                let alert = AlertView(
                    title: "확인",
                    description: alertMessage,
                    alertType: .check
                )
                alert.successButton.rx.tap
                    .bind(onNext: { [weak self] in
                        self?.dismiss(animated: true)
                    })
                    .disposed(by: disposeBag)
                self.view.addSubview(alert)
            })
                .disposed(by: disposeBag)
            contentView = view
        case .recipe(let recipe):
            let view = RecipeDetailView(recipe: recipe)
            view.errorSubject.subscribe(onNext: { [weak self] errorDiscription in
                guard let self else { return }
                Alert.erroAlert(viewController: self, errorMessage: errorDiscription)
            })
            .disposed(by: disposeBag)
            contentView = view
        }
        
        guard let sheet = sheetPresentationController else { return }
        sheet.detents = [
            .custom( resolver: { _ in return height}),
            .large()
        ]
        sheet.prefersGrabberVisible = true
        sheet.prefersScrollingExpandsWhenScrolledToEdge = true
        sheet.preferredCornerRadius = CGFloat(30)
        sheet.largestUndimmedDetentIdentifier = .large
        
        if let contentView {
            view.addSubview(contentView)
            contentView.snp.makeConstraints {
                $0.edges.equalToSuperview()
            }
        }
    }
}
