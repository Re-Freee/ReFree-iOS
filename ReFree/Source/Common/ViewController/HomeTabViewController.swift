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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    
    private func tabBarConfig() {
        tabBar.barTintColor = .refreeColor.lightGray
        tabBar.tintColor = .refreeColor.main
        
        let homeViewController = UINavigationController(
            rootViewController: HomeViewController()
        )
        
        let refrigeratorViewController = UINavigationController(
            rootViewController: RefrigeratorViewController()
        )
        
        let addFoodViewController = UINavigationController(
            rootViewController: RegisterIngredientViewController(type: .register)
        )
        
        let recipeViewController = UINavigationController(
            rootViewController: RecipeViewController()
        )
        
        let settingViewController = UINavigationController(
            rootViewController: SettingViewController()
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
        
        settingViewController.tabBarItem = UITabBarItem(
            title: "설정",
            image: UIImage(systemName: "gearshape.fill")?
                .withRenderingMode(.alwaysOriginal)
                .withTintColor(.refreeColor.lightGray),
            selectedImage: UIImage(systemName: "gearshape.fill")
        )
        
        let tabItems = [
            homeViewController,
            refrigeratorViewController,
            addFoodViewController,
            recipeViewController,
            settingViewController
        ]
        
        tabItems.forEach {
            $0.isNavigationBarHidden = true
        }
        
        setViewControllers(tabItems, animated: true)
    }
}
