//
//  RecipeViewController.swift
//  ReFree
//
//  Created by 이주훈 on 2023/07/11.
//

import UIKit
import SnapKit
import Then

final class RecipeViewController: UIViewController {
    private enum Const {
       static let itemSize = CGSize(width: 300, height: 400)
       static let itemSpacing = 24.0
       
       static var insetX: CGFloat {
         (UIScreen.main.bounds.width - Self.itemSize.width) / 2.0
       }
       static var collectionViewContentInset: UIEdgeInsets {
         UIEdgeInsets(top: 0, left: Self.insetX, bottom: 0, right: Self.insetX)
       }
     }
    
    private lazy var carouselCollectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: carouselFlowLayout
    ).then {
        $0.isScrollEnabled = true
        $0.showsHorizontalScrollIndicator = false
        $0.showsVerticalScrollIndicator = false
        $0.backgroundColor = .clear
        $0.clipsToBounds = true
        $0.isPagingEnabled = false
        $0.contentInsetAdjustmentBehavior = .never
        $0.contentInset = Const.collectionViewContentInset
        $0.decelerationRate = .fast
        $0.translatesAutoresizingMaskIntoConstraints = false
        
        $0.register(
            RecipeTabHeader.self,
            forSupplementaryViewOfKind: RecipeTabHeader.identifier,
            withReuseIdentifier: RecipeTabHeader.identifier
        )
    }
    
    private let carouselFlowLayout = UICollectionViewFlowLayout().then {
        $0.scrollDirection = .horizontal
        $0.itemSize = Const.itemSize
        $0.minimumLineSpacing = Const.itemSpacing
        $0.minimumInteritemSpacing = 0
    }
    
    private let pageControl = UIPageControl().then {
        // TODO: 나중에 설정하자
        $0.numberOfPages = 3
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        config()
    }
    
    private func config() {
        layout()
    }
    
    private func layout() {
        view.addSubviews([carouselCollectionView, pageControl])
        
        carouselCollectionView.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
        }
        
        pageControl.snp.makeConstraints {
            $0.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(30)
            $0.top.equalTo(carouselCollectionView.snp.bottom).offset(Constant.spacing24)
        }
    }
}

extension RecipeViewController: UICollectionViewDelegateFlowLayout {
  func scrollViewWillEndDragging(
    _ scrollView: UIScrollView,
    withVelocity velocity: CGPoint,
    targetContentOffset: UnsafeMutablePointer<CGPoint>
  ) {
    let scrolledOffsetX = targetContentOffset.pointee.x + scrollView.contentInset.left
    let cellWidth = Const.itemSize.width + Const.itemSpacing
    let index = round(scrolledOffsetX / cellWidth)
    targetContentOffset.pointee = CGPoint(
        x: index * cellWidth - scrollView.contentInset.left,
        y: scrollView.contentInset.top
    )
  }
}
