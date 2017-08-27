//
//  PostsDatabaseDataController.swift
//  Demo
//
//  Created by Lukasz Mroz on 27.08.2017.
//  Copyright © 2017 Łukasz Mróz. All rights reserved.
//

import CoreData
import Result
import RxSwift

struct PostsCDDatabaseDataController: PostsDatabaseDataControllerProtocol {

    let database: CDStack

    init(database: CDStack) {
        self.database = database
    }

    func getPosts() -> Observable<Result<[Post], DemoError>> {
        let request = NSFetchRequest<CDPost>(entityName: CDPost.entityName)
        request.sortDescriptors = [NSSortDescriptor(keyPath: \CDPost.id, ascending: false)]
        do {
            let posts = try database.mainContext.fetch(request).map { $0.asPost }
            return .just(.success(posts))
        } catch let error {
            let demoError = DemoError(error: error)
            return .just(.failure(demoError))
        }
    }

    func savePosts(_ posts: [Post]) -> Observable<Void> {
        let context = database.mainContext
        let block: () -> Void = {
            posts.forEach { post in
                let cdPost = CDPost.insert(into: context)
                cdPost.update(with: post)
            }
        }
        return context.saveOrRollback(actionBlock: block)
    }
}
