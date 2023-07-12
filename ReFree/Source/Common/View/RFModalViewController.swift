//
//  RFModalViewController.swift
//  ReFree
//
//  Created by 이주훈 on 2023/07/13.
//

import UIKit

final class RFModalViewController: UIViewController {
    
    init(modalHeight: CGFloat) {
        super.init(nibName: nil, bundle: Bundle.main)
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
    }
}

// 사용하는 곳에서 쓸 코드
//override func viewDidAppear(_ animated: Bool) {
//    super.viewDidAppear(animated)
//    guard
//        let height = view.window?.windowScene?.screen.bounds.height
//    else { return }
//    let halfModal = RFModalViewController(
//        modalHeight: height * 2/3
//    )
//    present(halfModal, animated: true)
//}
