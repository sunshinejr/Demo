//
//  CDStackProtocol.swift
//  Demo
//
//  Created by Lukasz Mroz on 02.09.2017.
//  Copyright © 2017 Łukasz Mróz. All rights reserved.
//

import CoreData
import Result
import RxSwift

protocol CDStackProtocol {
    func request<T: NSManagedObject & CDManagedProtocol>(_ request: NSFetchRequest<T>) -> Observable<Result<[T.Model], DemoError>>
    func save<T: NSManagedObject & CDManagedProtocol>(_ objects: [T.Model], type: T.Type) -> Observable<Void>
}
