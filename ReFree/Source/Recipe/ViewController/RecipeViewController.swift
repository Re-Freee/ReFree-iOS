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
import Lottie

final class RecipeViewController: UIViewController {
    private enum Const {
        static let itemSize = {
            let width = Constant.screenSize.width
            let height = Constant.screenSize.height
            
            return CGSize(width: width*3/5, height: height*3/7)
        }()
        static let itemSpacing = 30.0
        
        static var insetX: CGFloat {
            return ( Constant.screenSize.width - self.itemSize.width) / 2.0
        }
        static var collectionViewContentInset: UIEdgeInsets {
            UIEdgeInsets(top: 0, left: Self.insetX, bottom: 0, right: Self.insetX)
        }
    }
    private lazy var loadingView = LoadingView(frame: .zero)
    private let header = RecipeTabHeader(frame: .zero)
    private let searchBar = RFSearchBar()
    private let nameTitle = UILabel().then {
        $0.textColor = .refreeColor.main
        $0.font = .pretendard.bold20
        $0.textAlignment = .center
        $0.text = "000님을 위한 추천 레시피"
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
        $0.backgroundColor = .refreeColor.lightGray
        $0.layer.cornerRadius = 15
        $0.pageIndicatorTintColor = .refreeColor.background3
        $0.currentPageIndicatorTintColor = .refreeColor.button1
        // TODO: ViewModel과 함께 설정
        $0.numberOfPages = 3
    }
    
    private let sidebar = RecipeSidebarView()
    private var previousIndex: Int?
    private var disposeBag = DisposeBag()
    
    private var recipes: [Recipe] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        config()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    private func config() {
        view.gradientBackground(type: .mainAxial)
        configNavigation()
        configCollectionView()
        layout()
        configLoadingAnimation()
        bind()
    }
    
    private func configNavigation() {
        let backButton = UIBarButtonItem(title: nil, style: .plain, target: self, action: nil)
        backButton.tintColor = .refreeColor.main
        navigationItem.backBarButtonItem = backButton
    }
    
    private func layout() {
        view.addSubviews([
            header,
            searchBar,
            nameTitle,
            carouselCollectionView,
            pageControl,
            loadingView,
            sidebar
        ])
        
        header.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(Constant.spacing24)
            $0.height.equalTo(50)
        }
        
        searchBar.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.top.equalTo(header.snp.bottom).offset(12)
        }
        
        nameTitle.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.top.equalTo(searchBar.snp.bottom).offset(30)
            $0.height.equalTo(70)
        }
        
        carouselCollectionView.snp.makeConstraints {
            $0.top.equalTo(nameTitle.snp.bottom)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide)
        }
        
        pageControl.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(24)
            $0.height.equalTo(30)
            $0.top.equalTo(carouselCollectionView.snp.bottom)
        }
        
        loadingView.snp.makeConstraints {
            $0.top.equalTo(header.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        sidebar.snp.makeConstraints {
            $0.top.bottom.equalTo(view.safeAreaLayoutGuide)
            $0.leading.equalToSuperview().offset(-280)
            $0.width.equalTo(250)
        }
    }
    
    private func configCollectionView() {
        carouselCollectionView.dataSource = self
        carouselCollectionView.delegate = self
    }
    
    private func configLoadingAnimation() {
        loadingView.isHidden = false
        searchBar.isHidden = true
        nameTitle.isHidden = true
        carouselCollectionView.isHidden = true
        pageControl.isHidden = true
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
        
        header.bookmarkButton.rx.tapGesture()
            .when(.recognized)
            .bind { [weak self] _ in
                let vc = SavedRecipeViewController(kind: .saved)
                self?.navigationController?.pushViewController(vc, animated: true)
            }
            .disposed(by: disposeBag)
        
        // TODO: 레시피 비동기 로딩이 끝나면 loadingCompelition 실행
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(5)) { [weak self] in
            self?.loadingCompletion()
        }
    }
    
    private func openSidebar() {
        sidebar.snp.remakeConstraints {
            $0.leading.equalToSuperview()
            $0.top.bottom.equalTo(view.safeAreaLayoutGuide)
            $0.width.equalTo(250)
        }
        
        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
        }
    }
    
    private func closeSidebar() {
        sidebar.snp.remakeConstraints {
            $0.top.bottom.equalTo(view.safeAreaLayoutGuide)
            $0.leading.equalToSuperview().offset(-280)
            $0.width.equalTo(250)
        }
        
        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
        }
    }
    
    private func loadingCompletion() {
        loadingView.isHidden = true
        searchBar.isHidden = false
        nameTitle.isHidden = false
        carouselCollectionView.isHidden = false
        pageControl.isHidden = false
    }
}

extension RecipeViewController: UICollectionViewDataSource {
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        recipes.count
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
        
        cell.prepareForReuse()
        cell.configCell(recipe: recipes[indexPath.row])
        
        return cell
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
    
    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        let ratio = 0.7
        let height = Constant.screenSize.height
        
        let extractedExpr = RFModalViewController(
            modalHeight: height * ratio,
            type: .recipe(recipes[indexPath.row])
        )
        let halfModal = extractedExpr
        present(halfModal, animated: true)
    }
}
