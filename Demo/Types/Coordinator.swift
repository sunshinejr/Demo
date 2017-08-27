//
//  Coordinator.swift
//  Demo
//
//  Created by Lukasz Mroz on 27.08.2017.
//  Copyright © 2017 Łukasz Mróz. All rights reserved.
//

import UIKit

class Coordinator {

    weak var navigationController: UINavigationController?

    private var childCoordinators = [Coordinator]()

    init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
}
