//
//  PostsCoordinator.swift
//  Demo
//
//  Created by Lukasz Mroz on 01.09.2017.
//  Copyright © 2017 Łukasz Mróz. All rights reserved.
//

import UIKit

final class PostsCoordinator: Coordinator {

    let dataController: PostsDataControllerProtocol

    init(navigationController: UINavigationController?, dataController: PostsDataControllerProtocol) {
        self.dataController = dataController
        super.init(navigationController: navigationController)
    }

    func start() {
        let viewModel = PostsViewModel(dataController: dataController, delegate: self)
        let controller = PostsViewController(viewModel: viewModel)
        self.navigationController?.viewControllers = [controller]
    }
}

extension PostsCoordinator: PostsViewControllerDelegate {

    func didSelectPost(_ post: Post) {
        let controller = PostDetailsViewController()
        navigationController?.pushViewController(controller, animated: true)
    }
}
