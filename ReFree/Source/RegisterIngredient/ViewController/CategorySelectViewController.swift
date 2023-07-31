//
//  CategorySelectViewController.swift
//  ReFree
//
//  Created by 이주훈 on 2023/07/31.
//

import UIKit
import SnapKit
import Then
import RxSwift
import RxCocoa

final class CategorySelectViewController: UIViewController {
    private let searchBar = RFSearchBar(shadow: false).then {
        $0.removeShadow()
    }
    private let categoryTableView = UITableView().then {
        $0.backgroundColor = .clear
        $0.register(
            CategoryTableViewCell.self,
            forCellReuseIdentifier: CategoryTableViewCell.identifier
        )
    }
    private var disposeBag = DisposeBag()
    let selectedCategory = PublishSubject<String>()
    var tableViewItems = BehaviorSubject(value: Constant.category)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.gradientBackground(type: .mainAxial)
        layout()
        bind()
    }
    
    private func layout() {
        view.addSubviews([
            searchBar,
            categoryTableView
        ])
        
        searchBar.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview().inset(12)
        }
        
        categoryTableView.snp.makeConstraints {
            $0.top.equalTo(searchBar.snp.bottom).offset(24)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
    
    private func bind() {
        searchBar.textField.rx.text
            .debounce(.seconds(1), scheduler: MainScheduler.instance)
            .subscribe(onNext: { [weak self] searchText in
                let searchText = "\(searchText ?? "")"
                if searchText.isEmpty {
                    self?.tableViewItems.onNext(Constant.category)
                } else {
                    let searchedCategories = Constant.category.filter { category in
                        category.contains(searchText)
                    }
                    self?.tableViewItems.onNext(searchedCategories)
                }
            })
            .disposed(by: disposeBag)
        
        tableViewItems.asDriver(onErrorJustReturn: [])
            .drive(categoryTableView.rx.items(
                cellIdentifier: CategoryTableViewCell.identifier,
                cellType: CategoryTableViewCell.self)
            ) { ( _, category: String, cell: CategoryTableViewCell) in
                cell.prepareForReuse()
                cell.cellConfig(category: category)
            }
            .disposed(by: disposeBag)
        
        categoryTableView.rx.modelSelected(String.self)
            .asDriver()
            .drive(onNext: { [weak self] category in
                self?.selectedCategory.onNext(category)
                self?.dismiss(animated: true)
            })
            .disposed(by: disposeBag)
    }
}
