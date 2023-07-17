//
//  RecipeDetailView.swift
//  ReFree
//
//  Created by 이주훈 on 2023/07/17.
//

import UIKit
import Then
import SnapKit

final class RecipeDetailView: UIView {
    
    private enum CollectionSize {
        static var width: CGFloat {
            guard let frameWidth = Constant.screenSize?.width else { return 0 }
            return frameWidth - 48
        }
        
        static var height: CGFloat {
            return 250
        }
        
        static var defaultItemSize: CGSize {
            guard
                let width = Constant.screenSize?.width
            else { return CGSize(width: 0, height: 0) }
            return CGSize(width: width - 48, height: 100)
        }
    }
    
    lazy var recipeCollection = UICollectionView(
        frame: .zero,
        collectionViewLayout: flowLayout
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
    
    private lazy var flowLayout = UICollectionViewFlowLayout().then {
        $0.headerReferenceSize = CGSize(width: CollectionSize.width, height: CollectionSize.height)
        $0.scrollDirection = .vertical
        $0.minimumLineSpacing = 4
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        config()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func config() {
        recipeCollection.dataSource = self
        recipeCollection.delegate = self
        
        addSubview(recipeCollection)
        recipeCollection.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

extension RecipeDetailView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard
            let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: RecipeDetailCell.identifier,
            for: indexPath
        ) as? RecipeDetailCell
        else { return UICollectionViewCell() }
        
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
        
        return header
    }
}

extension RecipeDetailView: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        return CollectionSize.defaultItemSize
    }
}
