//
//  UITableView+ReusableCell.swift
//  Demo
//
//  Created by Lukasz Mroz on 25.08.2017.
//  Copyright © 2017 Łukasz Mróz. All rights reserved.
//

import UIKit

extension UITableView {

    func register<CellType: ReusableCell>(cell: CellType.Type) {
        register(UINib(nibName: cell.nibName, bundle: nil), forCellReuseIdentifier: cell.reuseIdentifier)
    }

    func dequeue<CellType: ReusableCell>(cell: CellType.Type, indexPath: IndexPath) -> CellType {
        return dequeueReusableCell(withIdentifier: cell.reuseIdentifier, for: indexPath) as! CellType
    }

    func dequeue<CellType: ReusableCell>(cell: CellType.Type, row: Int) -> CellType {
        let indexPath = IndexPath(row: row, section: 0)
        return self.dequeue(cell: cell, indexPath: indexPath)
    }
}
