//
//  RecipeViewController.swift
//  ReFree
//
//  Created by 이주훈 on 2023/07/11.
//

import UIKit
import SnapKit
import Then
import RxSwift
import RxGesture

final class RecipeViewController: UIViewController {
    private enum Const {
        static let itemSize = CGSize(width: 250, height: 400)
        static let itemSpacing = 30.0
        
        static var insetX: CGFloat {
            (UIScreen.main.bounds.width - Self.itemSize.width) / 2.0
        }
        static var collectionViewContentInset: UIEdgeInsets {
            UIEdgeInsets(top: 0, left: Self.insetX, bottom: 0, right: Self.insetX)
        }
    }
    private let header = RecipeTabHeader(frame: .zero)
    
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
            CarouselCell.self,
            forCellWithReuseIdentifier: CarouselCell.identifier
        )
    }
    
    private lazy var carouselFlowLayout = UICollectionViewFlowLayout().then {
        $0.scrollDirection = .horizontal
        $0.itemSize = Const.itemSize
        $0.minimumLineSpacing = Const.itemSpacing
        $0.minimumInteritemSpacing = 0
    }
    
    private let pageControl = UIPageControl().then {
        $0.layer.cornerRadius = 15
        $0.backgroundColor = .refreeColor.selectedBack
        $0.pageIndicatorTintColor = .refreeColor.background3
        $0.currentPageIndicatorTintColor = .refreeColor.unSelectedIcon
        // TODO: ViewModel과 함께 설정
        $0.numberOfPages = 3
    }
    
    private let sidebar = RecipeSidebarView()
    private var previousIndex: Int?
    private var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        config()
    }
    
    private func config() {
        view.gradientBackground(type: .reverseMainAxial)
        layout()
        configCollectionView()
        bind()
    }
    
    private func layout() {
        view.addSubviews([header, carouselCollectionView, pageControl, sidebar])
        
        header.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(Constant.spacing24)
        }
        
        carouselCollectionView.snp.makeConstraints {
            $0.top.equalTo(header.snp.bottom)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide)
        }
        
        pageControl.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(24)
            $0.height.equalTo(30)
            $0.top.equalTo(carouselCollectionView.snp.bottom)
        }
        
        sidebar.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.leading.equalToSuperview().offset(-280)
            $0.width.equalTo(250)
        }
    }
    
    private func configCollectionView() {
        carouselCollectionView.dataSource = self
        carouselCollectionView.delegate = self
    }
    
    private func bind() {
        header.sideBarToggleButton.rx.tapGesture()
            .when(.recognized)
            .bind { [weak self] _ in
                self?.openSidebar()
            }
            .disposed(by: disposeBag)
        
        let swipe = sidebar.rx.swipeGesture(.left).when(.recognized)
            .map { _ in return Void() }
        let sidebarCloseButtonTap = sidebar.backButton.rx.tap
            .map { _ in return Void() }
    
        Observable.merge([
            swipe,
            sidebarCloseButtonTap,
        ])
        .subscribe { [weak self] _ in
            self?.closeSidebar()
        }
        .disposed(by: disposeBag)
    }
    
    private func openSidebar() {
        sidebar.snp.remakeConstraints {
            $0.top.bottom.leading.equalToSuperview()
            $0.width.equalTo(250)
        }
        
        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
        }
    }
    
    private func closeSidebar() {
        sidebar.snp.remakeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.leading.equalToSuperview().offset(-280)
            $0.width.equalTo(250)
        }
        
        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
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
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let scrolledOffset = scrollView.contentOffset.x + scrollView.contentInset.left
        let cellWidth = Const.itemSize.width + Const.itemSpacing
        let index = Int(round(scrolledOffset / cellWidth))
        
        guard
            let previousIndex,
            previousIndex != index
        else { return }
        
        let prevCell = carouselCollectionView.cellForItem(at: IndexPath(row: previousIndex, section: 0))
        let currentCell = carouselCollectionView.cellForItem(at: IndexPath(row: index, section: 0))
        
        UIView.animate(withDuration: 0.5) {
            prevCell?.transform = CGAffineTransform(scaleX: 1, y: 1)
            currentCell?.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
        }
        
        self.previousIndex = index
        pageControl.currentPage = index
    }
}

extension RecipeViewController: UICollectionViewDataSource {
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        3
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: CarouselCell.identifier,
            for: indexPath
        ) as? CarouselCell else { return UICollectionViewCell() }
        
        if previousIndex == nil {
            UIView.animate(withDuration: 1) {
                cell.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
            }
            previousIndex = 0
        }
        
        cell.setData()
        
        return cell
    }
}
