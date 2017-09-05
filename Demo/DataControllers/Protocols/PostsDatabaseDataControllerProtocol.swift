//
//  PostsDatabaseDataControllerProtocol.swift
//  Demo
//
//  Created by Lukasz Mroz on 27.08.2017.
//  Copyright © 2017 Łukasz Mróz. All rights reserved.
//

import RxSwift

protocol PostsDatabaseDataControllerProtocol: PostsDataControllerProtocol {

    func savePosts(_ posts: [Post]) -> Observable<Void>
    func saveAuthor(_ user: User) -> Observable<Void>
    func saveComments(_ comments: [Comment]) -> Observable<Void>
}
