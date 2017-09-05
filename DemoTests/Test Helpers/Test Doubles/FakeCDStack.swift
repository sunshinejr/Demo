//
//  FakeCDStack.swift
//  DemoTests
//
//  Created by Lukasz Mroz on 03.09.2017.
//  Copyright © 2017 Łukasz Mróz. All rights reserved.
//

import CoreData
import Result
import RxSwift

final class FakeCDStack: CDStackProtocol {

    // TODO: Implement these method when testing CD data controller
    func request<T: NSManagedObject & CDManagedProtocol>(_ request: NSFetchRequest<T>) -> Observable<Result<[T.Model], DemoError>> {
        return .just(.success([]))
    }

    func save<T: NSManagedObject & CDManagedProtocol>(_ objects: [T.Model], type: T.Type) -> Observable<Void> {
        return .just(())
    }
}
