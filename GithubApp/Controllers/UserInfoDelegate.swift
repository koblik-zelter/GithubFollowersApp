//
//  UserInfoDelegate.swift
//  GithubApp
//
//  Created by Alex Koblik-Zelter on 3/14/20.
//  Copyright © 2020 Alex Koblik-Zelter. All rights reserved.
//

import Foundation

protocol UserInfoGithubDelegate: class {
    func didTapOnGithub(on user: User)
}

protocol UserInfoFollowersDelegate: class {
    func didTapOnGetFollowers(of user: User)
}

