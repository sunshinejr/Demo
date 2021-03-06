//
//  PostsViewControllerDelegate.swift
//  Demo
//
//  Created by Lukasz Mroz on 01.09.2017.
//  Copyright © 2017 Łukasz Mróz. All rights reserved.
//

protocol PostsViewControllerDelegate: class {
    func didSelectPost(_ post: Post, dataController: PostsDataControllerProtocol)
}
