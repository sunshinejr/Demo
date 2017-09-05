//
//  PostsNetworkDataController.swift
//  Demo
//
//  Created by Lukasz Mroz on 26.08.2017.
//  Copyright © 2017 Łukasz Mróz. All rights reserved.
//

import Result
import RxSwift

final class PostsNetworkDataController: PostsNetworkDataControllerProtocol {

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

    func getAuthor(post: Post) -> Observable<Result<User, DemoError>> {
        return network.request(PostsService.getPostAuthor(post), mapObject: NetworkUser.self)
            .map { .success($0.asUser) }
            .catchDemoError { .just(.failure($0)) }
    }

    func getComments(post: Post) -> Observable<Result<[Comment], DemoError>> {
        return network.request(PostsService.getPostComments(post), mapArray: NetworkComment.self)
            .map { comments in
                .success(comments.map { $0.asComment })
            }
            .catchDemoError { .just(.failure($0)) }
    }
}
