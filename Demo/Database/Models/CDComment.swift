//
//  CDComment.swift
//  Demo
//
//  Created by Lukasz Mroz on 05.09.2017.
//  Copyright © 2017 Łukasz Mróz. All rights reserved.
//

import CoreData

final class CDComment: NSManagedObject, CDManagedProtocol, CommentConvertible {

    @NSManaged private(set) var id: Int
    @NSManaged private(set) var postId: Int
    @NSManaged private(set) var name: String
    @NSManaged private(set) var email: String
    @NSManaged private(set) var body: String

    var asModel: Comment { return asComment }

    func update(with comment: Comment) {
        id = comment.id
        postId = comment.postId
        name = comment.name
        email = comment.email
        body = comment.body
    }
}
