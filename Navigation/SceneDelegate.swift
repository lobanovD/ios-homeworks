//
//  SceneDelegate.swift
//  Navigation
//
//  Created by Dmitrii Lobanov on 23.08.2021.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let scene = (scene as? UIWindowScene) else { return }
        
        let window = UIWindow(windowScene: scene)


        
        // MARK: VC
        let feedVC = FeedViewController()
        let logInVC = LoginViewController()
        let profileVC = ProfileViewController()

        let factory = MyLoginFactory()
        let inspector = factory.createLoginInspector()
        logInVC.delegate = inspector
        
        
        // MARK: Navigation VC
//        let profileNavigationVC = UINavigationController(rootViewController: logInVC)
        var currentVC: UIViewController {
            if UserDefaults.standard.bool(forKey: "isLogin") {
                return profileVC
            } else {
                return logInVC
            }
        }
        
        let profileNavigationVC = UINavigationController(rootViewController: currentVC)
        
        let feedNavigationVC = UINavigationController(rootViewController: feedVC)
        
        
        // MARK: Иконки и текст TabBarItems для NavigationVC
        
        let loginVCTabbarTitle = "login_vc_tabbar_title".localized(file: "Localizable_TabBar")
        let feedVCTabbarTitle = "feed_vc_tabbar_title".localized(file: "Localizable_TabBar")
        
        logInVC.tabBarItem = UITabBarItem(title: loginVCTabbarTitle, image: UIImage(systemName: "person.crop.circle"), tag: 0)
        profileVC.tabBarItem = UITabBarItem(title: loginVCTabbarTitle, image: UIImage(systemName: "person.crop.circle"), tag: 0)
        feedNavigationVC.tabBarItem = UITabBarItem(title: feedVCTabbarTitle, image: UIImage(systemName: "note.text"), tag: 0)
        
        UITabBar.appearance().tintColor = ColorPallete.tabBarItem
        UINavigationBar.appearance().backgroundColor = ColorPallete.tabBarBackground
        
        // MARK: TabBar
        let tabBar = UITabBarController()
        
        // помещаем в TabBar VC
        tabBar.viewControllers = [profileNavigationVC, feedNavigationVC]
        
        window.safeAreaLayoutGuide.owningView?.backgroundColor = ColorPallete.backgroundColor
        
        // указываем с чего загружаться
        window.rootViewController = tabBar
//        let profileVC = ProfileViewController()
//        window.rootViewController = profileVC

        // генерируем массив фотографий
            createPhotosArray()


        window.makeKeyAndVisible()
        self.window = window
        
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
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }
    
    
}
