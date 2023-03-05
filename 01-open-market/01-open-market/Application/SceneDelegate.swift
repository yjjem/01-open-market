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
        
        let service = MarketService()
        let repository = ProductListRepository(networkService: service)
        let useCase = ProductListUseCase(repository: repository)
        let viewModel = ProductListViewModel(useCase: useCase)
        let rootViewController = ProductListViewController()
        rootViewController.viewModel = viewModel
        let rootNavigationViewController = UINavigationController(
            rootViewController: rootViewController
        )
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = rootNavigationViewController
        window?.backgroundColor = .systemBackground
        window?.makeKeyAndVisible()
    }
}

