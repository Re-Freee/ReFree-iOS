//
//  KindRecipeViewController.swift
//  ReFree
//
//  Created by 이주훈 on 2023/07/18.
//

import UIKit
import SnapKit
import Then

final class KindRecipeViewController: UIViewController {
    enum TitleKind: String {
        case saved = "저장한 레시피"
        case bowl = "밥 레시피"
        case soup = "국&찌개 레시피"
        case dessert = "디저트 레시피"
        case sideMenu = "반찬 레시피"
    }
    
    private let titleLabel = UILabel().then {
        $0.textColor = .refreeColor.main
        $0.font = .pretendard.extraBold30
    }
    private let searchBar = RFSearchBar()
    private lazy var collectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: collectionViewLayout()
    ).then {
        $0.backgroundColor = .clear
        $0.register(
            RecipeListCell.self,
            forCellWithReuseIdentifier: RecipeListCell.identifier
        )
    }
    
    init(kind: KindRecipeViewController.TitleKind) {
        super.init(nibName: nil, bundle: Bundle.main)
        titleLabel.text = kind.rawValue
        dataLoading(kind: kind)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var recipes: [Recipe] = Mockup.savedRecipe // TODO: Mockup 제거 필요
    
    override func viewDidLoad() {
        super.viewDidLoad()
        config()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    
    private func config() {
        view.gradientBackground(type: .mainAxial)
        configCollectionView()
        layout()
    }
    
    private func configCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    private func layout() {
        view.addSubviews([
            titleLabel,
            searchBar,
            collectionView
        ])
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(24)
        }
        
        searchBar.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(12)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(24)
        }
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(searchBar.snp.bottom).offset(24)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func collectionViewLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { _, _ in
            let item = NSCollectionLayoutItem(
                layoutSize: .init(
                    widthDimension: .absolute((Constant.screenSize.width)/2),
                    heightDimension: .absolute((Constant.screenSize.width)/2)
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
    
    private func dataLoading(kind: TitleKind) {
        // TODO: 형식에 따른 레시피 Networking 후 reload
    }
}

extension KindRecipeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        recipes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: RecipeListCell.identifier,
            for: indexPath) as? RecipeListCell
        else { return UICollectionViewCell() }
        
        cell.prepareForReuse()
        cell.configCell(recipe: recipes[indexPath.row])
        
        return cell
    }
}

extension KindRecipeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {        
        let modalVC = RFModalParentViewController(
            type: .recipe(recipes[indexPath.row])
        )
        navigationController?.pushViewController(
            modalVC,
            animated: false
        )
    }
}
