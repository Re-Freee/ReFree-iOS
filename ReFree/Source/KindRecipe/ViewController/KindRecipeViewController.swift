//
//  KindRecipeViewController.swift
//  ReFree
//
//  Created by 이주훈 on 2023/07/18.
//

import UIKit
import SnapKit
import Then
import RxSwift

final class KindRecipeViewController: UIViewController {
    enum TitleKind: String {
        case saved = "저장한 레시피"
        case bowl = "밥 레시피"
        case soup = "국&찌개 레시피"
        case dessert = "디저트 레시피"
        case sideMenu = "반찬 레시피"
        
        var searchQueryValue: String {
            switch self {
            case .saved: return "저장"
            case .bowl: return "밥"
            case .soup: return "국"
            case .dessert: return "후식"
            case .sideMenu: return "반찬"
            }
        }
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
    
    private let kind: TitleKind
    private var recipes: [Recipe] = []
    private var disposeBag = DisposeBag()
    private let recipeRepository = RecipeRepository()
    private var pageCount = 0
    
    init(kind: KindRecipeViewController.TitleKind) {
        self.kind = kind
        super.init(nibName: nil, bundle: Bundle.main)
        titleLabel.text = kind.rawValue
        if kind == .saved { searchBar.isHidden = true }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
        bind()
        dataLoading(page: pageCount)
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
        
        if kind == .saved {
            collectionView.snp.makeConstraints {
                $0.top.equalTo(titleLabel.snp.bottom).offset(12)
                $0.leading.trailing.equalToSuperview()
                $0.bottom.equalTo(view.safeAreaLayoutGuide)
            }
        } else {
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
    
    private func bind() {
        collectionView.rx.prefetchItems
            .compactMap(\.last?.row)
            .withUnretained(self)
            .bind { vc, row in
                guard row == vc.recipes.count - 1 else { return }
                vc.pageCount += 10
                vc.dataLoading(page: vc.pageCount)
            }
            .disposed(by: self.disposeBag)
        
        searchBar.searchStart.rx.tap
            .bind(onNext: { [weak self] in
                guard let self else { return }
                self.pageCount = 0
                self.recipes = []
                self.dataLoading(page: self.pageCount)
            })
            .disposed(by: disposeBag)
    }
    
    private func dataLoading(page: Int) {
        let isSearch = !(searchBar.textField.text ?? "").isEmpty
        if kind == TitleKind.saved {
            recipeRepository.request(savedRecipe: .savedRecipe)
                .subscribe(onNext: { [weak self] (commonResponse, recipes) in
                    guard
                        let self,
                        self.responseCheck(response: commonResponse)
                    else { return }
                    
                    self.recipes += recipes
                    self.collectionView.reloadData()
                }, onError: { [weak self] error in
                    guard let self else { return }
                    Alert.errorAlert(
                        viewController: self,
                        errorMessage: error.localizedDescription
                    )
                })
                .disposed(by: disposeBag)
        } else {
            if isSearch {
                recipeRepository.request(
                    searchRecipe: .searchRecipe(
                        query: [
                            .init("type", kind.searchQueryValue),
                            .init("title", searchBar.textField.text ?? ""),
                            .init("offset", page)
                        ]
                    )
                )
                .subscribe(onNext: { [weak self] (commonResponse, recipes) in
                    guard
                        let self,
                        self.responseCheck(response: commonResponse)
                    else { return }
                    self.recipes += recipes
                    self.collectionView.reloadData()
                }, onError: { [weak self] error in
                    guard let self else { return }
                    Alert.errorAlert(
                        viewController: self,
                        errorMessage: error.localizedDescription
                    )
                })
                .disposed(by: disposeBag)
            } else {
                recipeRepository.request(
                    searchRecipe: .searchRecipe(
                        query: [.init("type", kind.searchQueryValue), .init("offset", page)]
                    )
                )
                .subscribe(onNext: { [weak self] (commonResponse, recipes) in
                    guard
                        let self,
                        self.responseCheck(response: commonResponse)
                    else { return }
                    self.recipes += recipes
                    self.collectionView.reloadData()
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
        tabBarController?
            .navigationController?
            .pushViewController(
            modalVC,
            animated: false
        )
    }
}
