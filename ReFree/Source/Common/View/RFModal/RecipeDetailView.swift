//
//  RecipeDetailView.swift
//  ReFree
//
//  Created by 이주훈 on 2023/07/17.
//

import UIKit
import Then
import SnapKit
import RxSwift

final class RecipeDetailView: UIView {
    private enum CollectionSize {
        static var headerWidth: CGFloat {
            return Constant.screenSize.width - 48
        }
        
        static var headerHeight: CGFloat {
            return 200
        }
        
        static var defaultItemSize: CGSize {
            return CGSize(width: Constant.screenSize.width - 48, height: 100)
        }
    }
    
    private lazy var recipeCollection = UICollectionView(
        frame: .zero,
        collectionViewLayout: collectionViewLayout()
    ).then {
        $0.register(
            RecipeDetailHeaderView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: RecipeDetailHeaderView.identifier
        )
        $0.register(
            RecipeDetailCell.self,
            forCellWithReuseIdentifier: RecipeDetailCell.identifier
        )
    }
    
    private var recipe: Recipe?
    private var manual: [Manual] = []
    private let recipeRepository = RecipeRepository()
    private var disposeBag = DisposeBag()
    private var headerDisposeBag = DisposeBag()
    let errorSubject = PublishSubject<String>()
    
    
    init(recipe: Recipe) {
        super.init(frame: .zero)
        config()
        configView(recipe: recipe)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func config() {
        recipeCollection.dataSource = self
        layout()
    }
    
    private func layout() {
        addSubview(recipeCollection)
        recipeCollection.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    private func collectionViewLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { _, _ in
            let item = NSCollectionLayoutItem(
                layoutSize: .init(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .estimated(100)
                )
            )
            let group = NSCollectionLayoutGroup.vertical(
                layoutSize: .init(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .estimated(100)
                ),
                subitems: [item]
            )
            let section = NSCollectionLayoutSection(group: group)
            section.interGroupSpacing = 8
            section.contentInsets = .init(top: 4, leading: 24, bottom: 4, trailing: 24)
            
            section.boundarySupplementaryItems = [
                NSCollectionLayoutBoundarySupplementaryItem(
                    layoutSize: .init(
                        widthDimension: .fractionalWidth(1),
                        heightDimension: .estimated(CollectionSize.headerHeight)
                    ),
                    elementKind: UICollectionView.elementKindSectionHeader,
                    alignment: .top
                )
            ]
            
            return section
        }
    }
    
    func configView(recipe: Recipe) {
        self.recipe = recipe
        recipeRepository
            .request(detailRecipe: .detailRecipe(recipeID: recipe.id))
            .subscribe(onNext: { [weak self] (commonResponse, manual) in
                guard
                    let self,
                    self.responseCheck(response: commonResponse)
                else { return }
                
                self.manual = manual
                self.recipeCollection.reloadData()
            }, onError: { error in
                self.errorSubject.onNext(error.localizedDescription)
            })
            .disposed(by: disposeBag)
        
        recipeCollection.reloadData()
    }
}

extension RecipeDetailView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        manual.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard
            let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: RecipeDetailCell.identifier,
            for: indexPath
        ) as? RecipeDetailCell
        else { return UICollectionViewCell() }
        
        cell.prepareForReuse()
        cell.configCell(manual: manual[indexPath.row])
        
        return cell
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        viewForSupplementaryElementOfKind kind: String,
        at indexPath: IndexPath
    ) -> UICollectionReusableView {
        guard
            let header = collectionView.dequeueReusableSupplementaryView(
                ofKind: UICollectionView.elementKindSectionHeader,
                withReuseIdentifier: RecipeDetailHeaderView.identifier,
                for: indexPath
            ) as? RecipeDetailHeaderView
        else { return UICollectionReusableView() }
        
        headerDisposeBag = DisposeBag()
        header.bookmarkButton.rx.tap
            .bind(onNext: { [weak self] in
                self?.toggleBookMarkButton {
                    header.bookmarkButton.isEnabled = true
                }
                guard let isHeart =  self?.recipe?.isHeart else { return }
                self?.recipe?.isHeart = !isHeart
                header.isBookmarked = !isHeart
                header.bookmarkButton.isEnabled = false
            })
            .disposed(by: headerDisposeBag)
        
        guard let recipe = recipe else { return header }
        header.configHeader(recipe: recipe)
        
        return header
    }
    
    private func toggleBookMarkButton(complete: @escaping () -> ()) {
        guard let id = recipe?.id else { return }
        recipeRepository.request(bookMark: .bookMark(recipeID: id))
            .subscribe(onNext: { response in
                complete()
            }, onError: { error in
                //
            })
            .disposed(by: self.disposeBag)
    }
}
