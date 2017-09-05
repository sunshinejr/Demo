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
    var commentsCount: Driver<Int> { get }
}

import RxCocoa
import RxSwift

//struct PostDetailsViewModel: PostDetailsViewModelProtocol {
//
//}

final class PostDetailsViewController: UIViewController {

    typealias ViewModel = PostDetailsViewModelProtocol

    @IBOutlet private weak var postBody: UILabel!
    @IBOutlet private weak var authorLabel: UILabel!
    @IBOutlet private weak var author: UILabel!
    @IBOutlet private weak var commentsCountLabel: UILabel!
    @IBOutlet private weak var commentsCount: UILabel!

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

    }

    private func setupBindings() {

    }
}
