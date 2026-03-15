//
//  SceneDelegate.swift
//  LegasyUsersApp
//
//  Created by Dmytro Melnyk on 12.03.2026.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Ensure we have a window scene
        guard let windowScene = (scene as? UIWindowScene) else { return }

        // Create the window using the windowScene
        let window = UIWindow(windowScene: windowScene)

        let rootVC = UsersViewController(userService: DefaultUserService(networkClient: NetworkClient()))
        let navigationController = UINavigationController(rootViewController: rootVC)

        window.rootViewController = navigationController
        self.window = window
        window.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
    }
}
