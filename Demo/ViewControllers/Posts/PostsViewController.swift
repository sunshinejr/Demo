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

    typealias ViewModel = PostsViewModelProtocol

    enum Constants {
        static let rowHeight: CGFloat = 40.0
    }

    @IBOutlet private weak var contentView: UIView!
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var loadingView: UIView!

    private(set) var viewModel: ViewModel!
    private var layout = Layout.empty
    private var disposeBag = DisposeBag()
    private let refreshBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: nil, action: nil)

    convenience init(viewModel: ViewModel) {
        self.init()

        self.viewModel = viewModel
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        setupBindings()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        removeBindings()
    }

    private func setupUI() {
        tableView.register(cell: PostTableViewCell.self)
        tableView.rowHeight = Constants.rowHeight
        navigationItem.rightBarButtonItem = refreshBarButtonItem

        updateLayout(to: .empty)
    }

    private func setupBindings() {
        let viewDidAppear = rx.sentMessage(#selector(UIViewController.viewDidAppear)).take(1).map { _ in }
        let refresh = Observable.merge([viewDidAppear, refreshBarButtonItem.rx.tap.asObservable()])
        let postSelected: Observable<PostTableViewCellViewModel> = tableView.rx.itemSelected
            .map { [unowned self] in try? self.tableView.rx.model(at: $0) }
            .filterNil()
        let input = PostsViewModel.Input(refresh: refresh, postSelected: postSelected)
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

        output.selectionEnabled
            .drive(tableView.rx.allowsSelection)
            .disposed(by: disposeBag)
    }

    private func removeBindings() {
        disposeBag = DisposeBag()
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
