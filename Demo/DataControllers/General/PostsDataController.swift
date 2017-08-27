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

    init(network: Network<PostsService>, database: CDStack) {
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
}
