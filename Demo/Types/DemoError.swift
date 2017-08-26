//
//  DemoError.swift
//  Demo
//
//  Created by Lukasz Mroz on 26.08.2017.
//  Copyright © 2017 Łukasz Mróz. All rights reserved.
//

import Foundation

enum DemoError: Error {
    case networkError
    case unknown

    init(error: Error) {
        switch error {
        case let error as DemoError:
            self = error
        case is URLError: // a bit too simplified, but probably enough for now
            self = .networkError
        default:
            self = .unknown
        }
    }
}
