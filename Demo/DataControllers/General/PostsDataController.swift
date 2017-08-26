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
    let databaseDataController: PostsNetworkDataController

    init(network: Network<PostsService>) {
        self.networkDataController = PostsNetworkDataController(network: network)
        self.databaseDataController = PostsNetworkDataController(network: network) // TODO: Replace it when database stack is implemented
    }

    init(networkDataController: PostsNetworkDataController, databaseDataController: PostsNetworkDataController) {
        self.networkDataController = networkDataController
        self.databaseDataController = databaseDataController
    }

    func getPosts() -> Observable<Result<[Post], DemoError>> {
        let databaseDataController = self.databaseDataController

        return get(data: networkDataController.getPosts(),
                   onErrorReturn: { _ in databaseDataController.getPosts() },
                   onSuccessReturn: { posts in
                    // TODO: Save posts
                    // TODO: Get posts from DB
                    return .just(.success(posts))
        })
    }
}
