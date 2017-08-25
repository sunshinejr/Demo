//
//  Post.swift
//  Demo
//
//  Created by Lukasz Mroz on 25.08.2017.
//  Copyright © 2017 Łukasz Mróz. All rights reserved.
//

protocol PostProtocol {
    var id: Int { get }
    var userId: Int { get }
    var title: String { get }
    var body: String { get }

    init(id: Int, userId: Int, title: String, body: String)
}

extension PostProtocol {
    func to<T: PostProtocol>(_ type: T.Type) -> T {
        return T(id: id, userId: userId, title: title, body: body)
    }
}

struct Post: PostProtocol {

    let id: Int
    let userId: Int
    let title: String
    let body: String
}
