//
//  UIAlertController.swift
//  Demo
//
//  Created by Lukasz Mroz on 27.08.2017.
//  Copyright © 2017 Łukasz Mróz. All rights reserved.
//

import UIKit

extension UIAlertController {

    convenience init(error: DemoError) {
        self.init(title: error.title, message: error.description, preferredStyle: .alert)

        let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
        addAction(action)
    }
}
