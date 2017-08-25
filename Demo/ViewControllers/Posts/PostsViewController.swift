//
//  PostsViewController.swift
//  Demo
//
//  Created by Lukasz Mroz on 25.08.2017.
//  Copyright © 2017 Łukasz Mróz. All rights reserved.
//

import RxCocoa
import RxSwift
import UIKit

final class PostsViewController: UIViewController {

    enum Constants {
        static let rowHeight: CGFloat = 40.0
    }

    @IBOutlet private weak var contentView: UIView!
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var loadingView: UIView!

    private var layout = Layout.empty
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }

    private func setupUI() {
        tableView.register(cell: PostTableViewCell.self)
        tableView.rowHeight = Constants.rowHeight

        let posts = ["hey", "there", "its", "me", "your", "brother"].map(PostTableViewCellViewModel.init)
        let observablePosts = Driver.just(posts)

        observablePosts
            .drive(tableView.rx.reusableItems(cellType: PostTableViewCell.self)) { _, viewModel, cell in
                cell.viewModel = viewModel
            }
            .addDisposableTo(disposeBag)

        updateLayout(to: .content)
    }

    private func updateLayout(to: Layout) {
        // TODO: Could be animated
        switch to {
        case .empty:
            contentView.alpha = 0.0
            loadingView.alpha = 0.0
        case .loading:
            contentView.alpha = 0.0
            loadingView.alpha = 1.0
        case .content:
            contentView.alpha = 1.0
            loadingView.alpha = 0.0
        }
    }
}
