//
//  FakeNetwork.swift
//  DemoTests
//
//  Created by Lukasz Mroz on 01.09.2017.
//  Copyright © 2017 Łukasz Mróz. All rights reserved.
//

import Moya
import RxSwift
import Result

final class FakeNetwork: NetworkProtocol {

    var responsesClosure: (TargetType) -> Result<[Response], DemoError>
    var objectResponsesClosure: (TargetType) -> Result<[Any], DemoError>
    var arrayResponsesClosure: (TargetType) -> Result<[[Any]], DemoError>

    init(responsesClosure: @escaping (TargetType) -> Result<[Response], DemoError> = { _ in .success([]) },
         objectResponsesClosure: @escaping (TargetType) -> Result<[Any], DemoError> = { _ in .success([]) },
         arrayResponsesClosure: @escaping (TargetType) -> Result<[[Any]], DemoError> = { _ in .success([]) }) {
        self.responsesClosure = responsesClosure
        self.objectResponsesClosure = objectResponsesClosure
        self.arrayResponsesClosure = arrayResponsesClosure
    }

    func request(_ target: TargetType) -> Observable<Response> {
        let result = responsesClosure(target)
        switch result {
        case let .success(responses):
            return Observable.from(responses)
        case let .failure(error):
            return Observable.error(error)
        }
    }

    func request<T>(_ target: TargetType, mapObject: T.Type) -> Observable<T> where T : Decodable {
        let result = objectResponsesClosure(target)
        switch result {
        case let .success(responses):
            guard let responses = responses as? [T] else {
                fatalError("Type mismatch in FakeNetwork. ObjectResponses are not an array of \(String(describing: T.self))")
            }

            return Observable.from(responses)
        case let .failure(error):
            return Observable.error(error)
        }
    }

    func request<T>(_ target: TargetType, mapArray: T.Type) -> Observable<[T]> where T : Decodable {
        let result = arrayResponsesClosure(target)
        switch result {
        case let .success(responses):
            guard let responses = responses as? [[T]] else {
                fatalError("Type mismatch in FakeNetwork. ArrayResponses are not an array of \(String(describing: T.self))")
            }

            return Observable.from(responses)
        case let .failure(error):
            return Observable.error(error)
        }
    }
}
