//
//  User.swift
//  Demo
//
//  Created by Lukasz Mroz on 25.08.2017.
//  Copyright © 2017 Łukasz Mróz. All rights reserved.
//

protocol UserConvertible {
    var id: Int { get }
    var name: String { get }
    var username: String { get }
    var email: String { get }
}

extension UserConvertible {
    var asUser: User {
        return User(id: id, name: name, username: username, email: email)
    }
}

struct User: UserConvertible {

    let id: Int
    let name: String
    let username: String
    let email: String
}
