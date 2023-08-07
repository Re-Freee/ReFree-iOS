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
    
    private let foodEmptyImage = UIImageView().then {
        $0.image = UIImage(named: "CheckDocument")
        $0.contentMode = .scaleToFill
        $0.isHidden = true
    }
    
    private let foodEmptyLabel = UILabel().then {
        $0.text = "소비기한 임박한 음식이 없습니다."
        $0.font = .pretendard.bold20
        $0.textColor = .refreeColor.main
        $0.isHidden = true
    }
    
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
    
    private var isImminentFoodButtonSelected: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        config()
    }
    
    private func config() {
        view.gradientBackground(type: .mainAxial)
        layout()
        foodTableView.delegate = self
        foodTableView.dataSource = self
        header.imminentFoodButton.addTarget(self, action: #selector(imminentFoodButtonTapped), for: .touchUpInside)
        header.expiredFoodButton.addTarget(self, action: #selector(expiredFoodButtonTapped), for: .touchUpInside)
    }
    
    private func layout() {
        view.addSubviews(
            [
                header,
                foodTableView,
                foodEmptyImage,
                foodEmptyLabel
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
        
        foodEmptyImage.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(0.5)
            $0.height.equalToSuperview().multipliedBy(0.3)
        }
        
        foodEmptyLabel.snp.makeConstraints {
            $0.top.equalTo(foodEmptyImage.snp.bottom).offset(30)
            $0.centerX.equalToSuperview()
        }
    }
    
    @objc private func imminentFoodButtonTapped() {
        if !isImminentFoodButtonSelected {
            header.setGradientButtonLayer(button: header.expiredFoodButton, isApplied: true)
            header.setGradientButtonLayer(button: header.imminentFoodButton)
            header.imminentFoodButton.backgroundColor = UIColor.refreeColor.button2
            header.expiredFoodButton.backgroundColor = UIColor.refreeColor.button3
            
            header.setButtonShadow(button: header.imminentFoodButton)
            header.setButtonShadow(button: header.expiredFoodButton, isSelected: true)
            
            isImminentFoodButtonSelected = true
        }
        
        foodEmptyLabel.text = "소비기한 임박한 음식이 없습니다"
        
        if ingredients.count == 0 {
            foodTableView.isHidden = true
            foodEmptyImage.isHidden = false
            foodEmptyLabel.isHidden = false
        } else {
            foodTableView.isHidden = false
            foodEmptyImage.isHidden = true
            foodEmptyLabel.isHidden = true
            ingredients = Mockup.testIngredients1
            foodTableView.reloadData()
        }
    }
    
    @objc private func expiredFoodButtonTapped() {
        if isImminentFoodButtonSelected {
            header.setGradientButtonLayer(button: header.imminentFoodButton, isApplied: true)
            header.setGradientButtonLayer(button: header.expiredFoodButton)
            header.expiredFoodButton.backgroundColor = UIColor.refreeColor.button2
            header.imminentFoodButton.backgroundColor = UIColor.refreeColor.button3
            
            header.setButtonShadow(button: header.expiredFoodButton)
            header.setButtonShadow(button: header.imminentFoodButton, isSelected: true)
            
            isImminentFoodButtonSelected = false
        }
        
        foodEmptyLabel.text = "소비기한 만료된 음식이 없습니다"
        
        if ingredients.count == 0 {
            foodTableView.isHidden = true
            foodEmptyImage.isHidden = false
            foodEmptyLabel.isHidden = false
        } else {
            foodTableView.isHidden = false
            foodEmptyImage.isHidden = true
            foodEmptyLabel.isHidden = true
            ingredients = Mockup.testIngredients2
            foodTableView.reloadData()
        }
        
        foodTableView.isHidden = true
        foodEmptyImage.isHidden = false
        foodEmptyLabel.isHidden = false
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
    
    func tableView(
        _ tableView: UITableView,
        viewForFooterInSection section: Int
    ) -> UIView? {
        let spacingFooterView = UIView()
        spacingFooterView.backgroundColor = .clear
        return spacingFooterView
    }
    
    func tableView(
        _ tableView: UITableView,
        heightForFooterInSection section: Int)
    -> CGFloat {
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
        let modalVC = RFModalParentViewController(
            type: .detail(ingredients[indexPath.row])
        )
        navigationController?.pushViewController(
            modalVC,
            animated: false
        )
    }
}
