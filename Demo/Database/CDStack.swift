//
//  CDStack.swift
//  Demo
//
//  Created by Lukasz Mroz on 27.08.2017.
//  Copyright © 2017 Łukasz Mróz. All rights reserved.
//

import CoreData

final class CDStack {

    lazy var mainContext = container.viewContext

    private let container: NSPersistentContainer

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
        container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
    }
}
