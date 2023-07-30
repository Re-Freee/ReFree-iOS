//
//  RegisterIngredientViewController.swift
//  ReFree
//
//  Created by 이주훈 on 2023/07/29.
//

import UIKit
import PhotosUI
import SnapKit
import Then
import RxSwift
import RxGesture

final class RegisterIngredientViewController: UIViewController {
    private let scrollVIew = UIScrollView().then {
        $0.showsHorizontalScrollIndicator = false
    }
    private let scrollContentView = UIView()
    private let titleLabel = UILabel().then {
        $0.textColor = .refreeColor.main
        $0.font = .pretendard.extraBold30
        $0.text = "음식 추가"
    }
    private let cameraView = CameraView()
    private let ingredientInfoView = IngredientInfoView()
    
    private var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.gradientBackground(type: .mainAxial)
        config()
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
            $0.width.equalTo(Constant.screenSize.width)
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
        scrollVIew.rx.touchDownGesture()
            .when(.began)
            .bind { [weak self] _ in
                self?.view.endEditing(true)
            }
            .disposed(by: disposeBag)
        
        ingredientInfoView.saveButton.rx.tapGesture()
            .when(.recognized)
            .bind { [weak self] _ in
                let alert = AlertView(
                    title: "잠깐!",
                    description: "그대로 저장하시겠습니까?",
                    alertType: .question
                )
                alert.addAction(kind: .success) {
                    print("저장!")
                }
                alert.addAction(kind: .cancel) {
                    print("취소!")
                }
                self?.view.addSubview(alert)
            }.disposed(by: disposeBag)
        
        cameraView.rx.tapGesture()
            .when(.recognized)
            .bind { [weak self] _ in
                self?.bindCamera()
            }.disposed(by: disposeBag)
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
        if cameraView.currentImage != UIImage(named: "Camera1") {
            alert.addAction(deleteImage)
        }
        alert.addAction(cancel)
        present(alert, animated: true)
    }
    
    private func startCamera() {
        DispatchQueue.main.async { [weak self] in
            let pickerController = UIImagePickerController()
            pickerController.sourceType = .camera
            pickerController.allowsEditing = false
            pickerController.mediaTypes = ["public.image"]
            //           오버레이 커스텀
            //            pickerController.cameraOverlayView = nil
            //            self?.overlay.frame = (pickerController.cameraOverlayView?.frame)!
            //            pickerController.cameraOverlayView = self?.overlay
            pickerController.cameraFlashMode = .off
            pickerController.delegate = self
            self?.present(pickerController, animated: true)
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
