//
//  FakePostsDataController.swift
//  DemoTests
//
//  Created by Lukasz Mroz on 05.09.2017.
//  Copyright © 2017 Łukasz Mróz. All rights reserved.
//

import Result
import RxSwift

final class FakePostsDataController: PostsDataControllerProtocol {

    var postsResults = [Result<[Post], DemoError>]()
    var authorResults = [Result<User, DemoError>]()
    var commentsResults = [Result<[Comment], DemoError>]()
    var commentsCountResults = [Result<Int, DemoError>]()


    func getPosts() -> Observable<Result<[Post], DemoError>> {
        return Observable.from(postsResults)
    }

    func getAuthor(post: Post) -> Observable<Result<User, DemoError>> {
        return Observable.from(authorResults)
    }

    func getComments(post: Post) -> Observable<Result<[Comment], DemoError>> {
        return Observable.from(commentsResults)
    }

    func getCommentsCount(post: Post) -> Observable<Result<Int, DemoError>> {
        return Observable.from(commentsCountResults)
    }
}
