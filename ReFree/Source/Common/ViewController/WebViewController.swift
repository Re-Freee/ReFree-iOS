//
//  WebViewController.swift
//  ReFree
//
//  Created by 이주훈 on 2023/08/14.
//

import UIKit
import SnapKit
import WebKit

final class RFWebViewController: UIViewController {
    private let webView = WKWebView()
    private let url: URL
    
    init(url: URL) {
        self.url = url
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
        configNavigation()
        layout()
        request()
    }
    
    private func configNavigation() {
        navigationItem.title = "약관"
        navigationController?.navigationBar.tintColor = .refreeColor.main
        navigationController?
            .navigationBar
            .titleTextAttributes = [
                .font: UIFont.pretendard.bold18 ?? .systemFont(ofSize: 18),
                .foregroundColor : UIColor.refreeColor.main
            ]
    }
    
    private func layout() {
        view.gradientBackground(type: .mainConic)
        
        view.addSubview(webView)
        webView.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.bottom.equalToSuperview()
        }
    }
    
    private func request() {
        let request = URLRequest(url: url)
        webView.load(request)
    }
}
