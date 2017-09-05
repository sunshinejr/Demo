//
//  PostCellViewModel.swift
//  Demo
//
//  Created by Lukasz Mroz on 25.08.2017.
//  Copyright © 2017 Łukasz Mróz. All rights reserved.
//

import RxCocoa

struct PostTableViewCellViewModel: PostTableViewCellViewModelProtocol, Equatable {

    let title: Driver<String>
    let post: Post

    init(post: Post) {
        self.post = post
        self.title = .just(post.title)
    }

    static func ==(lhs: PostTableViewCellViewModel, rhs: PostTableViewCellViewModel) -> Bool {
        return lhs.post == rhs.post
    }
}
