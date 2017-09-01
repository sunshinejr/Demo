//
//  AppCoordinator.swift
//  Demo
//
//  Created by Lukasz Mroz on 27.08.2017.
//  Copyright © 2017 Łukasz Mróz. All rights reserved.
//

final class AppCoordinator: Coordinator {

    private let stack = CDStack()
    private let network = Network()

    func start(completionBlock: @escaping () -> Void) {
        stack.load { [weak self] success in
            self?.startPostsCoordinator()
            completionBlock()
        }
    }

    private func startPostsCoordinator() {
        let dataController = PostsDataController(network: network, database: stack)
        let postsCoordinator = PostsCoordinator(navigationController: navigationController, dataController: dataController)

        childCoordinators.append(postsCoordinator)

        postsCoordinator.start()
    }
}
