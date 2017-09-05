//
//  CDStack.swift
//  Demo
//
//  Created by Lukasz Mroz on 27.08.2017.
//  Copyright © 2017 Łukasz Mróz. All rights reserved.
//

import CoreData
import Result
import RxSwift

final class CDStack: CDStackProtocol {

    private let container: NSPersistentContainer
    private lazy var mainContext = container.viewContext
    private lazy var syncContext = container.newBackgroundContext()

    init() {
        container = NSPersistentContainer(name: "Model")
    }

    func load(completionBlock: @escaping (Bool) -> ()) {
        container.loadPersistentStores { [weak self] _, error in
            let success = error != nil
            completionBlock(success)
            self?.setupContexts()
        }
    }

    private func setupContexts() {
        [mainContext, syncContext].forEach {
            $0.automaticallyMergesChangesFromParent = true
            $0.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        }
    }

    func request<T: NSManagedObject & CDManagedProtocol>(_ request: NSFetchRequest<T>) -> Observable<Result<[T.Model], DemoError>> {
        let context = mainContext
        do {
            let cdObjects = try context.fetch(request)
            let objects = cdObjects.map { $0.asModel }
            return .just(.success(objects))
        } catch let error {
            let demoError = DemoError(error: error)
            return .just(.failure(demoError))
        }
    }

    func count<T: NSManagedObject & CDManagedProtocol>(_ request: NSFetchRequest<T>) -> Observable<Result<Int, DemoError>> {
        let context = mainContext
        do {
            let count = try context.count(for: request)
            return .just(.success(count))
        } catch let error {
            let demoError = DemoError(error: error)
            return .just(.failure(demoError))
        }
    }

    func save<T: NSManagedObject & CDManagedProtocol>(_ objects: [T.Model], type: T.Type) -> Observable<Void> {
        let context = syncContext
        let block: () -> Void = {
            objects.forEach { object in
                let cdObject = T.insert(into: context)
                cdObject.update(with: object)
            }
        }
        return context.saveOrRollback(actionBlock: block)
    }
}
