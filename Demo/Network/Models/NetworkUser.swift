//
//  NetworkUser.swift
//  Demo
//
//  Created by Lukasz Mroz on 05.09.2017.
//  Copyright © 2017 Łukasz Mróz. All rights reserved.
//

struct NetworkUser: UserConvertible, Codable, Equatable {

    let id: Int
    let name: String
    let username: String
    let email: String

    static func ==(lhs: NetworkUser, rhs: NetworkUser) -> Bool {
        return lhs.id == rhs.id
    }
}

