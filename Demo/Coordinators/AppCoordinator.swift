//
//  AppCoordinator.swift
//  Demo
//
//  Created by Lukasz Mroz on 27.08.2017.
//  Copyright © 2017 Łukasz Mróz. All rights reserved.
//

final class AppCoordinator: Coordinator {

    private let stack = CDStack()
    private let network = Network<PostsService>()

    func start(completionBlock: @escaping () -> Void) {
        stack.load { [weak self] success in
            guard let `self` = self else { return completionBlock() }

            let controller = PostsViewController(controller: PostsDataController(network: self.network, database: self.stack))
            self.navigationController?.viewControllers = [controller]
            completionBlock()
        }
    }
}
