//
//  NetworkComment.swift
//  Demo
//
//  Created by Lukasz Mroz on 05.09.2017.
//  Copyright © 2017 Łukasz Mróz. All rights reserved.
//

struct NetworkComment: CommentConvertible, Codable, Equatable {

    let id: Int
    let postId: Int
    let name: String
    let email: String
    let body: String

    static func ==(lhs: NetworkComment, rhs: NetworkComment) -> Bool {
        return lhs.id == rhs.id && lhs.postId == rhs.postId && lhs.name == rhs.name && lhs.email == rhs.email && lhs.body == rhs.body
    }
}

