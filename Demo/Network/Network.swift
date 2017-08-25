//
//  Network.swift
//  Demo
//
//  Created by Lukasz Mroz on 25.08.2017.
//  Copyright © 2017 Łukasz Mróz. All rights reserved.
//

import Moya
import RxSwift

final class Network<Target: TargetType> {

    private let provider: RxMoyaProvider<Target>

    init(stubClosure: @escaping RxMoyaProvider<Target>.StubClosure = RxMoyaProvider.neverStub) {
        provider = RxMoyaProvider<Target>(stubClosure: stubClosure)
    }

    func request(_ target: Target) -> Observable<Response> {
        return provider.request(target)
    }
}
