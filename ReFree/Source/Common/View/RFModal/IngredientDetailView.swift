//
//  IngredientDetailView.swift
//  ReFree
//
//  Created by 이주훈 on 2023/07/14.
//

import UIKit
import SnapKit
import Then
import RxSwift

final class IngredientDetailView: UIView {
    private let titleLabel = UILabel().then {
        $0.textColor = .refreeColor.main
        $0.font = .pretendard.basic30
        $0.textAlignment = .center
    }
    
    private let category = DetailStackView(kind: .category)
    private let expireDate = DetailStackView(kind: .expire)
    private let productCount = DetailStackView(kind: .count)
    private let memoLabel = UILabel().then {
        $0.text = "메모"
    }
    
    private lazy var contentStack = UIStackView(
        arrangedSubviews: [
            titleLabel,
            LineView(height: 0.5),
            category,
            LineView(height: 0.5),
            expireDate,
            LineView(height: 0.5),
            productCount,
            LineView(height: 0.5),
            memoLabel
        ]
    ).then {
        $0.alignment = .fill
        $0.spacing = 15
        $0.axis = .vertical
    }
    
    private let memoTextView = UITextView().then {
        $0.textColor = .refreeColor.text1
        $0.font = .pretendard.extraLight16
        $0.isUserInteractionEnabled = true
    }
    
    let deleteButton = UIButton().then {
        $0.layer.borderColor = UIColor.refreeColor.background3.cgColor
        $0.layer.borderWidth = 0.5
        $0.layer.cornerRadius = 25
        $0.setTitleColor(.black, for: .normal)
        $0.setTitle("삭제", for: .normal)
    }
    
    let editButton = UIButton().then {
        $0.backgroundColor = .refreeColor.background3
        $0.layer.cornerRadius = 25
        $0.setTitle("수정", for: .normal)
        $0.setTitleColor(.white, for: .normal)
    }
    
    private lazy var buttonStack = UIStackView(
        arrangedSubviews: [
            deleteButton,
            editButton
        ]
    ).then {
        $0.axis = .horizontal
    }
    
    private let ingredientRepository = IngredientRepository()
    private var disposeBag = DisposeBag()
    private var ingredient: Ingredient
    let errorSubject = PublishSubject<String>()
    let alertSubject = PublishSubject<String>()
    
    init(ingredient: Ingredient) {
        self.ingredient = ingredient
        super.init(frame: .zero)
        config(ingredient: ingredient)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func config(ingredient: Ingredient) {
        layout()
        bind(ingredient: ingredient)
    }
    
    private func layout() {
        addSubviews([
            contentStack,
            memoTextView,
            buttonStack
        ])
        
        contentStack.snp.makeConstraints {
            $0.top.equalToSuperview().inset(48)
            $0.leading.trailing.equalToSuperview().inset(48)
        }
        
        memoTextView.snp.makeConstraints {
            $0.top.equalTo(contentStack.snp.bottom)
            $0.leading.trailing.equalToSuperview().inset(48)
        }
        
        [deleteButton, editButton].forEach {
            $0.snp.makeConstraints {
                $0.width.equalTo(100)
                $0.height.equalTo(50)
            }
        }
        
        buttonStack.snp.makeConstraints {
            $0.top.equalTo(memoTextView.snp.bottom)
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().inset(48)
        }
    }
    
    private func bind(ingredient: Ingredient) {
        titleLabel.text = ingredient.title ?? ""
        category.text = ingredient.category ?? ""
        expireDate.text = ingredient.expireDate ?? ""
        productCount.text = "\(ingredient.count ?? 0)"
        memoTextView.text = ingredient.memo
        
        guard let id = ingredient.ingredientId else { return }
        ingredientRepository.request(detailIngredient: .detailIngredient(ingredientId: id))
            .subscribe(onNext: { [weak self] ingredients in
                guard
                    let self,
                    let ingredient = ingredients.first
                else { return }
                self.titleLabel.text = ingredient.title ?? ""
                self.category.text = ingredient.category ?? ""
                self.expireDate.text = ingredient.expireDate ?? ""
                self.productCount.text = "\(ingredient.count ?? 0)"
                self.memoTextView.text = ingredient.memo
            }, onError: { error in
                self.errorSubject.onNext(error.localizedDescription)
            })
            .disposed(by: disposeBag)
        
        deleteButton.rx.tap
            .subscribe(onNext: { [weak self] _ in
                self?.touchDeleteButton()
            }, onError: { error in
                //
            })
            .disposed(by: disposeBag)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        endEditing(true)
    }
    
    private func touchDeleteButton() {
        guard let id = ingredient.ingredientId else { return }
        ingredientRepository
            .request(deleteIngredient: .deleteIngredient(ingredientId: id))
            .subscribe(onNext: { [weak self] response in
                guard let self else { return }
                self.checkResponse(response: response)
                alertSubject.onNext("삭제가 완료되었습니다.")
            }, onError: { error in
                self.errorSubject.onNext(error.localizedDescription)
            })
            .disposed(by: disposeBag)
    }
}
