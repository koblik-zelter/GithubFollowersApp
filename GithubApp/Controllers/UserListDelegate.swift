//
//  UserListDelegate.swift
//  GithubApp
//
//  Created by Alex Koblik-Zelter on 3/14/20.
//  Copyright © 2020 Alex Koblik-Zelter. All rights reserved.
//

import Foundation

protocol UserListDelegate: class {
    func updateList(for user: User)
}
