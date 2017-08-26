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

    func get<T>(data: Observable<Result<T, DemoError>>,
                onErrorReturn: ((DemoError) -> Observable<Result<T, DemoError>>)? = nil,
                onSuccessReturn: ((T) -> Observable<Result<T, DemoError>>)? = nil) -> Observable<Result<T, DemoError>> {
        return data.flatMapLatest { result -> Observable<Result<T, DemoError>> in
            switch result {
            case let .success(element):
                return onSuccessReturn?(element) ?? Observable.just(result)
            case let .failure(error):
                return onErrorReturn?(error) ?? Observable.just(result)
            }
        }
    }
}
