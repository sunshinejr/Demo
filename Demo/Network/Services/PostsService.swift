//
//  PostsService.swift
//  Demo
//
//  Created by Lukasz Mroz on 25.08.2017.
//  Copyright © 2017 Łukasz Mróz. All rights reserved.
//

import Moya

enum PostsService {
    case getAllPosts
    case getPostComments(Post)
    case getPostAuthor(Post)
}

extension PostsService: TargetType {

    var path: String {
        switch self {
        case .getAllPosts:
            return "/posts"
        case let .getPostAuthor(post):
            return "/users/\(post.userId)"
        case let .getPostComments(post):
            return "/posts/\(post.id)/comments"
        }
    }

    var baseURL: URL { return URL(string: "http://jsonplaceholder.typicode.com/")! }
    var method: Method { return .get }
    var parameters: [String : Any]? { return nil }
    var parameterEncoding: ParameterEncoding { return JSONEncoding.default }
    var task: Task { return .request }
    var sampleData: Data { return Data() }
}
