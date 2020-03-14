//
//  UserGitInfoViewController.swift
//  GithubApp
//
//  Created by Alex Koblik-Zelter on 3/15/20.
//  Copyright © 2020 Alex Koblik-Zelter. All rights reserved.
//

import UIKit

class UserFollowInfoViewController: UserItemViewController {

    weak var delegate: UserInfoFollowersDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didTapActionButton() {
        self.delegate?.didTapOnGetFollowers(of: self.user)
    }
}
