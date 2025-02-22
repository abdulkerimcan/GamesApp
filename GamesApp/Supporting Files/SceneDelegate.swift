//
//  SceneDelegate.swift
//  GamesApp
//
//  Created by Abdulkerim Can on 22.02.2025.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        let view = HomeBuilder.build()
        let nav = UINavigationController(rootViewController: view)
        window?.windowScene = windowScene
        window?.rootViewController = nav
        window?.makeKeyAndVisible()
    }
}

