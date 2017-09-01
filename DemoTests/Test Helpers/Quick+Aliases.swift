//
//  Quick+Aliases.swift
//  DemoTests
//
//  Created by Lukasz Mroz on 01.09.2017.
//  Copyright © 2017 Łukasz Mróz. All rights reserved.
//

import Quick

func given(_ description: String, closure: @escaping (Void) -> Void) {
    describe(description, closure)
}

func when(_ description: String, closure: @escaping (Void) -> Void) {
    context(description, closure)
}

func then(_ description: String, closure: @escaping (Void) -> Void) {
    it(description, closure: closure)
}
