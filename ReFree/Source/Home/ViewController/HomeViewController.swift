//
//  HomeViewController.swift
//  ReFree
//
//  Created by 김형석 on 2023/07/14.
//

import UIKit
import SnapKit
import Then
import RxSwift

class HomeViewController: UIViewController, UITableViewDelegate, UITextFieldDelegate {
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

    private var ingredients: [Ingredient] = []
    private var isImminentFoodButtonSelected: Bool = true
    private let ingredientRepository = IngredientRepository()
    private var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        config()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        isImminentFoodButtonSelected ? imminentFoodButtonTapped() : expiredFoodButtonTapped()
    }
    
    private func config() {
        view.gradientBackground(type: .mainAxial)
        layout()
        header.searchBar.textField.delegate = self
        foodTableView.delegate = self
        foodTableView.dataSource = self
        
        header.imminentFoodButton.addTarget(self, action: #selector(imminentFoodButtonTapped), for: .touchUpInside)
        header.expiredFoodButton.addTarget(self, action: #selector(expiredFoodButtonTapped), for: .touchUpInside)
        header.searchBar.searchStart.addTarget(self, action: #selector(searchStartButtonTapped), for: .touchUpInside)
        bind()
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
    
    private func bind() {
//        imminentFoodButtonTapped()
    }
    
    @objc private func imminentFoodButtonTapped() {
        isImminentFoodButtonSelected = true
        foodButtonSelected()
        
        ingredientRepository.request(closerIngredients: .closerIngredients)
            .subscribe(onNext: { [weak self] (commonResponse, ingredients) in
                guard
                    let self,
                    self.responseCheck(response: commonResponse)
                else { return }
                self.ingredients = ingredients
                self.foodTableView.reloadData()
                if !ingredients.isEmpty { self.ingredientExists() }
                else { self.ingredientNotExists() }
            }, onError: { error in
                Alert.erroAlert(viewController: self, errorMessage: error.localizedDescription)
            })
            .disposed(by: disposeBag)
    }
    
    @objc private func expiredFoodButtonTapped() {
        isImminentFoodButtonSelected = false
        foodButtonSelected()
        
        ingredientRepository.request(endIngredients: .endIngredients)
            .subscribe(onNext: { [weak self] (commonResponse, ingredients) in
                guard
                    let self,
                    self.responseCheck(response: commonResponse)
                else { return }
                self.ingredients = ingredients
                self.foodTableView.reloadData()
                if !ingredients.isEmpty { self.ingredientExists() }
                else { self.ingredientNotExists() }
            }, onError: { error in
                Alert.erroAlert(viewController: self, errorMessage: error.localizedDescription)
            })
            .disposed(by: disposeBag)
    }
    
    private func foodButtonSelected() {
        if isImminentFoodButtonSelected {
            header.setGradientButtonLayer(button: header.expiredFoodButton, isApplied: true)
            header.setGradientButtonLayer(button: header.imminentFoodButton)
            header.imminentFoodButton.backgroundColor = UIColor.refreeColor.button2
            header.expiredFoodButton.backgroundColor = UIColor.refreeColor.button3
            
            header.setButtonShadow(button: header.imminentFoodButton)
            header.setButtonShadow(button: header.expiredFoodButton, isSelected: true)
        } else {
            header.setGradientButtonLayer(button: header.imminentFoodButton, isApplied: true)
            header.setGradientButtonLayer(button: header.expiredFoodButton)
            header.expiredFoodButton.backgroundColor = UIColor.refreeColor.button2
            header.imminentFoodButton.backgroundColor = UIColor.refreeColor.button3
            
            header.setButtonShadow(button: header.expiredFoodButton)
            header.setButtonShadow(button: header.imminentFoodButton, isSelected: true)
        }
    }
    
    @objc private func searchStartButtonTapped() {
        guard
            let searchKey = header.searchBar.textField.text,
            !searchKey.isEmpty
        else {
            isImminentFoodButtonSelected ?
            imminentFoodButtonTapped() : expiredFoodButtonTapped()
            return
        }
        let filterdIngredients = ingredients.filter {
            guard let title = $0.title else { return false }
            return  title.contains(searchKey)
        }
        ingredients = filterdIngredients
        self.foodTableView.reloadData()
        header.searchBar.textField.resignFirstResponder()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        header.searchBar.textField.resignFirstResponder()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // TODO: reurn을 눌렀을 때 기능 추가, 아래 코드는 return을 눌렀을 때 textField의 "searchText" 변수에 저장하고 textField를 비워주는 임시 코드
//        let searchText = textField.text
        textField.text = ""
        
        textField.resignFirstResponder()
        
        return true
    }
    
    private func ingredientExists() {
        foodTableView.isHidden = false
        foodEmptyImage.isHidden = true
        foodEmptyLabel.isHidden = true
    }
    
    private func ingredientNotExists() {
        foodEmptyLabel.text = isImminentFoodButtonSelected ?
        "소비기한이 임박한 음식이 없습니다." : "소비기한이 만료된 음식이 없습니다."
    
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
        
        cell.setData(ingredient: ingredients[indexPath.section])
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let modalVC = RFModalParentViewController(
            type: .detail(ingredients[indexPath.row])
        )
        tabBarController?
            .navigationController?
            .pushViewController(
            modalVC,
            animated: false
        )
    }
}
