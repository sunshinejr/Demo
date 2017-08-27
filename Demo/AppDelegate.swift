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
    var stack: CDStack!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey : Any]? = nil) -> Bool {
        let navigationController = UINavigationController()
        let stack = CDStack()
        let window = UIWindow()
        stack.load { [unowned stack] success in
            let controller = PostsViewController(controller: PostsDataController(network: Network<PostsService>(), database: stack))
            navigationController.viewControllers = [controller]
            window.rootViewController = navigationController
            window.makeKeyAndVisible()
        }
        self.stack = stack
        self.window = window

        return true
    }
}
