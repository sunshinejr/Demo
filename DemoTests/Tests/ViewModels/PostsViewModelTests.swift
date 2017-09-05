//
//  PostsViewModelTests.swift
//  DemoTests
//
//  Created by Lukasz Mroz on 05.09.2017.
//  Copyright © 2017 Łukasz Mróz. All rights reserved.
//

import Nimble
import Quick
import RxTest

final class PostsViewModelTests: QuickSpec {

    override func spec() {
        var dataController: FakePostsDataController!
        var delegate: FakePostsViewControllerDelegate!
        var viewModel: PostsViewModel!
        var scheduler: TestScheduler!

        beforeEach {
            dataController = FakePostsDataController()
            delegate = FakePostsViewControllerDelegate()
            viewModel = PostsViewModel(dataController: dataController, delegate: delegate)
            scheduler = TestScheduler(initialClock: 0)
        }

        when("refresh input signal comes") {
            then("new posts data output comes as well") {
                let posts = (0...10).map { NetworkPost(id: $0, userId: $0, title: "title\($0)", body: "body\($0)") }.map { $0.asPost }
                dataController.postsResults = [.success(posts)]
                let postsViewModels = posts.map(PostTableViewCellViewModel.init)
                let refresh = scheduler.createHotObservable([next(300, ())]).asObservable()
                let input = PostsViewModel.Input(refresh: refresh, postSelected: .empty())
                let output = viewModel.transform(input: input)
                let observer = scheduler.start { output.posts.asObservable().observeOn(scheduler) }

                let recordedEvents = observer.events
                let expectedEvents = [next(301, postsViewModels)]

                expect(recordedEvents).to(equal(expectedEvents))
            }
        }
    }
}
