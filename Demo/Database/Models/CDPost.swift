//
//  CDPost.swift
//  Demo
//
//  Created by Lukasz Mroz on 27.08.2017.
//  Copyright © 2017 Łukasz Mróz. All rights reserved.
//

import CoreData

final class CDPost: NSManagedObject, CDManaged, PostConvertible {

    @NSManaged private(set) var id: Int
    @NSManaged private(set) var userId: Int
    @NSManaged private(set) var title: String
    @NSManaged private(set) var body: String

    func update(with post: Post) {
        id = post.id
        userId = post.userId
        title = post.title
        body = post.body
    }
}
