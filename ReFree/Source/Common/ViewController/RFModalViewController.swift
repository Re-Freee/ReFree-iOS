//
//  RFModalViewController.swift
//  ReFree
//
//  Created by 이주훈 on 2023/07/13.
//

import UIKit
import SnapKit

final class RFModalViewController: UIViewController {
    
    enum ContentType {
        case detail(Ingredient)
        case recipe(Recipe)
    }
    
    var contentView: UIView?
    
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
    
    private func config(height: CGFloat, type: ContentType) {
        switch type {
        case .detail(let ingredient):
            contentView = IngredientDetailView(ingredient: ingredient)
        case .recipe(let recipe):
            contentView = RecipeDetailView(recipe: recipe)
        }
        
        guard let sheet = sheetPresentationController else { return }
        sheet.detents = [
            .custom(
                resolver: { _ in return height}
            ),
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
    
    func configRecipe(recipe: Recipe) {
        guard let recipeView = contentView as? RecipeDetailView else { return }
        recipeView.configView(recipe: recipe)
    }
}

//사용하는 곳에서 쓸 코드
//override func viewDidAppear(_ animated: Bool) {
//    super.viewDidAppear(animated)
//    let ratio = 0.7
//    guard
//        let height = view.window?.windowScene?.screen.bounds.height
//    else { return }
//    let halfModal = RFModalViewController(
//        modalHeight: height * ratio,
//        type: .
//    )
//    present(halfModal, animated: true)
//}
