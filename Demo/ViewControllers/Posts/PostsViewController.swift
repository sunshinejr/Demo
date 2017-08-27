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

    private(set) var viewModel: PostsViewModel!
    private var layout = Layout.empty
    private let disposeBag = DisposeBag()
    private let refreshBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: nil, action: nil)

    convenience init(viewModel: PostsViewModel) {
        self.init()

        self.viewModel = viewModel
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        setupBindings()
    }

    private func setupUI() {
        tableView.register(cell: PostTableViewCell.self)
        tableView.rowHeight = Constants.rowHeight
        navigationItem.rightBarButtonItem = refreshBarButtonItem

        updateLayout(to: .empty)
    }

    private func setupBindings() {
        let refresh = refreshBarButtonItem.rx.tap.asObservable().startWith(())
        let input = PostsViewModel.Input(refresh: refresh)
        let output = viewModel.transform(input: input)

        output.posts
            .map { $0.isEmpty ? Layout.content : .content }
            .drive(onNext: { [unowned self] layout in
                self.updateLayout(to: layout)
            })
            .disposed(by: disposeBag)

        refresh
            .map { Layout.loading }
            .subscribe(onNext: { [unowned self] layout in
                self.updateLayout(to: layout)
            })
            .disposed(by: disposeBag)

        output.posts
            .drive(tableView.rx.reusableItems(cellType: PostTableViewCell.self)) { _, viewModel, cell in
                cell.viewModel = viewModel
            }
            .disposed(by: disposeBag)

        output.error
            .drive(rx.presentError)
            .disposed(by: disposeBag)
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
