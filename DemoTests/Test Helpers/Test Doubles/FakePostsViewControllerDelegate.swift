//
//  FakePostsViewControllerDelegate.swift
//  DemoTests
//
//  Created by Lukasz Mroz on 05.09.2017.
//  Copyright © 2017 Łukasz Mróz. All rights reserved.
//

import Result
import RxSwift

final class FakePostsViewControllerDelegate: PostsViewControllerDelegate {

    typealias DidSelectPostClosureType = (_ post: Post) -> ()

    var didSelectPostClosure: DidSelectPostClosureType?

    init(didSelectPostClosure: DidSelectPostClosureType? = nil) {
        self.didSelectPostClosure = didSelectPostClosure
    }

    func didSelectPost(_ post: Post) {
        didSelectPostClosure?(post)
    }
}
