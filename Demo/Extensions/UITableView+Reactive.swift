//
//  UITableView+Reactive.swift
//  Demo
//
//  Created by Lukasz Mroz on 25.08.2017.
//  Copyright © 2017 Łukasz Mróz. All rights reserved.
//

import RxCocoa
import RxSwift
import UIKit

extension Reactive where Base: UITableView {

    func reusableItems<S: Sequence, Cell: ReusableTableViewCell, O: ObservableType>
        (cellType: Cell.Type)
        -> (_ source: O)
        -> (_ configureCell: @escaping (Int, S.Iterator.Element, Cell) -> Void)
        -> Disposable where O.E == S {
            return items(cellIdentifier: cellType.reuseIdentifier, cellType: cellType)
    }

    var allowsSelection: AnyObserver<Bool> {
        return UIBindingObserver(UIElement: base) { tableView, allowsSelection in
            tableView.allowsSelection = allowsSelection
        }.asObserver()
    }
}
