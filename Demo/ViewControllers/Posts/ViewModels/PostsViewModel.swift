//
//  PostsViewModel.swift
//  Demo
//
//  Created by Lukasz Mroz on 27.08.2017.
//  Copyright © 2017 Łukasz Mróz. All rights reserved.
//

import RxCocoa
import RxSwift

final class PostsViewModel {

    struct Input {
        let refresh: Observable<Void>
    }

    struct Output {
        let posts: Driver<[PostTableViewCellViewModel]>
        let error: Driver<DemoError>
    }

    let dataController: PostsDataControllerProtocol

    init(dataController: PostsDataControllerProtocol) {
        self.dataController = dataController
    }

    func transform(input: Input) -> Output {
        let postsResultObservable = dataController.getPosts().shareReplayLatestWhileConnected()
        let errorObservable = postsResultObservable.map { $0.error }.filterNil()
        let postsObservable = postsResultObservable.map { $0.value }.filterNil()
            .map { $0.map(PostTableViewCellViewModel.init) }

        let refreshErrorObservable = input.refresh
            .flatMapLatest { errorObservable }
            .asDriver(onErrorJustReturn: .unknown)

        let refreshPostsObservable = input.refresh
            .flatMapLatest { postsObservable }
            .asDriver(onErrorJustReturn: [])

        return Output(posts: refreshPostsObservable, error: refreshErrorObservable)
    }
}
