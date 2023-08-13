//
//  RegisterIngredientViewController.swift
//  ReFree
//
//  Created by 이주훈 on 2023/07/29.
//

import UIKit
import PhotosUI
import AVFoundation
import SnapKit
import Then
import RxSwift
import RxGesture

final class RegisterIngredientViewController: UIViewController {
    final class CustomScrollView: UIScrollView {
        override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            super.touchesBegan(touches, with: event)
            endEditing(true)
        }
    }
    
    private let scrollVIew = CustomScrollView()
    private let scrollContentView = UIView()
    private let titleLabel = UILabel().then {
        $0.textColor = .refreeColor.main
        $0.font = .pretendard.extraBold30
        $0.text = "음식 추가"
    }
    private let cameraView = CameraView()
    private let ingredientInfoView = IngredientInfoView()
    private var disposeBag = DisposeBag()
    private let ingredientRepository = IngredientRepository()
    
    private var category: [String] = []
    
    private var info = Ingredient()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.gradientBackground(type: .mainAxial)
        config()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardUp),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardDown),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(
            self,
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        NotificationCenter.default.removeObserver(
            self,
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }
    
    private func config() {
        layout()
        bind()
    }
    
    private func layout() {
        view.addSubview(scrollVIew)
        scrollVIew.addSubview(scrollContentView)
        scrollContentView.addSubviews([titleLabel, cameraView, ingredientInfoView])
        
        scrollVIew.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        scrollContentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalTo(scrollVIew.snp.width)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(24)
        }
        
        cameraView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(24)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.height.equalTo(150)
        }
        
        ingredientInfoView.snp.makeConstraints {
            $0.top.equalTo(cameraView.snp.bottom).offset(12)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview()
        }
    }
    
    private func bind() {
        bindIngredientView()
        bindCameraView()
        bindKeyboard()
    }
    
    private func bindKeyboard() {
        
    }
    
    private func bindIngredientView() {
        ingredientInfoView.selectIngredientKind.rx.selectedSegmentIndex
            .asDriver(onErrorJustReturn: 0)
            .drive(onNext: { [weak self] index in
                guard
                    let self,
                    let saveMethod = self
                        .ingredientInfoView
                        .selectIngredientKind
                        .titleForSegment(at: index)
                else { return }
                
                self.info = self.info.setSaveMethod(method: saveMethod)
            })
            .disposed(by: disposeBag)
        
        ingredientInfoView.nameTextField.rx.text.orEmpty
            .distinctUntilChanged()
            .skip(1)
            .debounce(.milliseconds(500), scheduler: MainScheduler.instance)
            .map { $0 as String }
            .bind { [weak self] text in
                guard let self else { return }
                self.info = self.info.setTitle(title: text)
                var categories: [String] = []
                Constant.category.forEach { category in
                    if text.contains(category) {
                        categories.append(category)
                    }
                }
                self.ingredientInfoView.categoryRecommand(categories: categories)
            }.disposed(by: disposeBag)
        
        ingredientInfoView.categorySubject.asDriver(onErrorJustReturn: "기타")
            .drive(onNext: { [weak self] category in
                guard let self else { return }
                guard let category else {
                    self.info = self.info.setCategory(category: nil)
                    return
                }
                self.info = self.info.setCategory(category: category)
            })
            .disposed(by: disposeBag)
        
        ingredientInfoView.categorySelectButton.rx.tapGesture()
            .when(.recognized)
            .bind { [weak self] _ in
                guard let self else { return }
                let categoryVC = CategorySelectViewController()
                
                categoryVC.selectedCategory.asDriver(onErrorJustReturn: "기타")
                    .drive { category in
                        if !category.isEmpty {
                            self.ingredientInfoView.categoryRecommand(
                                categories: [category]
                            )
                        }
                    }
                    .disposed(by: self.disposeBag)
                
                self.present(categoryVC, animated: true)
            }
            .disposed(by: disposeBag)
        
        ingredientInfoView.categoryStack.arrangedSubviews.forEach {
            guard
                let categoryLabel = $0 as? CategorySelectLabel
            else { return }
            
            categoryLabel.rx.tapGesture()
                .when(.recognized)
                .bind { [weak self] _ in
                    guard let categoryText = categoryLabel.text else { return }
                    self?.ingredientInfoView.categoryRecommand(categories: [categoryText])
                }
                .disposed(by: disposeBag)
        }
        
        ingredientInfoView.expireDatePicker.rx.date
            .map { $0 as Date }
            .subscribe(onNext: { [weak self] date in
                guard let self else { return }
                let dateString = date.toString()
                self.info = self.info.setExpireDate(date: dateString)
            })
            .disposed(by: disposeBag)
        
        ingredientInfoView.plusCountButton.rx.tap
            .bind { [weak self] _ in
                self?.ingredientInfoView.countPlus()
            }
            .disposed(by: disposeBag)
        
        ingredientInfoView.minusCountButton.rx.tap
            .bind { [weak self] _ in
                self?.ingredientInfoView.countMinus()
            }
            .disposed(by: disposeBag)
        
        ingredientInfoView.countSubject.asDriver(onErrorJustReturn: "1")
            .drive(onNext: { [weak self] count in
                guard
                    let self,
                    let count = Int(count)
                else { return }
                self.info = self.info.setCount(count: count)
            })
            .disposed(by: disposeBag)
        
        ingredientInfoView.saveButton.rx.tapGesture()
            .when(.recognized)
            .bind { [weak self] _ in
                guard
                    let self,
                    self.validCheck()
                else { return }
                
                let alert = AlertView(
                    title: "잠깐!",
                    description: "그대로 저장하시겠습니까?",
                    alertType: .question
                )
                alert.addAction(kind: .success) {
                    self.registerIngredientHandling()
                }
                self.view.addSubview(alert)
            }.disposed(by: disposeBag)
        
        ingredientInfoView.memoTextView.rx.text
            .distinctUntilChanged()
            .subscribe(onNext: { [weak self] memoText in
                guard let self else { return }
                self.info = self.info.setMemo(memo: (memoText ?? "") as String)
            })
            .disposed(by: disposeBag)
    }
    
    private func bindCameraView() {
        cameraView.currentImage
            .subscribe(onNext: { [weak self] image in
                guard let self else { return }
                self.info = self.info.setImage(image: image)
            })
            .disposed(by: disposeBag)
        
        cameraView.rx.tapGesture()
            .when(.recognized)
            .bind { [weak self] _ in
                self?.bindCamera()
            }
            .disposed(by: disposeBag)
    }
    
    private func bindCamera() {
        let alert = UIAlertController(
            title: "사진 등록",
            message: "어떻게 사진을 등록 하시겠어요?",
            preferredStyle: .actionSheet
        )
        
        let takePhto = UIAlertAction(
            title: "사진 찍기",
            style: .default
        ) { [weak self] _ in
            self?.startCamera()
        }
        
        let selectPhoto = UIAlertAction(
            title: "앨범에서 선택",
            style: .default
        ) { [weak self] _ in
            self?.startAlbum()
        }
        
        let deleteImage = UIAlertAction(
            title: "이미지 제거",
            style: .default
        ) { [weak self] _ in
            self?.cameraView.setDefault()
        }
        
        let cancel = UIAlertAction(
            title: "취소",
            style: .destructive
        )
        
        alert.addAction(takePhto)
        alert.addAction(selectPhoto)
        if (try? cameraView.currentImage.value()) != UIImage(named: "Camera1") {
            alert.addAction(deleteImage)
        }
        alert.addAction(cancel)
        present(alert, animated: true)
    }
    
    private func startCamera() {
        AVCaptureDevice.requestAccess(for: .video) { isAccess in
            if isAccess {
                DispatchQueue.main.async { [weak self] in
                    let pickerController = UIImagePickerController()
                    pickerController.sourceType = .camera
                    pickerController.allowsEditing = false
                    pickerController.mediaTypes = ["public.image"]
                    pickerController.cameraFlashMode = .off
                    pickerController.delegate = self
                    self?.present(pickerController, animated: true)
                }
            } else {
                DispatchQueue.main.async { [weak self] in
                    let alert = AlertView(
                        title: "카메라 권한을 허용해주세요!",
                        description: "앱설정으로 이동합니다.",
                        alertType: .question
                    )
                    alert.addAction(kind: .success) {
                        guard let settingURL = URL(string: UIApplication.openSettingsURLString) else { return }
                        UIApplication.shared.open(settingURL)
                    }
                    self?.view.addSubview(alert)
                }
            }
        }
    }
    
    private func startAlbum() {
        var configuration = PHPickerConfiguration()
        configuration.filter = .images
        configuration.selectionLimit = 1
        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = self
        
        present(picker, animated: true)
    }
    
    private func validCheck() -> Bool {
        guard let message = info.isAllPropertiesFilled() else { return true }
        Alert.checkAlert(
            viewController: self,
            title: "확인해주세요!",
            message: message
        )
        return false
    }
    
    private func registerIngredientHandling() {
        ingredientRepository.request(saveIngredient: .saveIngredient(ingredient: info))
            .subscribe(onNext: { [weak self] response in
                guard let self else { return }
                guard response.code == "200" else {
                    Alert.erroAlert(viewController: self, errorMessage: response.message)
                    return
                }
                Alert.checkAlert(
                    viewController: self,
                    title: "등록 완료!",
                    message: "재료가 정상적으로 등록되었습니다!"
                )
                self.clearTextField()
            }, onError: { error in
                Alert.erroAlert(
                    viewController: self,
                    errorMessage: error.localizedDescription
                )
            })
            .disposed(by: disposeBag)
    }
    
    private func clearTextField() {
        cameraView.setDefault()
        ingredientInfoView.setDefault()
        info = Ingredient()
            .setSaveMethod(method: "냉장")
            .setCount(count: 1)
            .setExpireDate(date: Date().toString())
    }
    
    @objc private func keyboardUp(notification: NSNotification) {
        guard
            let keyboardFrame = notification
                .userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue,
            let tabBarHeight = self.tabBarController?.tabBar.frame.height,
            ingredientInfoView.memoTextView.isFirstResponder
        else { return }
        
        let keyboardHeight = keyboardFrame.cgRectValue.height
        UIView.animate(withDuration: 0.5) {
            self.scrollVIew.transform = CGAffineTransform(
                translationX: 0, y: -keyboardHeight-12 + tabBarHeight
            )
        }
    }
    
    @objc func keyboardDown() {
        self.scrollVIew.transform = .identity
    }
}

extension RegisterIngredientViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    func imagePickerController(
        _ picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]
    ) {
        picker.dismiss(animated: true)
        
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        else {
            picker.dismiss(animated: true)
            return
        }
        
        cameraView.setImage(image: image)
    }
}

extension RegisterIngredientViewController: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true)
        
        if let provider = results.first?.itemProvider,
           provider.canLoadObject(ofClass: UIImage.self) {
            provider.loadObject(ofClass: UIImage.self) { (image, error) in
                DispatchQueue.main.async { [weak self] in
                    guard let image = image as? UIImage else { return }
                    self?.cameraView.setImage(image: image)
                }
            }
        } else {
            let alert = AlertView(
                title: "오류!",
                description: "이미지를 불러오지 못했습니다.",
                alertType: .check
            )
            view.addSubview(alert)
        }
    }
}
