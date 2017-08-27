//
//  NSManagedObjectContext+Save.swift
//  Demo
//
//  Created by Lukasz Mroz on 27.08.2017.
//  Copyright © 2017 Łukasz Mróz. All rights reserved.
//

import CoreData
import RxSwift

extension NSManagedObjectContext {

    func saveOrRollback(actionBlock: (() -> Void)? = nil, completionBlock: (() -> Void)? = nil) {
        perform {
            actionBlock?()
            do { try self.save() }
            catch { self.rollback() }
            completionBlock?()
        }
    }
}

extension NSManagedObjectContext {

    func saveOrRollback(actionBlock: (() -> Void)? = nil) -> Observable<Void> {
        return Observable.create { [weak self] observer in
            let completionBlock: () -> Void = {
                observer.onNext(())
                observer.onCompleted()
            }
            self?.saveOrRollback(actionBlock: actionBlock, completionBlock: completionBlock)

            return Disposables.create()
        }
    }
}
