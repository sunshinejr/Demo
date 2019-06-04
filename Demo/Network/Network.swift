//
//  Network.swift
//  Demo
//
//  Created by Lukasz Mroz on 25.08.2017.
//  Copyright © 2017 Łukasz Mróz. All rights reserved.
//

import Moya
import RxSwift

final class Network: NetworkProtocol {

    private let provider: MoyaProvider<MultiTarget>

    init(stubClosure: @escaping MoyaProvider<MultiTarget>.StubClosure = MoyaProvider.neverStub) {
        provider = MoyaProvider<MultiTarget>(stubClosure: stubClosure)
    }

    func request(_ target: TargetType) -> Observable<Response> {
        return provider.rx.request(MultiTarget(target)).asObservable()
    }

    func request<T: Decodable>(_ target: TargetType, mapObject: T.Type) -> Observable<T> {
        return request(target)
            .map { response -> T in
                let decoder = JSONDecoder()
                return try decoder.decode(T.self, from: response.data)
            }
    }

    func request<T: Decodable>(_ target: TargetType, mapArray: T.Type) -> Observable<[T]> {
        return request(target)
            .map { response -> [T] in
                let decoder = JSONDecoder()
                return try decoder.decode([T].self, from: response.data)
            }
    }
}
