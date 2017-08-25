//
//  ReusableCell.swift
//  Demo
//
//  Created by Lukasz Mroz on 25.08.2017.
//  Copyright © 2017 Łukasz Mróz. All rights reserved.
//

protocol ReusableCell {
    static var nibName: String { get }
    static var reuseIdentifier: String { get }
}

extension ReusableCell {

    static var nibName: String {
        return "\(self)"
    }

    static var reuseIdentifier: String {
        return "\(self)"
    }
}
