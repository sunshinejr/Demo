//
//  PostsNetworkDataController.swift
//  Demo
//
//  Created by Lukasz Mroz on 26.08.2017.
//  Copyright © 2017 Łukasz Mróz. All rights reserved.
//

import Result
import RxSwift

final class PostsNetworkDataController: PostsDataControllerProtocol {

    let network: NetworkProtocol

    init(network: NetworkProtocol) {
        self.network = network
    }

    func getPosts() -> Observable<Result<[Post], DemoError>> {
        return network.request(PostsService.getAllPosts, mapArray: NetworkPost.self)
            .map { posts in
                .success(posts.map { $0.asPost })
            }
            .catchDemoError { .just(.failure($0)) }
    }
}
