//
//  PostsViewController.swift
//  Demo
//
//  Created by Lukasz Mroz on 25.08.2017.
//  Copyright © 2017 Łukasz Mróz. All rights reserved.
//

import UIKit

final class PostsViewController: UIViewController {

    @IBOutlet private weak var contentView: UIView!
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var loadingView: UIView!

    private var layout = Layout.empty

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }

    private func setupUI() {
        tableView.register(cell: PostTableViewCell.self)
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
