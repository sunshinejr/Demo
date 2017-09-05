//
//  PostsNetworkDataControllerProtocol.swift
//  Demo
//
//  Created by Lukasz Mroz on 05.09.2017.
//  Copyright © 2017 Łukasz Mróz. All rights reserved.
//

import Result
import RxSwift

protocol PostsNetworkDataControllerProtocol {

    func getPosts() -> Observable<Result<[Post], DemoError>>
    func getAuthor(post: Post) -> Observable<Result<User, DemoError>>
    func getComments(post: Post) -> Observable<Result<[Comment], DemoError>>
}
