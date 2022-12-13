//
//  SceneDelegate.swift
//  SocialMeg
//
//  Created by Raul Menezes on 06/11/2022.
//

import UIKit

private(set) var appContainer: AppContainer!

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    private var appCoordinator: Coordinating!
    
    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        appContainer = AppContainer.live()
        
        appCoordinator = AppCoordinator(
            window: window!,
            factory: AppSceneFactory(appContainer: appContainer),
            appService: AppStartupService()
        )
        appCoordinator.start()
    }
}

