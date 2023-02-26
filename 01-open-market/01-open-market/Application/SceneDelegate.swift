//
//  SceneDelegate.swift
//  01-open-market
//
//  Copyright (c) 2023 Jeremy All rights reserved.
    

import UIKit

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let rootViewController = ViewController()
        let rootNavigationViewController = UINavigationController(
            rootViewController: rootViewController
        )
        
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = rootNavigationViewController
        window?.makeKeyAndVisible()
    }
}

