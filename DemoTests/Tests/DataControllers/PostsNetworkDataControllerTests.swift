//
//  PostsNetworkDataControllerTests.swift
//  DemoTests
//
//  Created by Lukasz Mroz on 01.09.2017.
//  Copyright © 2017 Łukasz Mróz. All rights reserved.
//

import Nimble
import Quick
import Result
import RxSwift
import RxTest

final class PostsNetworkDataControllerTests: QuickSpec {

    override func spec() {
        let subscribedTime = TestScheduler.Defaults.subscribed
        var dataController: PostsNetworkDataController!
        var network: FakeNetwork!
        var scheduler: TestScheduler!

        beforeEach {
            scheduler = TestScheduler(initialClock: 0)
            network = FakeNetwork()
            dataController = PostsNetworkDataController(network: network)
        }

        when("response contains correcly parsed objects") {
            var networkPosts: [NetworkPost]!

            beforeEach {
                networkPosts = (0...10).map { NetworkPost(id: $0, userId: $0, title: "title\($0)", body: "body\($0)") }
                network.arrayResponsesClosure = { _ in
                    return .success([networkPosts])
                }
            }

            then("getPost() method should return these parsed objects") {
                let posts = networkPosts.map { $0.asPost }
                let observer = scheduler.start { dataController.getPosts().map { $0.value }.filterNil() }

                let recordedEvents = observer.events
                let expectedEvents: [Recorded<Event<[Post]>>] = [
                    next(subscribedTime, posts),
                    completed(subscribedTime)
                ]

                expect(recordedEvents).to(equal(expectedEvents))
            }
        }

        when("response contains an error") {
            var error: DemoError!

            beforeEach {
                error = DemoError.networkError
                network.arrayResponsesClosure = { _ in
                    return .failure(error)
                }
            }

            then("getPost() method should return this specific error") {
                let observer = scheduler.start { dataController.getPosts().map { $0.error }.filterNil() }

                let recordedEvents = observer.events
                let expectedEvents: [Recorded<Event<DemoError>>] = [
                    next(subscribedTime, error),
                    completed(subscribedTime)
                ]
                
                expect(recordedEvents).to(equal(expectedEvents))
            }
        }
    }
}
