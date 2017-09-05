//
//  PostsDataController.swift
//  Demo
//
//  Created by Lukasz Mroz on 26.08.2017.
//  Copyright © 2017 Łukasz Mróz. All rights reserved.
//

import Result
import RxSwift

struct PostsDataController: PostsDataControllerProtocol, CompositeDataControllerProtocol {

    let networkDataController: PostsNetworkDataController
    let databaseDataController: PostsDatabaseDataControllerProtocol

    init(network: NetworkProtocol, database: CDStack) {
        self.networkDataController = PostsNetworkDataController(network: network)
        self.databaseDataController = PostsCDDatabaseDataController(database: database)
    }

    init(networkDataController: PostsNetworkDataController, databaseDataController: PostsDatabaseDataControllerProtocol) {
        self.networkDataController = networkDataController
        self.databaseDataController = databaseDataController
    }

    func getPosts() -> Observable<Result<[Post], DemoError>> {
        let databaseDataController = self.databaseDataController

        return get(data: networkDataController.getPosts(),
                   onErrorReturn: { _ in databaseDataController.getPosts() },
                   onSuccessReturn: { posts in
                    databaseDataController.savePosts(posts).flatMap { databaseDataController.getPosts() }})
    }

    func getAuthor(post: Post) -> Observable<Result<User, DemoError>> {
        let databaseDataController = self.databaseDataController

        return get(data: networkDataController.getAuthor(post: post),
                   onErrorReturn: {_ in
                        databaseDataController.getAuthor(post: post)
                    },
                   onSuccessReturn: { author in
                    databaseDataController.saveAuthor(author).flatMap { databaseDataController.getAuthor(post: post) }})
    }

    func getComments(post: Post) -> Observable<Result<[Comment], DemoError>> {
        let databaseDataController = self.databaseDataController

        return get(data: networkDataController.getComments(post: post),
                   onErrorReturn: { _ in databaseDataController.getComments(post: post) },
                   onSuccessReturn: { comments in
                    databaseDataController.saveComments(comments).flatMap { databaseDataController.getComments(post: post) }})
    }

    func getCommentsCount(post: Post) -> Observable<Result<Int, DemoError>> {
        let databaseDataController = self.databaseDataController

        return get(data: networkDataController.getComments(post: post),
                   onErrorReturn: { _ in databaseDataController.getCommentsCount(post: post) },
                   onSuccessReturn: { comments in
                    databaseDataController.saveComments(comments).flatMap { databaseDataController.getCommentsCount(post: post) }})
    }
}
