//
//  HomeViewController.swift
//  ReFree
//
//  Created by 김형석 on 2023/07/14.
//

import UIKit
import SnapKit
import Then

class HomeViewController: UIViewController, UITableViewDelegate {
    private let header = HomeTabHeader(frame: .zero)
    
    private lazy var foodTableView = UITableView(
        frame: .zero,
        style: .plain
    ).then {
        $0.showsVerticalScrollIndicator = false
        $0.separatorStyle = .none
        $0.backgroundColor = .clear
        $0.rowHeight = 100
        
        $0.register(
            FoodTableViewCell.self,
            forCellReuseIdentifier: FoodTableViewCell.identifier
        )
    }

    private var ingredients: [Ingredient] = Mockup.ingredients
    
    override func viewDidLoad() {
        super.viewDidLoad()
        config()
    }
    
    private func config() {
        view.gradientBackground(type: .mainAxial)
        layout()
        foodTableView.delegate = self
        foodTableView.dataSource = self
    }
    
    private func layout() {
        view.addSubviews(
            [
                header,
                foodTableView
            ]
        )
        
        header.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(160)
        }
        
        foodTableView.snp.makeConstraints {
            $0.top.equalTo(header.snp.bottom)
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(24)
        }
    }

}

extension HomeViewController: UITableViewDataSource {
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return ingredients.count
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let spacingFooterView = UIView()
        spacingFooterView.backgroundColor = .clear
        return spacingFooterView
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: FoodTableViewCell.identifier,
            for: indexPath
        ) as? FoodTableViewCell else { return UITableViewCell() }
        
        cell.setData(ingredient: ingredients[indexPath.row])
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let ratio = 0.7
        let height = Constant.screenSize.height
        
        let halfModal = RFModalViewController(
            modalHeight: height * ratio,
            type: .detail(ingredients[indexPath.row])
        )
        present(halfModal, animated: true)
    }
}
