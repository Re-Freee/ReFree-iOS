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
            
            return CGSize(width: width*0.7, height: height*0.45)
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
        $0.clipsToBounds = false
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
        $0.numberOfPages = 3
    }
    
    let recipeRepository = RecipeRepository()
    let userRepository = UserRepository()
    let signRepository = SignRepository()
    private let sidebar = RecipeSidebarView()
    private var previousIndex: Int = 0
    private var disposeBag = DisposeBag()
    
    private var recipes: [Recipe] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        config()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
        bind()
    }
    
    private func config() {
        view.gradientBackground(type: .mainAxial)
        configNavigation()
        configCollectionView()
        layout()
        loadingStart()
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
        pageControlIsHiddenByScreenWidth(isHidden: true)
    }
    
    private func pageControlIsHiddenByScreenWidth(isHidden: Bool) {
        if isHidden {
            if Constant.screenSize.width < 400 {
                pageControl.layer.opacity = 0
            } else {
                pageControl.layer.opacity = 1
            }
        } else {
            pageControl.layer.opacity = 0
        }
    }
    
    private func configCollectionView() {
        carouselCollectionView.dataSource = self
        carouselCollectionView.delegate = self
    }
    
    private func loadingStart() {
        loadingView.isHidden = false
        searchBar.isHidden = true
        nameTitle.isHidden = true
        carouselCollectionView.isHidden = true
        pageControl.isHidden = true
    }
    
    private func loadingCompletion() {
        loadingView.isHidden = true
        searchBar.isHidden = false
        nameTitle.isHidden = false
        carouselCollectionView.isHidden = false
        pageControl.isHidden = false
    }
    
    private func bind() {
        disposeBag = DisposeBag()
        bindUser()
        bindHeader()
        bindSidebar()
        bindRecommendRecipe()
        bindSearch()
    }
    
    private func bindUser() {
        if let nickName = userRepository.getUserNickName() {
            nameTitle.text = "\(nickName)님을 위한 추천 레시피"
        } else {
            signRepository.request(userNickName: .userNickName)
                .subscribe(onNext: { [weak self] commonResponse in
                    guard
                        let self,
                        self.responseCheck(response: commonResponse)
                    else { return }
                    let nickName = commonResponse.message
                    self.userRepository.setUserNickName(nickName: nickName)
                    self.nameTitle.text = "\(nickName)님을 위한 추천 레시피"
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
    
    private func bindHeader() {
        header.bookmarkButton.rx.tapGesture()
            .when(.recognized)
            .bind { [weak self] _ in
                let vc = KindRecipeViewController(kind: .saved)
                self?.navigationController?.pushViewController(vc, animated: true)
            }
            .disposed(by: disposeBag)
        
        recipeRepository.request(savedRecipe: .savedRecipe)
            .subscribe(onNext: { [weak self] (commonResponse, recipes) in
                guard
                    let self,
                    self.responseCheck(response: commonResponse)
                else { return }
                self.header.bookmarkButton.setCount(count: recipes.count)
            }, onError: { [weak self] error in
                guard let self else { return }
                Alert.errorAlert(
                    viewController: self,
                    errorMessage: error.localizedDescription
                )
            })
            .disposed(by: disposeBag)
    }
    
    private func bindSidebar() {
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
        
        [
            (sidebar.bowlStack, KindRecipeViewController.TitleKind.bowl),
            (sidebar.soupStack, KindRecipeViewController.TitleKind.soup),
            (sidebar.dessertStack, KindRecipeViewController.TitleKind.dessert),
            (sidebar.sideStack, KindRecipeViewController.TitleKind.sideMenu),
            (sidebar.saveStack, KindRecipeViewController.TitleKind.saved),
        ].forEach { (sideView, kind) in
            sideView.rx.tapGesture()
                .when(.ended)
                .bind { [weak self] _ in
                    let viewController = KindRecipeViewController(kind: kind)
                    self?.navigationController?.pushViewController(
                        viewController,
                        animated: true
                    )
                    self?.closeSidebar()
                }
                .disposed(by: disposeBag)
        }
    }
    
    private func bindRecommendRecipe() {
        recipeRepository.request(
            recommendRecipe: .recommendRecipe
        )
        .subscribe(onNext: { [weak self] (commonResponse, recipes) in
            guard
                let self,
                self.responseCheck(response: commonResponse)
            else { self?.loadingCompletion(); return }
            self.recipes = recipes
            self.carouselCollectionView.reloadData()
            self.loadingCompletion()
        }, onError: { [weak self] error in
            guard let self else { return }
            Alert.errorAlert(
                viewController: self,
                errorMessage: error.localizedDescription
            )
            self.loadingCompletion()
        })
        .disposed(by: disposeBag)  
    }
    
    private func bindSearch() {
        searchBar.textField.delegate = self
        searchBar.searchStart.rx.tap
            .bind(onNext: { [weak self] in
                guard let self else { return }
                self.searchRecipe(text: self.searchBar.textField.text ?? "")
                self.view.endEditing(true)
            })
            .disposed(by: disposeBag)
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
    
    private func searchRecipe(text: String) {
        if text.isEmpty {
            pageControlIsHiddenByScreenWidth(isHidden: true)
            bindRecommendRecipe()
        } else {
            let searchVC = KindRecipeViewController(
                kind: .onlySearch,
                onlySearchKey: text
            )
            navigationController?.pushViewController(searchVC, animated: true)
        }
        
//        loadingStart()
//        if text.isEmpty {
//            pageControlIsHiddenByScreenWidth(isHidden: true)
//            bindRecommendRecipe()
//        } else {
//            pageControlIsHiddenByScreenWidth(isHidden: false)
//            recipeRepository.request(
//                searchRecipe: .searchRecipe(
//                    query: [
//                        .init("title", text),
//                        .init("offset", 0)
//                    ]
//                )
//            )
//            .subscribe(onNext: { [weak self] (commonResponse, recipes) in
//                guard
//                    let self,
//                    self.responseCheck(response: commonResponse)
//                else { return }
//                self.recipes = recipes
//                self.carouselCollectionView.reloadData()
//                self.loadingCompletion()
//            }, onError: { [weak self] error in
//                guard let self else { return }
//                Alert.errorAlert(
//                    viewController: self,
//                    errorMessage: error.localizedDescription
//                )
//                self.loadingCompletion()
//            })
//            .disposed(by: disposeBag)
//        }
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
        
        if previousIndex == indexPath.row {
            UIView.animate(withDuration: 1) {
                cell.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
            }
        }
        
        cell.prepareForReuse()
        cell.configCell(recipe: recipes[indexPath.row])
        
        return cell
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
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
            previousIndex != index
        else { return }
        
        let prevCell = carouselCollectionView
            .cellForItem(at: IndexPath(row: previousIndex, section: 0))
        let currentCell = carouselCollectionView
            .cellForItem(at: IndexPath(row: index, section: 0))
        
        UIView.animate(withDuration: 0.5) {
            prevCell?.transform = CGAffineTransform(scaleX: 1, y: 1)
            currentCell?.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
        }
        
        self.previousIndex = index
        pageControl.currentPage = index
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        view.endEditing(true)
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        let modalVC = RFModalParentViewController(type: .recipe(recipes[indexPath.row]))
        tabBarController?
            .navigationController?
            .pushViewController(
            modalVC,
            animated: false
        )
    }
}

extension RecipeViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchRecipe(text: self.searchBar.textField.text ?? "")
        view.endEditing(true)
        return true
    }
}
