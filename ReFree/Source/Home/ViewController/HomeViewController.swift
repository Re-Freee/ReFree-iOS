//
//  HomeViewController.swift
//  ReFree
//
//  Created by 김형석 on 2023/07/14.
//

import UIKit

class HomeViewController: UIViewController {
    private let header = HomeTabHeader(frame: .zero)

    override func viewDidLoad() {
        super.viewDidLoad()
        config()
    }
    
    private func config() {
        view.gradientBackground(type: .mainAxial)
        layout()
    }
    
    private func layout() {
        view.addSubview(header)
        
        header.snp.makeConstraints { make in
            make.top.leading.bottom.trailing.equalTo(view.safeAreaLayoutGuide)
        }
    }

}

import SwiftUI

#if DEBUG
extension UIViewController {
    private struct Preview: UIViewControllerRepresentable {
            let viewController: UIViewController

            func makeUIViewController(context: Context) -> UIViewController {
                return viewController
            }

            func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
            }
        }

        func toPreview() -> some View {
            Preview(viewController: self)
        }
}
#endif

struct ViewControllerPreView: PreviewProvider {
    static var previews: some View {
        HomeViewController().toPreview()
    }
}
