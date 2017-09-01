//
//  PostTableViewCellViewModelProtocol.swift
//  Demo
//
//  Created by Lukasz Mroz on 01.09.2017.
//  Copyright © 2017 Łukasz Mróz. All rights reserved.
//

import RxCocoa

protocol PostTableViewCellViewModelProtocol {
    var title: Driver<String> { get }
}
