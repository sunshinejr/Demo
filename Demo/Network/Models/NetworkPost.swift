//
//  NetworkPost.swift
//  Demo
//
//  Created by Lukasz Mroz on 25.08.2017.
//  Copyright © 2017 Łukasz Mróz. All rights reserved.
//

struct NetworkPost: Codable, PostConvertible, Equatable {

    let id: Int
    let userId: Int
    let title: String
    let body: String

    static func ==(lhs: NetworkPost, rhs: NetworkPost) -> Bool {
        return lhs.id == rhs.id && lhs.userId == rhs.userId && lhs.title == rhs.title && lhs.body == rhs.body
    }
}
