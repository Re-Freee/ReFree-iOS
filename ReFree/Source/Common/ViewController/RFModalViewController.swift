//
//  RFModalViewController.swift
//  ReFree
//
//  Created by 이주훈 on 2023/07/13.
//

import UIKit
import SnapKit

final class RFModalViewController: UIViewController {
    
    enum contentType {
        case detail
        case recipe
    }
    
    var contentView: UIView?
    
    init(modalHeight: CGFloat, type: contentType) {
        super.init(nibName: nil, bundle: Bundle.main)
        switch type {
        case .detail: configDetail()
        case .recipe: break
        }
        config(height: modalHeight)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
    
    private func config(height: CGFloat) {
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
    
    private func configDetail() {
        contentView = IngredientDetailView(frame: view.frame)
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
