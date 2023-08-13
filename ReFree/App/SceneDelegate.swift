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
        let navigation = UINavigationController(rootViewController: AuthenticationCodeViewController())
        globalNavigation = navigation
//        if let _ = try? KeyChain.shared.searchToken(kind: .accessToken) {
//            navigation.pushViewController(HomeTabViewController(), animated: false)
//        }
        window.rootViewController = navigation
        window.makeKeyAndVisible()
        
        self.window = window
        if let height = window.windowScene?.screen.bounds {
            Constant.screenSize = height
        }
        
        UINavigationBar.appearance().tintColor = .refreeColor.main
    }
    
    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }
    
    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }
    
    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }
    
    func sceneWillEnterForeground(_ scene: UIScene) {
        guard
            let windowScene = (scene as? UIWindowScene),
            let navigation = windowScene.windows.first?.rootViewController as? UINavigationController,
            let currentView = navigation.topViewController?.view
        else { return }
        
        let launchScreenView = LaunchScreenView()
        currentView.addSubview(launchScreenView)
        launchScreenView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }
    
    func popToRootViewController() {
        guard let globalNavigation else { return }
        globalNavigation.popToRootViewController(animated: true)
        guard let initViewController = globalNavigation.topViewController else { return }
        Alert.checkAlert(
            viewController: initViewController,
            title: "알림",
            message: "로그인이 만료되었습니다.\n다시 로그인해 주세요."
        )
    }
}

