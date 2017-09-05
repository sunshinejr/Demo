//
//  NetworkProtocol.swift
//  Demo
//
//  Created by Lukasz Mroz on 01.09.2017.
//  Copyright © 2017 Łukasz Mróz. All rights reserved.
//

import Moya
import RxSwift

protocol NetworkProtocol {

    func request(_ target: TargetType) -> Observable<Response>
    func request<T: Decodable>(_ target: TargetType, mapObject: T.Type) -> Observable<T>
    func request<T: Decodable>(_ target: TargetType, mapArray: T.Type) -> Observable<[T]>
}
