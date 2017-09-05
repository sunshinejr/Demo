//
//  PostsCDDatabaseDataControllerTests.swift
//  DemoTests
//
//  Created by Lukasz Mroz on 03.09.2017.
//  Copyright © 2017 Łukasz Mróz. All rights reserved.
//

import Nimble
import Quick
import Result
import RxSwift
import RxTest

final class PostsCDDatabaseDataControllerTests: QuickSpec {

    override func spec() {
        var dataController: PostsCDDatabaseDataController!
        var database: FakeCDStack!
        var scheduler: TestScheduler!

        beforeEach {
            scheduler = TestScheduler(initialClock: 0)
            database = FakeCDStack()
            dataController = PostsCDDatabaseDataController(database: database)
        }
    }
}

