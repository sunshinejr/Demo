//
//  PostsDataControllerProtocol.swift
//  Demo
//
//  Created by Lukasz Mroz on 26.08.2017.
//  Copyright © 2017 Łukasz Mróz. All rights reserved.
//

import Result
import RxSwift

protocol PostsDataControllerProtocol {
    
    func getPosts() -> Observable<Result<[Post], DemoError>>
    func getAuthor(post: Post) -> Observable<Result<User, DemoError>>
    func getComments(post: Post) -> Observable<Result<[Comment], DemoError>>
    func getCommentsCount(post: Post) -> Observable<Result<Int, DemoError>>
}
