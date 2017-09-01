//
//  PostCellViewModel.swift
//  Demo
//
//  Created by Lukasz Mroz on 25.08.2017.
//  Copyright © 2017 Łukasz Mróz. All rights reserved.
//

import RxCocoa

struct PostTableViewCellViewModel: PostTableViewCellViewModelProtocol {

    let title: Driver<String>
    let post: Post

    init(post: Post) {
        self.post = post
        self.title = .just(post.title)
    }
}
