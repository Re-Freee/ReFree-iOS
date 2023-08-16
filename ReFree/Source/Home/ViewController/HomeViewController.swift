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

class HomeViewController: UIViewController, UITextFieldDelegate {
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

    private let ingredientRepo = IngredientRepository()
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
        navigationItem.backButtonTitle = "홈"
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
        bindSearchBar()
    }
    
    private func bindSearchBar() {
        header.searchBar.searchStart.rx.tap
            .bind(onNext: { [weak self] in
                guard
                    let self,
                    let searchKey = self.header.searchBar.textField.text
                else { return }
                self.ingredientRepo
                    .request(
                        searchIngredients: .searchIngredients(
                            options: nil,
                            searchKey: searchKey
                        )
                    )
                    .subscribe(onNext: { [weak self] (commonResponse, ingredients) in
                        guard
                            let self,
                            self.responseCheck(response: commonResponse)
                        else { return }
                        self.ingredients = ingredients
                        self.foodTableView.reloadData()
                    }, onError: { [weak self] error in
                        guard let self else { return }
                        Alert.errorAlert(
                            viewController: self,
                            errorMessage: error.localizedDescription
                        )
                    })
                    .disposed(by:disposeBag)
            })
            .disposed(by: disposeBag)
    }
    
    @objc private func imminentFoodButtonTapped() {
        isImminentFoodButtonSelected = true
        foodButtonSelected()
        
        ingredientRequest()
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
            }, onError: { [weak self] error in
                guard let self else { return }
                Alert.errorAlert(
                    viewController: self,
                    errorMessage: error.localizedDescription
                )
            })
            .disposed(by: disposeBag)
    }
    
    @objc private func expiredFoodButtonTapped() {
        isImminentFoodButtonSelected = false
        foodButtonSelected()
        
        ingredientRequest()
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
            }, onError: { [weak self] error in
                guard let self else { return }
                Alert.errorAlert(
                    viewController: self,
                    errorMessage: error.localizedDescription
                )
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
        textField.resignFirstResponder()
        searchStartButtonTapped()
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
    
    private func sortIngredientsByExpireDate(ascending: Bool) {
        ingredients.sort { (ingredient1, ingredient2) in
            if let date1 = ingredient1.expireDate, let date2 = ingredient2.expireDate {
                if ascending {
                    return date1 < date2
                } else {
                    return date1 > date2
                }
            }
            return true
        }
        foodTableView.reloadData()
    }
    
    private func ingredientRequest() {
        view.endEditing(true)
        ingredientRepo.request(
            searchIngredients: .searchIngredients(options: nil)
        )
            .subscribe(onNext: { [weak self] (commonResponse, ingredients) in
                guard
                    let self,
                    self.responseCheck(response: commonResponse)
                else { return }
                self.ingredients = ingredients
                self.sortIngredientsByExpireDate(ascending: true)
                self.foodTableView.reloadData()
            }, onError: { [weak self] error in
                guard let self else { return }
                Alert.errorAlert(
                    viewController: self,
                    errorMessage: error.localizedDescription
                )
            })
            .disposed(by:disposeBag)
    }
}

extension HomeViewController: UITableViewDelegate {
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.view.endEditing(true)
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
        
        modalVC.editSubject
            .subscribe(onNext: { [weak self] ingredient in
                let editVC =  RegisterIngredientViewController(type: .edit)
                editVC.setIngredient(ingredient: ingredient)
                self?.navigationController?
                    .pushViewController(
                        editVC,
                        animated: false
                    )
                self?.tabBarController?
                    .navigationController?
                    .popViewController(animated: true)
            })
            .disposed(by: disposeBag)
        
        tabBarController?
            .navigationController?
            .pushViewController(
            modalVC,
            animated: false
        )
    }
}
