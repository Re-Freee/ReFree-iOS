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
        case detail
        case recipe
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
        case .detail: contentView = IngredientDetailView(frame: view.frame)
        case .recipe: contentView = IngredientDetailView(frame: view.frame)
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
        
        guard let contentView else { return }
        
        view.addSubview(contentView)
        contentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
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
