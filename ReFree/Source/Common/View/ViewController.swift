//
//  ViewController.swift
//  ReFree
//
//  Created by 이주훈 on 2023/07/01.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    let headerView = RecipeTabHeader(frame: .zero)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.gradientBackground(type: .mainAxial)
    }
}
