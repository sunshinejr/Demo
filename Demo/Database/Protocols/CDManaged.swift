//
//  CDManaged.swift
//  Demo
//
//  Created by Lukasz Mroz on 27.08.2017.
//  Copyright © 2017 Łukasz Mróz. All rights reserved.
//

import CoreData

protocol CDManaged {
    static var entityName: String { get }
}

extension CDManaged where Self: NSManagedObject {

    static var entityName: String {
        return entity().name!
    }

    static func insert(into context: NSManagedObjectContext) -> Self {
        return NSEntityDescription.insertNewObject(forEntityName: CDPost.entityName, into: context) as! Self
    }
}

