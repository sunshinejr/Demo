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

    var results = [Result<[Post], DemoError>]()

    func getPosts() -> Observable<Result<[Post], DemoError>> {
        return Observable.from(results)
    }
}
