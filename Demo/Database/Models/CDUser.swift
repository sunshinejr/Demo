//
//  CDUser.swift
//  Demo
//
//  Created by Lukasz Mroz on 27.08.2017.
//  Copyright © 2017 Łukasz Mróz. All rights reserved.
//

import CoreData

final class CDUser: NSManagedObject, CDManagedProtocol, UserConvertible {

    @NSManaged private(set) var id: Int
    @NSManaged private(set) var name: String
    @NSManaged private(set) var username: String
    @NSManaged private(set) var email: String

    var asModel: User { return asUser }

    func update(with user: User) {
        id = user.id
        name = user.name
        username = user.username
        email = user.email
    }
}
