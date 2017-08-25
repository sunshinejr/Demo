//
//  NetworkPost.swift
//  Demo
//
//  Created by Lukasz Mroz on 25.08.2017.
//  Copyright © 2017 Łukasz Mróz. All rights reserved.
//

struct NetworkPost: Codable, PostProtocol {

    let id: Int
    let userId: Int
    let title: String
    let body: String
}
