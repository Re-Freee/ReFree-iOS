//
//  IngredientInfoView.swift
//  ReFree
//
//  Created by 이주훈 on 2023/07/29.
//

import UIKit
import SnapKit
import Then


final class IngredientInfoView: UIView {
    let selectIngredientKind = UISegmentedControl().then { segment in
        let defaultFont = UIFont.systemFont(ofSize: 16)
        segment.setTitleTextAttributes(
            [.foregroundColor: UIColor.refreeColor.button1, .font: UIFont.pretendard.bold16 ?? defaultFont],
            for: .normal
        )
        segment.setTitleTextAttributes(
            [.foregroundColor: UIColor.refreeColor.text3, .font: UIFont.pretendard.bold20 ?? defaultFont],
            for: .selected
        )
        segment.selectedSegmentTintColor = .refreeColor.button1
        segment.backgroundColor = .refreeColor.textFrame
        ["냉장", "냉동", "실외", "기타"].enumerated().forEach { (index: Int, element: String) in
            segment.insertSegment(withTitle: element, at: index, animated: true)
        }
        segment.selectedSegmentIndex = 0
    }
    
    private let nameLabel = UILabel().then {
        $0.textColor = .refreeColor.main
        $0.font = .pretendard.bold20
        $0.textAlignment = .left
        $0.text = "이름"
    }
    
    let nameTextField = UITextField().then {
        $0.addLeftPadding(padding: 10)
        $0.clipsToBounds = true
        $0.backgroundColor = .refreeColor.textFrame
        $0.layer.cornerRadius = 10
    }
    
    private let categoryLabel = UILabel().then {
        $0.textColor = .refreeColor.main
        $0.font = .pretendard.bold20
        $0.textAlignment = .left
        $0.text = "카테고리"
    }
    
    let categorySelectLabel = PaddingLabel().then {
        $0.clipsToBounds = true
        $0.backgroundColor = .refreeColor.textFrame
        $0.layer.cornerRadius = 10
    }
    
    private let expireLabel = UILabel().then {
        $0.textColor = .refreeColor.main
        $0.font = .pretendard.bold20
        $0.textAlignment = .left
        $0.text = "소비기한"
    }
    
    let expireDatePicker = UIDatePicker().then {
        $0.locale = Locale(identifier: "ko_KR")
        $0.date = .now
        $0.preferredDatePickerStyle = .compact
        $0.datePickerMode = .date
    }
    
    private let countLabel = UILabel().then {
        $0.textColor = .refreeColor.main
        $0.font = .pretendard.bold20
        $0.textAlignment = .left
        $0.text = "수량"
    }
    
    let minusCountButton = UIButton().then {
        $0.contentHorizontalAlignment = .fill
        $0.contentVerticalAlignment = .fill
        $0.setImage(
            UIImage(systemName: "minus.circle.fill")?
                .withTintColor(.refreeColor.button1, renderingMode: .alwaysOriginal),
            for: .normal
        )
    }
    
    let currentCountLabel = UILabel().then {
        $0.textColor = .refreeColor.main
        $0.font = .pretendard.bold20
        $0.textAlignment = .center
        $0.text = "1"
    }
    
    let plusCountButton = UIButton().then {
        $0.contentHorizontalAlignment = .fill
        $0.contentVerticalAlignment = .fill
        $0.setImage(
            UIImage(systemName: "plus.circle.fill")?
                .withTintColor(.refreeColor.button1, renderingMode: .alwaysOriginal),
            for: .normal
        )
    }
    
    private let memoLabel = UILabel().then {
        $0.textColor = .refreeColor.main
        $0.font = .pretendard.bold20
        $0.textAlignment = .left
        $0.text = "메모"
    }
    
    private lazy var countStack = UIStackView(
        arrangedSubviews: [
            minusCountButton,
            currentCountLabel,
            plusCountButton
        ]
    ).then {
        $0.distribution = .equalSpacing
        $0.alignment = .fill
        $0.spacing = 12
        $0.axis = .horizontal
    }
    
    let memoTextView = UITextView().then {
        $0.font = .pretendard.extraLight20
        $0.clipsToBounds = true
        $0.backgroundColor = .refreeColor.textFrame
        $0.layer.cornerRadius = 10
    }
    
    let saveButton = UIButton().then {
        $0.layer.cornerRadius = 15
        $0.backgroundColor = .refreeColor.button1
        let text = "save"
        let range = (text as NSString).range(of: text)
        let font = UIFont.pretendard.bold24 ?? UIFont.systemFont(ofSize: 30)
        let color = UIColor.refreeColor.text3
        let attrString = NSMutableAttributedString(string: text)
        attrString.addAttribute(.font, value: font, range: range)
        attrString.addAttribute(.foregroundColor, value: color, range: range)
        $0.setAttributedTitle(attrString, for: .normal)
    }
    
    init() {
        super.init(frame: .zero)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layout() {
        backgroundColor = .white
        layer.cornerRadius = 15
        layer.maskedCorners = CACornerMask(arrayLiteral: .layerMinXMinYCorner, .layerMaxXMinYCorner)
        
        addSubviews(
            [
                selectIngredientKind,
                nameLabel,
                nameTextField,
                categoryLabel,
                categorySelectLabel,
                expireLabel,
                expireDatePicker,
                countLabel,
                countStack,
                memoLabel,
                memoTextView,
                saveButton
            ]
        )
        layoutSegment()
        layoutName()
        layoutCategory()
        layoutExpireDate()
        layoutCount()
        layoutMemo()
        layoutSaveButton()
    }
    
    private func layoutSegment() {
        selectIngredientKind.snp.makeConstraints {
            $0.top.equalToSuperview().inset(24)
            $0.leading.trailing.equalToSuperview().inset(24)
        }
    }
    
    private func layoutName() {
        nameLabel.snp.makeConstraints {
            $0.top.equalTo(selectIngredientKind.snp.bottom).offset(12)
            $0.height.equalTo(30)
            $0.leading.trailing.equalToSuperview().inset(24)
        }
        
        nameTextField.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom).offset(4)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.height.equalTo(30)
        }
    }
    
    private func layoutCategory() {
        categoryLabel.snp.makeConstraints {
            $0.top.equalTo(nameTextField.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(24)
        }
        
        categorySelectLabel.snp.makeConstraints {
            $0.top.equalTo(categoryLabel.snp.bottom).offset(4)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.height.equalTo(30)
        }
    }
    
    private func layoutExpireDate() {
        expireLabel.snp.makeConstraints {
            $0.top.equalTo(categorySelectLabel.snp.bottom).offset(20)
            $0.leading.equalToSuperview().inset(24)
        }
        
        expireDatePicker.sizeToFit()
        
        expireDatePicker.snp.makeConstraints {
            $0.centerY.equalTo(expireLabel.snp.centerY)
            $0.trailing.equalToSuperview().inset(24)
            $0.width.equalTo(expireDatePicker.frame.width)
            $0.height.equalTo(expireDatePicker.frame.height)
        }
    }
    
    private func layoutCount() {
        countLabel.snp.makeConstraints {
            $0.top.equalTo(expireDatePicker.snp.bottom).offset(24)
            $0.leading.equalToSuperview().inset(24)
        }
        
        minusCountButton.snp.makeConstraints {
            $0.width.height.equalTo(30)
        }

        plusCountButton.snp.makeConstraints {
            $0.width.height.equalTo(30)
        }
        
        countStack.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(24)
            $0.centerY.equalTo(countLabel)
        }
    }
    
    private func layoutMemo() {
        memoLabel.snp.makeConstraints {
            $0.top.equalTo(countLabel.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(24)
        }
        
        memoTextView.snp.makeConstraints {
            $0.top.equalTo(memoLabel.snp.bottom).offset(4)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.height.equalTo(150)
        }
    }
    
    private func layoutSaveButton() {
        saveButton.snp.makeConstraints {
            $0.top.equalTo(memoTextView.snp.bottom).offset(24)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.height.equalTo(40)
            $0.bottom.equalToSuperview().inset(24)
        }
    }
}
