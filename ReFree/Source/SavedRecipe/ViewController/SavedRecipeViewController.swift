//
//  SavedRecipeViewController.swift
//  ReFree
//
//  Created by 이주훈 on 2023/07/18.
//

import UIKit
import SnapKit
import Then

final class SavedRecipeViewController: UIViewController {
    private let titleLabel = UILabel().then {
        $0.textColor = .refreeColor.main
        $0.text = "저장한 레시피"
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
}

extension SavedRecipeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        30
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: RecipeListCell.identifier,
            for: indexPath) as? RecipeListCell
        else { return UICollectionViewCell() }
        
        return cell
    }
}

extension SavedRecipeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let ratio = 0.7
        let height = Constant.screenSize.height
        let extractedExpr = RFModalViewController(
            modalHeight: height * ratio,
            type: .recipe
        )
        let halfModal = extractedExpr
        present(halfModal, animated: true)
    }
}
