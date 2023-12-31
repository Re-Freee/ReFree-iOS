//
//  AddFoodViewController.swift
//  ReFree
//
//  Created by hwijinjeong on 2023/07/22.
//

import UIKit
import SnapKit
import Then
import RxSwift

class RefrigeratorViewController: UIViewController {
    private enum SaveKind {
        case whole
        case refrigerd
        case frozen
        case outdoor
        
        var currentImageString: String {
            switch self {
            case .whole: return "CookingBowl"
            case .refrigerd: return "Cheese"
            case .frozen: return "Icecream"
            case .outdoor: return "Muffin"
            }
        }
        
        var networkKind: NetworkIngredient.SearchIngredientOption? {
            switch self {
            case .whole: return nil
            case .refrigerd: return .refrigerd
            case .frozen: return .frozen
            case .outdoor: return .outdoor
            }
        }
    }
    
    private let header = RefrigeratorTabHeader(frame: .zero)
    
    let categoryStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.distribution = .equalSpacing
        $0.alignment = .fill
        $0.spacing = 20
    }
    
    let foodCategoryButton = UIButton().then {
        $0.setTitle("전체", for: .normal)
        $0.setTitleColor(UIColor.refreeColor.main, for: .normal)
        $0.backgroundColor = .white
        $0.titleLabel?.font = .pretendard.bold10
        $0.setImage(UIImage(named: "CookingBowl"), for: .normal)
        $0.alignBtnTextBelow(spacing: 6)
        $0.layer.masksToBounds = false
        $0.layer.cornerRadius = 5
        $0.addShadow(right: 0, down: 2, color: .gray, opacity: 0.6, radius: 8)
    }
    
    let refrigeratedFoodCategoryButton = UIButton().then {
        $0.setTitle("냉장", for: .normal)
        $0.setTitleColor(UIColor.refreeColor.main, for: .normal)
        $0.backgroundColor = .white
        $0.titleLabel?.font = .pretendard.bold10
        $0.setImage(UIImage(named: "Cheese"), for: .normal)
        $0.alignBtnTextBelow(spacing: 6)
        $0.layer.masksToBounds = false
        $0.layer.cornerRadius = 5
        $0.addShadow(right: 0, down: 2, color: .gray, opacity: 0.6, radius: 8)
    }
    
    let frozenFoodCategoryButton = UIButton().then {
        $0.setTitle("냉동", for: .normal)
        $0.setTitleColor(UIColor.refreeColor.main, for: .normal)
        $0.backgroundColor = .white
        $0.titleLabel?.font = .pretendard.bold10
        $0.setImage(UIImage(named: "Icecream"), for: .normal)
        $0.alignBtnTextBelow(spacing: 6)
        $0.layer.masksToBounds = false
        $0.layer.cornerRadius = 5
        $0.addShadow(right: 0, down: 2, color: .gray, opacity: 0.6, radius: 8)
    }
    
    let outdoorFoodCategoryButton = UIButton().then {
        $0.setTitle("실외", for: .normal)
        $0.setTitleColor(UIColor.refreeColor.main, for: .normal)
        $0.backgroundColor = .white
        $0.titleLabel?.font = .pretendard.bold10
        $0.setImage(UIImage(named: "Muffin"), for: .normal)
        $0.alignBtnTextBelow(spacing: 6)
        $0.layer.masksToBounds = false
        $0.layer.cornerRadius = 5
        $0.addShadow(right: 0, down: 2, color: .gray, opacity: 0.6, radius: 8)
    }
    
    let dropDownMenuButton = UIButton().then {
        $0.backgroundColor = .white
        let symbolName = "chevron.down"
        let symbolConfig = UIImage.SymbolConfiguration(pointSize: 15.0, weight: .bold)
        let symbolImage = UIImage(systemName: symbolName, withConfiguration: symbolConfig)
        $0.setImage(symbolImage, for: .normal)
        $0.setTitle("소비기한 빠른 순", for: .normal)
        $0.setTitleColor(UIColor.refreeColor.text1, for: .normal)
        $0.titleLabel?.font = .pretendard.extraLight12
        $0.layer.masksToBounds = false
        $0.layer.cornerRadius = 5
        $0.tintColor = UIColor.refreeColor.main
        $0.semanticContentAttribute = .forceRightToLeft
    }
    
    private lazy var menuItems: [UIAction] = {
            return [
                UIAction(
                    title: "소비기한 빠른 순",
                    image: UIImage(systemName: ""),
                    handler: { _ in
                        self.dropDownMenuButton.setTitle("소비기한 빠른 순", for: .normal)
                        self.ascending = true
                        self.sortIngredientsByExpireDate(ascending: true)
                    }),
                UIAction(
                    title: "소비기한 느린 순",
                    image: UIImage(systemName: ""),
                    handler: { _ in
                        self.dropDownMenuButton.setTitle("소비기한 느린 순", for: .normal)
                        self.ascending = false
                        self.sortIngredientsByExpireDate(ascending: false)
                    })
            ]
        }()
    
    private lazy var menu: UIMenu = {
        let options: UIMenu.Options = [.displayInline]
            return UIMenu(title: "", options: [], children: menuItems)
    }()
    
    private lazy var collectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: collectionViewLayout()
    ).then {
        $0.backgroundColor = .clear
        $0.register(
            RefrigeratorListCell.self,
            forCellWithReuseIdentifier: RefrigeratorListCell.identifier
        )
    }

    private let ingredientRepo = IngredientRepository()
    private let userRepository = UserRepository()
    private let signRepository = SignRepository()
    private var ingredients: [Ingredient] = []
    private let disposeBag = DisposeBag()
    private var currentKind: SaveKind = .whole
    private var ascending: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        config()
        condifDelegate()
        setupActions()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
        reloadData()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    
    private func config() {
        view.gradientBackground(type: .mainAxial)
        layout()
        addDropDownMenu()
        addPaddingToButton()
        bind()
    }
    
    private func condifDelegate() {
        collectionView.dataSource = self
        collectionView.delegate = self
        header.searchBar.textField.delegate = self
    }
    
    private func addDropDownMenu() {
        dropDownMenuButton.menu = menu
        dropDownMenuButton.showsMenuAsPrimaryAction = true
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
        collectionView.reloadData()
    }

    private func addPaddingToButton() {
        if #available(iOS 15.0, *) {
            var config = UIButton.Configuration.plain()
            config.imagePadding = 10
            config.titlePadding = 10
            config.baseForegroundColor = UIColor.refreeColor.text1
            dropDownMenuButton.configuration = config
        } else {
            dropDownMenuButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
            dropDownMenuButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 10)
        }
    }
    
    private func layout() {
        view.addSubviews([
            header,
            categoryStackView,
            dropDownMenuButton,
            collectionView
        ])
        
        categoryStackView.addArrangedSubviews([
            foodCategoryButton,
            refrigeratedFoodCategoryButton,
            frozenFoodCategoryButton,
            outdoorFoodCategoryButton
        ])
        
        header.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(Constant.spacing24)
        }
        
        categoryStackView.snp.makeConstraints {
            $0.top.equalTo(header.snp.bottom).offset(24)
            $0.centerX.equalToSuperview()
        }
        
        foodCategoryButton.snp.makeConstraints {
            $0.height.equalTo(60)
            $0.width.equalTo(70)
        }
        
        refrigeratedFoodCategoryButton.snp.makeConstraints {
            $0.height.equalTo(60)
            $0.width.equalTo(70)
        }
        
        frozenFoodCategoryButton.snp.makeConstraints {
            $0.height.equalTo(60)
            $0.width.equalTo(70)
        }
        
        outdoorFoodCategoryButton.snp.makeConstraints {
            $0.height.equalTo(60)
            $0.width.equalTo(70)
        }
        
        dropDownMenuButton.snp.makeConstraints{
            $0.width.equalTo(170)
            $0.height.equalTo(30)
            $0.top.equalTo(categoryStackView.snp.bottom).offset(15)
            $0.trailing.equalToSuperview().offset(-20)
        }
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(dropDownMenuButton.snp.bottom).offset(12)
            $0.leading.trailing.equalToSuperview().inset(4)
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func bind() {
        bindUser()
        bindSearchBar()
    }
    
    private func bindUser() {
        if let nickName = userRepository.getUserNickName() {
            header.setTitle(name: nickName)
        } else {
            signRepository.request(userNickName: .userNickName)
                .subscribe(onNext: { [weak self] commonResponse in
                    guard
                        let self,
                        self.responseCheck(response: commonResponse)
                    else { return }
                    let nickName = commonResponse.message
                    self.userRepository.setUserNickName(nickName: nickName)
                    self.header.setTitle(name: nickName)
                }, onError: { [weak self] error in
                    guard let self else { return }
                    Alert.errorAlert(
                        viewController: self,
                        errorMessage: error.localizedDescription
                    )
                })
                .disposed(by: disposeBag)
        }
    }
    
    private func bindSearchBar() {
        header.searchBar.searchStart.rx.tap
            .bind(onNext: { [weak self] in
                self?.searchStart()
            })
            .disposed(by: disposeBag)
    }
    
    private func searchStart() {
        guard
            let searchKey = self.header.searchBar.textField.text
        else { return }
        self.ingredientRepo
            .request(
                searchIngredients: .searchIngredients(
                    options: self.currentKind.networkKind,
                    searchKey: searchKey
                )
            )
            .subscribe(onNext: { [weak self] (commonResponse, ingredients) in
                guard
                    let self,
                    self.responseCheck(response: commonResponse)
                else { return }
                self.ingredients = ingredients
                self.collectionView.reloadData()
            }, onError: { [weak self] error in
                guard let self else { return }
                Alert.errorAlert(
                    viewController: self,
                    errorMessage: error.localizedDescription
                )
            })
            .disposed(by:disposeBag)
    }
    
    private func collectionViewLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { _, _ in
            let item = NSCollectionLayoutItem(
                layoutSize: .init(
                    widthDimension: .absolute((Constant.screenSize.width-8)/2),
                    heightDimension: .absolute((Constant.screenSize.width-8)/2)
                )
            )

            item.contentInsets = NSDirectionalEdgeInsets(
                top: 8,
                leading: 8,
                bottom: 8,
                trailing: 8
            )

            let group = NSCollectionLayoutGroup.horizontal(
                layoutSize: .init(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .estimated(100)
                ),
                subitems: [item]
            )
            let section = NSCollectionLayoutSection(group: group)

            return section
        }
    }

    private func setupActions() {
        foodCategoryButton.addTarget(
            self,
            action: #selector(foodCategoryButtonTapped),
            for: .touchUpInside
        )
        refrigeratedFoodCategoryButton.addTarget(
            self,
            action: #selector(refrigeratedFoodCategoryButtonTapped),
            for: .touchUpInside
        )
        frozenFoodCategoryButton.addTarget(
            self,
            action: #selector(frozenFoodCategoryButtonTapped),
            for: .touchUpInside
        )
        outdoorFoodCategoryButton.addTarget(
            self,
            action: #selector(outdoorFoodCategoryButtonTapped),
            for: .touchUpInside
        )
    }
    
    @objc private func foodCategoryButtonTapped() {
        ingredientRequest(saveKind: .whole)
    }
    
    @objc private func refrigeratedFoodCategoryButtonTapped() {
        ingredientRequest(saveKind: .refrigerd)
    }
    
    @objc private func frozenFoodCategoryButtonTapped() {
        ingredientRequest(saveKind: .frozen)
    }
    
    @objc private func outdoorFoodCategoryButtonTapped() {
        ingredientRequest(saveKind: .outdoor)
    }
    
    private func ingredientRequest(saveKind: SaveKind) {
        view.endEditing(true)
        changeSelectedButtonLayout(saveKind: saveKind)
        currentKind = saveKind
        ingredientRepo.request(
            searchIngredients: .searchIngredients(options: saveKind.networkKind)
        )
            .subscribe(onNext: { [weak self] (commonResponse, ingredients) in
                guard
                    let self,
                    self.responseCheck(response: commonResponse)
                else { return }
                self.ingredients = ingredients
                self.sortIngredientsByExpireDate(ascending: ascending)
                self.collectionView.reloadData()
            }, onError: { [weak self] error in
                guard let self else { return }
                Alert.errorAlert(
                    viewController: self,
                    errorMessage: error.localizedDescription
                )
            })
            .disposed(by:disposeBag)
    }
    
    private func changeSelectedButtonLayout(saveKind: SaveKind) {
        collectionView.isHidden = false // collectionView를 화면에 보이도록 설정
        [
            (foodCategoryButton, "CookingBowl"),
            (refrigeratedFoodCategoryButton, "Cheese"),
            (frozenFoodCategoryButton, "Icecream"),
            (outdoorFoodCategoryButton, "Muffin")
        ].forEach { (button, imageName) in
            if saveKind.currentImageString == imageName {
                button.backgroundColor = UIColor.refreeColor.button1
                button.setTitleColor(.white, for: .normal)
                let whiteImage = UIImage(named: imageName)?.withTintColor(.white, renderingMode: .alwaysOriginal) // Set rendering mode here
                button.setImage(whiteImage, for: .normal)
            } else {
                button.backgroundColor = .white
                button.setTitleColor(UIColor.refreeColor.main, for: .normal)
                button.setImage(UIImage(named: imageName)?.withRenderingMode(.alwaysOriginal), for: .normal)
            }
        }
    }
    
    private func reloadData() {
        ingredientRequest(saveKind: currentKind)
    }
}

extension RefrigeratorViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        ingredients.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard
            let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: RefrigeratorListCell.identifier,
            for: indexPath
        ) as? RefrigeratorListCell
        else { return UICollectionViewCell() }

        cell.configCell(ingredient: ingredients[indexPath.row])
        
        return cell
    }
}

extension RefrigeratorViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let modalVC = RFModalParentViewController(
            type: .detail(ingredients[indexPath.row])
        )
        
        modalVC.endSubject
            .subscribe(onNext: { [weak self] in
                self?.reloadData()
            })
            .disposed(by: disposeBag)
        
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
                self?.reloadData()
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

extension RefrigeratorViewController: UICollectionViewDelegate {
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.view.endEditing(true)
    }
}

extension RefrigeratorViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchStart()
        header.searchBar.textField.text = ""
        textField.resignFirstResponder()
        return true
    }
}
