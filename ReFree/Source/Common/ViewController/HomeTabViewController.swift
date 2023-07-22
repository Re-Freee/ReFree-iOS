//
//  HomeTabViewController.swift
//  ReFree
//
//  Created by 이주훈 on 2023/07/16.
//

import UIKit
import RxSwift

final class HomeTabViewController: UITabBarController {
    private enum TabType: String {
        case home = "홈"
        case refrigerator = "냉장고"
        case addFood = "음식추가"
        case recipe = "레시피"
        
        var image: String {
            switch self {
            case .home: return "house.fill"
            case .refrigerator: return "refrigerator.fill"
            case .addFood: return "fork.knife"
            case .recipe: return "list.clipboard.fill"
            }
        }
    }
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarConfig()
    }
    
    private func tabBarConfig() {
        tabBar.barTintColor = .refreeColor.lightGray
        tabBar.tintColor = .refreeColor.main
        
        let homeViewController = UINavigationController(
            rootViewController: HomeViewController()
        )
        
        // TODO: 냉장고 탭 구현시 변경
        let refrigeratorViewController = UINavigationController(
            rootViewController: HomeViewController()
        )
        
        // TODO: 음식 추가 탭 구현시 변경
        let addFoodViewController = UINavigationController(
            rootViewController: RecipeViewController()
        )
        
        let recipeViewController = UINavigationController(
            rootViewController: RecipeViewController()
        )
        
        homeViewController.tabBarItem = UITabBarItem(
            title: "홈",
            image: UIImage(systemName: "house.fill")?
                .withRenderingMode(.alwaysOriginal)
                .withTintColor(.refreeColor.lightGray),
            selectedImage: UIImage(systemName: "house.fill")
        )
        
        refrigeratorViewController.tabBarItem = UITabBarItem(
            title: "냉장고",
            image: UIImage(systemName: "refrigerator.fill")?
                .withRenderingMode(.alwaysOriginal)
                .withTintColor(.refreeColor.lightGray),
            selectedImage: UIImage(systemName: "refrigerator.fill")
        )
        
        addFoodViewController.tabBarItem = UITabBarItem(
            title: "음식추가",
            image: UIImage(systemName: "fork.knife")?
                .withRenderingMode(.alwaysOriginal)
                .withTintColor(.refreeColor.lightGray),
            selectedImage: UIImage(systemName: "fork.knife")
        )
        
        recipeViewController.tabBarItem = UITabBarItem(
            title: "레시피",
            image: UIImage(systemName: "list.clipboard.fill")?
                .withRenderingMode(.alwaysOriginal)
                .withTintColor(.refreeColor.lightGray),
            selectedImage: UIImage(systemName: "list.clipboard.fill")
        )
        
        let tabItems = [
            homeViewController,
            refrigeratorViewController,
            addFoodViewController,
            recipeViewController
        ]
        
        tabItems.forEach {
            $0.isNavigationBarHidden = true
        }
        
        setViewControllers(tabItems, animated: true)
        
        // 네트워킹 테스트..
//        test().subscribe {
//            print("성공 \($0.test)")
//        } onFailure: {
//            print("실패\($0.localizedDescription)")
//        }
//        .disposed(by: disposeBag)

        // 네트워킹 테스트..2
//        Network.requestCompletion(type: TestStruct.self, target: NetTest.post(TestStruct(test: "아아아"))) { respose in
//            switch respose.result {
//            case .success(let a):
//                print(a.test)
//            case .failure(let error):
//                print(error)
//            }
//        }
    }
    
    func test() -> Single<TestStruct> {
        return Network.requestJSON(target: NetTest.post(TestStruct(test: "아아아")))
    }
}
