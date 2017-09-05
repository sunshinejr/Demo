//
//  Post.swift
//  Demo
//
//  Created by Lukasz Mroz on 25.08.2017.
//  Copyright © 2017 Łukasz Mróz. All rights reserved.
//

protocol PostConvertible {

    var id: Int { get }
    var userId: Int { get }
    var title: String { get }
    var body: String { get }
}

extension PostConvertible {
    
    var asPost: Post {
        return Post(id: id, userId: userId, title: title, body: body)
    }
}

struct Post: PostConvertible, Equatable {

    let id: Int
    let userId: Int
    let title: String
    let body: String

    static func ==(lhs: Post, rhs: Post) -> Bool {
        return lhs.id == rhs.id
    }
}
