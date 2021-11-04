//
//  SceneDelegate.swift
//  Currency converter
//
//  Created by Alex Mosunov on 31.08.2021.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        window?.rootViewController = createTabBar()
        window?.makeKeyAndVisible()
        
    }
    
    func createConverterVC() -> UIViewController {
        let converterVC = ConverterVC()
        converterVC.title = "Converter"
        converterVC.tabBarItem = UITabBarItem(title: "Converter", image: UIImage(systemName: "arrow.left.and.right.circle"), tag: 1)
        return converterVC
    }
    
    func createCurrencyVC() -> UIViewController {
        let currencyVC = CurrencyInfoVC()
        currencyVC.title = "Currencies"
        currencyVC.tabBarItem = UITabBarItem(title: "Currencies", image: UIImage(systemName: "dollarsign.circle"), tag: 1)
        return currencyVC
    }
    
    func createCurrencyNC() -> UINavigationController {
        let currencyVC = CurrencyInfoVC()
        currencyVC.title = "Currencies"
        currencyVC.tabBarItem = UITabBarItem(title: "Currencies", image: UIImage(systemName: "dollarsign.circle"), tag: 2)
        
        return UINavigationController(rootViewController: currencyVC)
    }
    
    func createPersonalBudgetNC() -> UINavigationController {
        let budgetVC = PersonalBudgetVC()
        budgetVC.title = "Personal Budget"
        budgetVC.tabBarItem = UITabBarItem(title: "Budget", image: UIImage(systemName: ""), tag: 0)
        
        return UINavigationController(rootViewController: budgetVC)
    }
    
    func createTabBar() -> UITabBarController {
        let tabBar = UITabBarController()
        UITabBar.appearance().tintColor = .systemPink
        tabBar.viewControllers = [createPersonalBudgetNC(), createConverterVC(), createCurrencyNC()]
        
        return tabBar
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

