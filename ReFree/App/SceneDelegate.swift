//
//  SceneDelegate.swift
//  ReFree
//
//  Created by 이주훈 on 2023/07/01.
//

import UIKit
import SnapKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    var globalNavigation: UINavigationController?
    
    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let window = UIWindow(windowScene: windowScene)
        let navigation = UINavigationController(rootViewController: AppInitViewController())
        globalNavigation = navigation
        
        if let _ = try? KeyChain.shared.searchToken(kind: .accessToken) {
            navigation.pushViewController(HomeTabViewController(), animated: false)
        }
        window.rootViewController = navigation
        window.makeKeyAndVisible()
        
        self.window = window
        if let height = window.windowScene?.screen.bounds {
            Constant.screenSize = height
        }
        appearance()
    }
    
    func sceneDidDisconnect(_ scene: UIScene) {}
    
    func sceneDidBecomeActive(_ scene: UIScene) {}
    
    func sceneWillResignActive(_ scene: UIScene) {}
    
    func sceneWillEnterForeground(_ scene: UIScene) {
        guard let windowFrame = window?.frame else { return }
        let launchScreenView = LaunchScreenView()
        launchScreenView.frame = windowFrame
        launchScreenView.layer.zPosition = 1
        window?.addSubview(launchScreenView)
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {}
    
    func popToRootViewController() {
        guard let globalNavigation else { return }
        globalNavigation.popToRootViewController(animated: true)
    }
    
    func appearance() {
        UINavigationBar.appearance().tintColor = .refreeColor.main
        self.window?.overrideUserInterfaceStyle = .light
    }
}

