//
//  UIViewController+Reactive.swift
//  Demo
//
//  Created by Lukasz Mroz on 27.08.2017.
//  Copyright © 2017 Łukasz Mróz. All rights reserved.
//

import RxCocoa
import RxSwift
import UIKit

extension Reactive where Base: UIViewController {

    var presentError: AnyObserver<DemoError> {
        return UIBindingObserver(UIElement: base) { controller, error in
            let alertController = UIAlertController(error: error)
            controller.present(alertController, animated: true, completion: nil)
        }.asObserver()
    }
}
