//
//  PostTableViewCell.swift
//  Demo
//
//  Created by Lukasz Mroz on 25.08.2017.
//  Copyright © 2017 Łukasz Mróz. All rights reserved.
//

import UIKit
import RxSwift

final class PostTableViewCell: UITableViewCell, ReusableCell {

    typealias ViewModel = PostTableViewCellViewModel

    @IBOutlet private weak var titleLabel: UILabel!

    var viewModel: ViewModel? {
        didSet {
            clearCurrentViewModelSetup()

            if let viewModel = viewModel {
                setupViewModel(viewModel)
            }
        }
    }

    private var disposeBag = DisposeBag()

    private func clearCurrentViewModelSetup() {
        disposeBag = DisposeBag()
    }

    private func setupViewModel(_ viewModel: ViewModel) {
        viewModel.title.drive(titleLabel.rx.text).addDisposableTo(disposeBag)
    }
}
