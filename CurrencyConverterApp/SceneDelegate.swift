//
//  SceneDelegate.swift
//  RxClimaAppSKB
//
//  Created by Evgeniy Uskov on 04.02.2021.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: scene)
        let viewController = ConversionBuilder().build()
        let navigationController = generateViewController(rootViewController: viewController, title: Constants.Stuff.conversionHeaderText)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
    }

    func sceneWillResignActive(_ scene: UIScene) {
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }

}

extension SceneDelegate {
    private func generateViewController(rootViewController: UIViewController, title: String) -> UIViewController {
        rootViewController.navigationItem.title = title
        
        let navigationController = UINavigationController(rootViewController: rootViewController)
        
        UIHelper.setupNavigationControllerUI(for: navigationController)
        let navBarAppearance = UINavigationBar.getAppearance()
        
        navigationController.navigationBar.standardAppearance = navBarAppearance
        navigationController.navigationBar.compactAppearance = navBarAppearance
        navigationController.navigationBar.scrollEdgeAppearance = navBarAppearance
        
        return navigationController
    }
}

