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
    let errorSubject = PublishSubject<String>()
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
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        endsubject.onNext(())
    }
    
    private func config(height: CGFloat, type: ContentType) {
        switch type {
        case .detail(let ingredient):
            let view = IngredientDetailView(ingredient: ingredient)
            view.errorSubject.subscribe(onNext: { [weak self] errorDiscription in
                self?.errorSubject.onNext(errorDiscription)
            })
            .disposed(by: disposeBag)
            contentView = view
        case .recipe(let recipe):
            let view = RecipeDetailView(recipe: recipe)
            view.errorSubject.subscribe(onNext: { [weak self] errorDiscription in
                self?.errorSubject.onNext(errorDiscription)
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
        
//        view.rx.touchDownGesture()
//            .when(.changed)
//            .bind(onNext: { [weak self] _ in
//                
//            })
//            .disposed(by: disposeBag)
    }
}
