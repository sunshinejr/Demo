//
//  CompositeDataControllerProtocol.swift
//  Demo
//
//  Created by Lukasz Mroz on 26.08.2017.
//  Copyright © 2017 Łukasz Mróz. All rights reserved.
//

import Result
import RxSwift

protocol CompositeDataControllerProtocol {
    associatedtype NetworkDataController
    associatedtype DatabaseDataController

    var networkDataController: NetworkDataController { get }
    var databaseDataController: DatabaseDataController { get }

    init(networkDataController: NetworkDataController, databaseDataController: DatabaseDataController)
}

extension CompositeDataControllerProtocol {

    func get<T, U>(data: Observable<Result<U, DemoError>>,
                onErrorReturn: @escaping (DemoError) -> Observable<Result<T, DemoError>>,
                onSuccessReturn: @escaping (U) -> Observable<Result<T, DemoError>>) -> Observable<Result<T, DemoError>> {
        return data.flatMapLatest { result -> Observable<Result<T, DemoError>> in
            switch result {
            case let .success(element):
                return onSuccessReturn(element)
            case let .failure(error):
                return onErrorReturn(error)
            }
        }
    }
}
