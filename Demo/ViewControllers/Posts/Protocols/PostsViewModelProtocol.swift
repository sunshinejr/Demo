//
//  PostsViewModelProtocol.swift
//  Demo
//
//  Created by Lukasz Mroz on 01.09.2017.
//  Copyright © 2017 Łukasz Mróz. All rights reserved.
//

import RxCocoa
import RxSwift

protocol PostsViewModelInputProtocol {
    var refresh: Observable<Void> { get }
    var postSelected: Observable<PostTableViewCellViewModel> { get }
}

protocol PostsViewModelOutputProtocol {
    var posts: Driver<[PostTableViewCellViewModel]> { get }
    var error: Driver<DemoError> { get }
    var selectionEnabled: Driver<Bool> { get }
}

protocol PostsViewModelProtocol {
    func transform(input: PostsViewModelInputProtocol) -> PostsViewModelOutputProtocol
}
