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

    func getAuthor(post: Post) -> Observable<Result<User, DemoError>> {
        let request = NSFetchRequest<CDUser>(entityName: CDUser.entityName)
        request.predicate = NSPredicate(format: "\(#keyPath(CDUser.id)) == %d", post.userId)
        request.fetchLimit = 1

        let results = database.request(request)
        // TODO: Extract this to some generic func
        return results.map { result -> Result<User, DemoError> in
            switch result {
            case let .success(users):
                if let user = users.first {
                    return .success(user)
                } else {
                    return .failure(.noResults)
                }
            case let .failure(error):
                return .failure(error)
            }
        }
    }

    func getCommentsCount(post: Post) -> Observable<Result<Int, DemoError>> {
        let request = NSFetchRequest<CDComment>(entityName: CDComment.entityName)
        request.predicate = NSPredicate(format: "\(#keyPath(CDComment.postId)) == %d", post.id)

        return database.count(request)
    }

    func getComments(post: Post) -> Observable<Result<[Comment], DemoError>> {
        let request = NSFetchRequest<CDComment>(entityName: CDComment.entityName)
        request.predicate = NSPredicate(format: "\(#keyPath(CDComment.postId)) == %d", post.id)

        return database.request(request)
    }

    func savePosts(_ posts: [Post]) -> Observable<Void> {
        return database.save(posts, type: CDPost.self)
    }

    func saveAuthor(_ user: User) -> Observable<Void> {
        return database.save([user], type: CDUser.self)
    }

    func saveComments(_ comments: [Comment]) -> Observable<Void> {
        return database.save(comments, type: CDComment.self)
    }
}
