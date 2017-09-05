//
//  Comment.swift
//  Demo
//
//  Created by Lukasz Mroz on 05.09.2017.
//  Copyright © 2017 Łukasz Mróz. All rights reserved.
//

protocol CommentConvertible {

    var id: Int { get }
    var postId: Int { get }
    var name: String { get }
    var email: String { get }
    var body: String { get }
}

extension CommentConvertible {

    var asComment: Comment {
        return Comment(id: id, postId: postId, name: name, email: email, body: body)
    }
}

struct Comment: CommentConvertible, Equatable {

    let id: Int
    let postId: Int
    let name: String
    let email: String
    let body: String

    static func ==(lhs: Comment, rhs: Comment) -> Bool {
        return lhs.id == rhs.id
    }
}
