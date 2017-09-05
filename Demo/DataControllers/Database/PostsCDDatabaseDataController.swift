//
//  PostsCDDatabaseDataController.swift
//  Demo
//
//  Created by Lukasz Mroz on 27.08.2017.
//  Copyright © 2017 Łukasz Mróz. All rights reserved.
//

import CoreData
import Result
import RxSwift

struct PostsCDDatabaseDataController: PostsDatabaseDataControllerProtocol {

    let database: CDStackProtocol

    init(database: CDStackProtocol) {
        self.database = database
    }

    func getPosts() -> Observable<Result<[Post], DemoError>> {
        let request = NSFetchRequest<CDPost>(entityName: CDPost.entityName)
        request.sortDescriptors = [NSSortDescriptor(keyPath: \CDPost.id, ascending: false)]

        return database.request(request)
    }

    func savePosts(_ posts: [Post]) -> Observable<Void> {
        // TODO: Remove this one after CD sync testing
        let random: Int = Int(arc4random_uniform(1000)) + 10
        let newPost = Post(id: 974 + random, userId: 1461, title: "test\(random)", body: "test\(random)")
        var newPosts = posts
        newPosts.append(newPost)
        return database.save(newPosts, type: CDPost.self)
    }
}
