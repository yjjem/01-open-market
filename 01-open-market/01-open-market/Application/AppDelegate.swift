//
//  AppDelegate.swift
//  01-open-market
//
//  Copyright (c) 2023 Jeremy All rights reserved.


import UIKit

@main
final class AppDelegate: UIResponder, UIApplicationDelegate {
    private enum ConfigurationName {
        static let defaultConfiguration = "Default Configuration"
    }
    
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        return true
    }
    
    func application(
        _ application: UIApplication,
        configurationForConnecting connectingSceneSession: UISceneSession,
        options: UIScene.ConnectionOptions
    ) -> UISceneConfiguration {
        return UISceneConfiguration(
            name: ConfigurationName.defaultConfiguration,
            sessionRole: connectingSceneSession.role
        )
    }
    
    func application(
        _ application: UIApplication,
        didDiscardSceneSessions sceneSessions: Set<UISceneSession>
    ) { }
}

