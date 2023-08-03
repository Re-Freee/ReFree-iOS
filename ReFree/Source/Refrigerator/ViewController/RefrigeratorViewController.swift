//
//  AddFoodViewController.swift
//  ReFree
//
//  Created by hwijinjeong on 2023/07/22.
//

import UIKit
import SnapKit
import Then

class RefrigeratorViewController: UIViewController {
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
//        $0.addShadow(right: 5, down: 5, color: .red, opacity: 0.5, radius: 5)
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
                        print("소비기한 빠른 순")
                        self.dropDownMenuButton.setTitle("소비기한 빠른 순", for: .normal)
                    }),
                UIAction(
                    title: "소비기한 느린 순",
                    image: UIImage(systemName: ""),
                    handler: { _ in
                        print("소비기한 느린 순")
                        self.dropDownMenuButton.setTitle("소비기한 느린 순", for: .normal)
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

    private var ingredients: [Ingredient] = Mockup.ingredients
    
    override func viewDidLoad() {
        super.viewDidLoad()
        config()
        configCollectionView()
        setupActions()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    private func config() {
        view.gradientBackground(type: .mainAxial)
        layout()
        addDropDownMenu()
        addPaddingToButton()
    }
    
    private func configCollectionView() {
//        collectionView.isHidden = true
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    private func addDropDownMenu() {
        dropDownMenuButton.menu = menu
        dropDownMenuButton.showsMenuAsPrimaryAction = true
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
    
    private func collectionViewLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { _, _ in
            let item = NSCollectionLayoutItem(
                layoutSize: .init(
                    widthDimension: .absolute((Constant.screenSize.width-8)/2),
                    heightDimension: .absolute((Constant.screenSize.width-8)/2)
                )
            )

            item.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)

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
        foodCategoryButton.addTarget(self, action: #selector(foodCategoryButtonTapped), for: .touchUpInside)
        refrigeratedFoodCategoryButton.addTarget(self, action: #selector(refrigeratedFoodCategoryButtonTapped), for: .touchUpInside)
        frozenFoodCategoryButton.addTarget(self, action: #selector(frozenFoodCategoryButtonTapped), for: .touchUpInside)
        outdoorFoodCategoryButton.addTarget(self, action: #selector(outdoorFoodCategoryButtonTapped), for: .touchUpInside)
    }
    
    @objc private func foodCategoryButtonTapped() {
        collectionView.isHidden = false // collectionView를 화면에 보이도록 설정
        foodCategoryButton.backgroundColor = UIColor.refreeColor.button1
        foodCategoryButton.setTitleColor(.white, for: .normal)
        let originalImage = UIImage(named: "CookingBowl")?.withRenderingMode(.alwaysOriginal) // Set rendering mode here
        let whiteImage = originalImage?.withTintColor(.white) // Set color to white here
        foodCategoryButton.setImage(whiteImage, for: .normal)
        
        refrigeratedFoodCategoryButton.backgroundColor = .white
        refrigeratedFoodCategoryButton.setTitleColor(UIColor.refreeColor.main, for: .normal)
        refrigeratedFoodCategoryButton.setImage(UIImage(named: "Cheese")?.withRenderingMode(.alwaysOriginal), for: .normal)
        
        frozenFoodCategoryButton.backgroundColor = .white
        frozenFoodCategoryButton.setTitleColor(UIColor.refreeColor.main, for: .normal)
        frozenFoodCategoryButton.setImage(UIImage(named: "Icecream")?.withRenderingMode(.alwaysOriginal), for: .normal)
        
        outdoorFoodCategoryButton.backgroundColor = .white
        outdoorFoodCategoryButton.setTitleColor(UIColor.refreeColor.main, for: .normal)
        outdoorFoodCategoryButton.setImage(UIImage(named: "Muffin")?.withRenderingMode(.alwaysOriginal), for: .normal)
    }
    
    @objc private func refrigeratedFoodCategoryButtonTapped() {
        collectionView.isHidden = false // collectionView를 화면에 보이도록 설정
        refrigeratedFoodCategoryButton.backgroundColor = UIColor.refreeColor.button1
        refrigeratedFoodCategoryButton.setTitleColor(.white, for: .normal)
        let originalImage = UIImage(named: "Cheese")?.withRenderingMode(.alwaysOriginal) // Set rendering mode here
        let whiteImage = originalImage?.withTintColor(.white) // Set color to white here
        refrigeratedFoodCategoryButton.setImage(whiteImage, for: .normal)
        
        foodCategoryButton.backgroundColor = .white
        foodCategoryButton.setTitleColor(UIColor.refreeColor.main, for: .normal)
        foodCategoryButton.setImage(UIImage(named: "CookingBowl")?.withRenderingMode(.alwaysOriginal), for: .normal)
        
        frozenFoodCategoryButton.backgroundColor = .white
        frozenFoodCategoryButton.setTitleColor(UIColor.refreeColor.main, for: .normal)
        frozenFoodCategoryButton.setImage(UIImage(named: "Icecream")?.withRenderingMode(.alwaysOriginal), for: .normal)
        
        outdoorFoodCategoryButton.backgroundColor = .white
        outdoorFoodCategoryButton.setTitleColor(UIColor.refreeColor.main, for: .normal)
        outdoorFoodCategoryButton.setImage(UIImage(named: "Muffin")?.withRenderingMode(.alwaysOriginal), for: .normal)
    }
    
    @objc private func frozenFoodCategoryButtonTapped() {
        collectionView.isHidden = false // collectionView를 화면에 보이도록 설정
        frozenFoodCategoryButton.backgroundColor = UIColor.refreeColor.button1
        frozenFoodCategoryButton.setTitleColor(.white, for: .normal)
        
        let originalImage = UIImage(named: "Icecream")?.withRenderingMode(.alwaysOriginal) // Set rendering mode here
        let whiteImage = originalImage?.withTintColor(.white) // Set color to white here
        frozenFoodCategoryButton.setImage(whiteImage, for: .normal)
        
        refrigeratedFoodCategoryButton.backgroundColor = .white
        refrigeratedFoodCategoryButton.setTitleColor(UIColor.refreeColor.main, for: .normal)
        refrigeratedFoodCategoryButton.setImage(UIImage(named: "Cheese")?.withRenderingMode(.alwaysOriginal), for: .normal)
        
        foodCategoryButton.backgroundColor = .white
        foodCategoryButton.setTitleColor(UIColor.refreeColor.main, for: .normal)
        foodCategoryButton.setImage(UIImage(named: "CookingBowl")?.withRenderingMode(.alwaysOriginal), for: .normal)
        
        outdoorFoodCategoryButton.backgroundColor = .white
        outdoorFoodCategoryButton.setTitleColor(UIColor.refreeColor.main, for: .normal)
        outdoorFoodCategoryButton.setImage(UIImage(named: "Muffin")?.withRenderingMode(.alwaysOriginal), for: .normal)
    }
    
    @objc private func outdoorFoodCategoryButtonTapped() {
        collectionView.isHidden = false // collectionView를 화면에 보이도록 설정
        outdoorFoodCategoryButton.backgroundColor = UIColor.refreeColor.button1
        outdoorFoodCategoryButton.setTitleColor(.white, for: .normal)
        let originalImage = UIImage(named: "Muffin")?.withRenderingMode(.alwaysOriginal) // Set rendering mode here
        let whiteImage = originalImage?.withTintColor(.white) // Set color to white here
        outdoorFoodCategoryButton.setImage(whiteImage, for: .normal)
        
        refrigeratedFoodCategoryButton.backgroundColor = .white
        refrigeratedFoodCategoryButton.setTitleColor(UIColor.refreeColor.main, for: .normal)
        refrigeratedFoodCategoryButton.setImage(UIImage(named: "Cheese")?.withRenderingMode(.alwaysOriginal), for: .normal)
        
        frozenFoodCategoryButton.backgroundColor = .white
        frozenFoodCategoryButton.setTitleColor(UIColor.refreeColor.main, for: .normal)
        frozenFoodCategoryButton.setImage(UIImage(named: "Icecream")?.withRenderingMode(.alwaysOriginal), for: .normal)
        
        foodCategoryButton.backgroundColor = .white
        foodCategoryButton.setTitleColor(UIColor.refreeColor.main, for: .normal)
        foodCategoryButton.setImage(UIImage(named: "CookingBowl")?.withRenderingMode(.alwaysOriginal), for: .normal)
    }
    
    
    
    
//    private func addShadowsToButtons() {
//            foodCategoryButton.layer.masksToBounds = false
//            refrigeratedFoodCategoryButton.layer.masksToBounds = false
//            frozenFoodCategoryButton.layer.masksToBounds = false
//            outdoorFoodCategoryButton.layer.masksToBounds = false
//            immeButton.layer.masksToBounds = false
//
//            foodCategoryButton.layer.cornerRadius = 5
//            refrigeratedFoodCategoryButton.layer.cornerRadius = 5
//            frozenFoodCategoryButton.layer.cornerRadius = 5
//            outdoorFoodCategoryButton.layer.cornerRadius = 5
//            immeButton.layer.cornerRadius = 5
//
//            foodCategoryButton.addShadow(
//                right: 2,
//                down: 3,
//                color: .gray,
//                opacity: 0.5,
//                radius: 5
//            )
//
//            refrigeratedFoodCategoryButton.addShadow(
//                right: 2,
//                down: 3,
//                color: .gray,
//                opacity: 0.5,
//                radius: 5
//            )
//
//            frozenFoodCategoryButton.addShadow(
//                right: 2,
//                down: 3,
//                color: .gray,
//                opacity: 0.5,
//                radius: 5
//            )
//
//            outdoorFoodCategoryButton.addShadow(
//                right: 2,
//                down: 3,
//                color: .gray,
//                opacity: 0.5,
//                radius: 5
//            )
//
//        immeButton.addShadow(
//            right: 2,
//            down: 3,
//            color: .gray,
//            opacity: 0.5,
//            radius: 5
//        )
//    }
    
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
        navigationController?.pushViewController(
            modalVC,
            animated: false
        )
    }
}

