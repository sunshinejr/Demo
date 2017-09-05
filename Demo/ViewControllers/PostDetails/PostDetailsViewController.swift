//
//  PostDetailsViewController.swift
//  Demo
//
//  Created by Lukasz Mroz on 29.08.2017.
//  Copyright © 2017 Łukasz Mróz. All rights reserved.
//

import UIKit

import RxCocoa
import RxSwift

protocol PostDetailsViewModelProtocol {
    var body: Driver<String> { get }
    var title: Driver<String> { get }
    var authorName: Driver<String> { get }
    var authorNameError: Driver<DemoError> { get }
    var commentsCount: Driver<String> { get }
    var commentsCountError: Driver<DemoError> { get }
}

import RxCocoa
import RxSwift

struct PostDetailsViewModel: PostDetailsViewModelProtocol {

    let body: Driver<String>
    let title: Driver<String>
    let authorName: Driver<String>
    let authorNameError: Driver<DemoError>
    let commentsCount: Driver<String>
    let commentsCountError: Driver<DemoError>
    let post: Post
    let dataController: PostsDataControllerProtocol

    init(post: Post, dataController: PostsDataControllerProtocol) {
        self.post = post
        self.dataController = dataController

        title = .just(post.title)
        body = .just(post.body)

        let authorResult = dataController.getAuthor(post: post).shareReplayLatestWhileConnected()
        authorName = authorResult.map { $0.value?.name }.filterNil().asDriver(onErrorRecover: { _ in .just("") })
        authorNameError = authorResult.map { $0.error }.filterNil().asDriver(onErrorRecover: { _ in .empty() })

        let commentsCountResult = dataController.getCommentsCount(post: post).shareReplayLatestWhileConnected()
        commentsCount = commentsCountResult.map { $0.value }.filterNil().map { "\($0)" }.asDriver(onErrorRecover: { _ in .just("") })
        commentsCountError = commentsCountResult.map { $0.error }.filterNil().asDriver(onErrorRecover: { _ in .empty() })
    }
}

final class PostDetailsViewController: UIViewController {

    typealias ViewModel = PostDetailsViewModelProtocol

    @IBOutlet private weak var postBody: UILabel!
    @IBOutlet private weak var authorLabel: UILabel!
    @IBOutlet private weak var author: UILabel!
    @IBOutlet private weak var commentsCountLabel: UILabel!
    @IBOutlet private weak var commentsCount: UILabel!

    private let disposeBag = DisposeBag()
    private(set) var viewModel: ViewModel!

    convenience init(viewModel: ViewModel) {
        self.init()

        self.viewModel = viewModel
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupBindings()
    }

    private func setupUI() {
        authorLabel.text = localizable(from: .author) + ":"
        commentsCountLabel.text = localizable(from: .commentsCount) + ":"
    }

    private func setupBindings() {
        viewModel.authorName.drive(author.rx.text).disposed(by: disposeBag)
        viewModel.body.drive(postBody.rx.text).disposed(by: disposeBag)
        viewModel.title.drive(rx.title).disposed(by: disposeBag)
        viewModel.commentsCount.drive(commentsCount.rx.text).disposed(by: disposeBag)
        viewModel.authorNameError.drive(rx.presentError).disposed(by: disposeBag)
        viewModel.commentsCountError.drive(rx.presentError).disposed(by: disposeBag)
    }
}
