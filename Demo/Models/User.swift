//
//  User.swift
//  Demo
//
//  Created by Lukasz Mroz on 25.08.2017.
//  Copyright © 2017 Łukasz Mróz. All rights reserved.
//

protocol UserProtocol {
    var id: Int { get }
    var name: String { get }
    var username: String { get }
    var email: String { get }

    init(id: Int, name: String, username: String, email: String)
}

extension UserProtocol {
    func to<T: UserProtocol>(_ type: T.Type) -> T {
        return T(id: id, name: name, username: username, email: email)
    }
}

struct User {

    let id: Int
    let name: String
    let username: String
    let email: String
}
