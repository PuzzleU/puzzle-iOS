//
//  SceneDelegate.swift
//  Puzzle
//
//  Created by 신지원 on 2023/10/12.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        self.window = UIWindow(windowScene: windowScene)
        window?.overrideUserInterfaceStyle = .light
        let navigationController = UINavigationController(rootViewController: ViewController())
        navigationController.isNavigationBarHidden = true
        self.window?.rootViewController = navigationController
        self.window?.makeKeyAndVisible()
    }


}

