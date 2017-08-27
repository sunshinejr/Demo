//
//  AppDelegate.swift
//  Demo
//
//  Created by Lukasz Mroz on 25.08.2017.
//  Copyright © 2017 Łukasz Mróz. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var coordinator: AppCoordinator!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey : Any]? = nil) -> Bool {
        let window = UIWindow()
        let navigationController = UINavigationController()
        let coordinator = AppCoordinator(navigationController: navigationController)

        window.rootViewController = navigationController
        coordinator.start {
            window.makeKeyAndVisible()
        }

        self.window = window

        return true
    }
}
