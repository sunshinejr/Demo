//
//  PostsViewModel.swift
//  Demo
//
//  Created by Lukasz Mroz on 27.08.2017.
//  Copyright © 2017 Łukasz Mróz. All rights reserved.
//

import RxCocoa
import RxSwift

final class PostsViewModel: PostsViewModelProtocol {

    struct Input: PostsViewModelInputProtocol {
        let refresh: Observable<Void>
        let postSelected: Observable<PostTableViewCellViewModel>
    }

    struct Output: PostsViewModelOutputProtocol {
        let posts: Driver<[PostTableViewCellViewModel]>
        let error: Driver<DemoError>
        let selectionEnabled: Driver<Bool>
    }

    let dataController: PostsDataControllerProtocol

    private(set) weak var delegate: PostsViewControllerDelegate?

    init(dataController: PostsDataControllerProtocol, delegate: PostsViewControllerDelegate?) {
        self.dataController = dataController
        self.delegate = delegate
    }

    func transform(input: PostsViewModelInputProtocol) -> PostsViewModelOutputProtocol {
        let dataController = self.dataController
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

        let selectionEnabled = input.postSelected
            .do(onNext: { [unowned self] postViewModel in
                self.delegate?.didSelectPost(postViewModel.post, dataController: dataController)
            })
            .map { _ in false }
            .startWith(true)
            .asDriver(onErrorJustReturn: true)

        return Output(posts: refreshPostsObservable, error: refreshErrorObservable, selectionEnabled: selectionEnabled)
    }
}
