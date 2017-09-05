//
//  DemoError.swift
//  Demo
//
//  Created by Lukasz Mroz on 26.08.2017.
//  Copyright © 2017 Łukasz Mróz. All rights reserved.
//

import Foundation

enum DemoError: Error, Equatable {
    case networkError
    case unknown

    init(error: Error) {
        switch error {
        case let error as DemoError:
            self = error
        case is URLError: // TODO: a bit too simplified error handling here, but probably enough for now
            self = .networkError
        default:
            self = .unknown
        }
    }

    var title: String {
        return "Error"
    }

    var description: String {
        return localizable(from: .errorTryAgainLater)
    }

    static func ==(lhs: DemoError, rhs: DemoError) -> Bool {
        switch (lhs, rhs) {
        case (.networkError, .networkError): return true
        case (.unknown, .unknown): return true
        default: return false
        }
    }
}

