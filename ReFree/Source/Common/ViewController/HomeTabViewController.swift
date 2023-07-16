//
//  HomeTabViewController.swift
//  ReFree
//
//  Created by 이주훈 on 2023/07/16.
//

import UIKit

final class HomeTabViewController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarConfig()
    }
    
    private func tabBarConfig() {
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
                .withTintColor(.refreeColor.text1),
            selectedImage: UIImage(systemName: "house.fill")
        )
        
        refrigeratorViewController.tabBarItem = UITabBarItem(
            title: "냉장고",
            image: UIImage(systemName: "refrigerator.fill")?
                .withRenderingMode(.alwaysOriginal)
                .withTintColor(.refreeColor.text1),
            selectedImage: UIImage(systemName: "refrigerator.fill")
        )
        
        addFoodViewController.tabBarItem = UITabBarItem(
            title: "음식추가",
            image: UIImage(systemName: "fork.knife")?
                .withRenderingMode(.alwaysOriginal)
                .withTintColor(.refreeColor.text1),
            selectedImage: UIImage(systemName: "fork.knife")
        )
        
        recipeViewController.tabBarItem = UITabBarItem(
            title: "레시피",
            image: UIImage(systemName: "list.clipboard.fill")?
                .withRenderingMode(.alwaysOriginal)
                .withTintColor(.refreeColor.text1),
            selectedImage: UIImage(systemName: "list.clipboard.fill")
        )
        
        setViewControllers(
            [
                homeViewController,
                refrigeratorViewController,
                addFoodViewController,
                recipeViewController
            ],
            animated: true
        )
    }
}
