//
//  CDUser.swift
//  Demo
//
//  Created by Lukasz Mroz on 27.08.2017.
//  Copyright © 2017 Łukasz Mróz. All rights reserved.
//

import CoreData

final class CDUser: NSManagedObject, CDManaged, UserConvertible {

    @NSManaged fileprivate(set) var id: Int
    @NSManaged fileprivate(set) var name: String
    @NSManaged fileprivate(set) var username: String
    @NSManaged fileprivate(set) var email: String

    func update(with user: User) {
        id = user.id
        name = user.name
        username = user.username
        email = user.email
    }
}
