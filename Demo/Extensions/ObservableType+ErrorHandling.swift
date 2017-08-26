//
//  ObservableType+ErrorHandling.swift
//  Demo
//
//  Created by Lukasz Mroz on 26.08.2017.
//  Copyright © 2017 Łukasz Mróz. All rights reserved.
//

import RxSwift

extension ObservableType {
    func catchDemoError(_ handler: @escaping (DemoError) -> Observable<Self.E>) -> Observable<Self.E> {
        return catchError { error in
            return handler(DemoError(error: error))
        }
    }
}
