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
        $0.titleLabel?.font = .pretendard.extraLight15
        $0.layer.masksToBounds = false
        $0.layer.cornerRadius = 5
        $0.tintColor = UIColor.refreeColor.main
        $0.semanticContentAttribute = .forceRightToLeft
        $0.imageEdgeInsets = .init(top: 0, left: 10, bottom: 0, right: 0)
        $0.titleEdgeInsets = .init(top: 0, left: 0, bottom: 0, right: 10)
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

    override func viewDidLoad() {
        super.viewDidLoad()
        config()
        configCollectionView()
        setupActions()
//        addShadowsToButtons()
        dropDownMenuButton.menu = menu
        dropDownMenuButton.showsMenuAsPrimaryAction = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    
    private func config() {
        view.gradientBackground(type: .mainAxial)
        layout()
    }
    
    private func configCollectionView() {
        collectionView.isHidden = true
        collectionView.dataSource = self
        collectionView.delegate = self
    }

    private func layout() {
        view.addSubviews([
            collectionView,
            header,
            categoryStackView,
            dropDownMenuButton
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
            $0.top.equalTo(header.snp.bottom).offset(140)
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
            $0.top.equalToSuperview().offset(370)
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
    }
    
    @objc private func foodCategoryButtonTapped() {
        collectionView.isHidden = false // collectionView를 화면에 보이도록 설정
        foodCategoryButton.backgroundColor = UIColor.refreeColor.button1
        foodCategoryButton.setTitleColor(.white, for: .normal) // 텍스트 색상을 흰색으로 변경
        foodCategoryButton.tintColor = .white // 이미지 색상을 흰색으로 변경
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
        30
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier:
                    RefrigeratorListCell.identifier,
            for: indexPath) as? RefrigeratorListCell
        else { return UICollectionViewCell() }

        return cell
    }
}

extension RefrigeratorViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    }
}

