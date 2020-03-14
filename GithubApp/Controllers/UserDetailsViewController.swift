//
//  UserDetailsViewController.swift
//  GithubApp
//
//  Created by Alex Koblik-Zelter on 3/14/20.
//  Copyright © 2020 Alex Koblik-Zelter. All rights reserved.
//

import UIKit
import SafariServices

class UserDetailsViewController: UIViewController {
    var userName: String?
    var user: User?
    weak var delegate: UserListDelegate?
    private let headerView = UIView()
    private let firstItemPlaceHolder = UIView()
    private let secondItemPlaceHolder = UIView()
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        self.configureNavigationBar()
        self.configureScrollView()
        self.setupViews()
        self.getUserInfo()
    }

    private func configureNavigationBar() {
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
        self.navigationItem.rightBarButtonItem = doneButton
    }
    
    private func getUserInfo() {
        guard let userName = userName else { return }
        NetworkManager.shared.getUserInfo(for: userName) { (result) in
            switch result {
                case .success(let user):
                    self.user = user
                    DispatchQueue.main.async {
                        self.setupChilds()
                    }
                case .failure:
                    print("ERROR")
            }
        }
    }
    
    private func configureScrollView() {
        self.view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.pinViewTo(self.view)
        contentView.pinViewTo(scrollView)
        
        contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        contentView.heightAnchor.constraint(equalToConstant: 600).isActive = true
    }
    private func setupViews() {
        let views = [headerView, firstItemPlaceHolder, secondItemPlaceHolder]
        views.forEach { (view) in
            self.contentView.addSubview(view)
            view.translatesAutoresizingMaskIntoConstraints = false
            view.leadingAnchor.constraint(equalTo: self.contentView.safeAreaLayoutGuide.leadingAnchor, constant: 16).isActive = true
            view.trailingAnchor.constraint(equalTo: self.contentView.safeAreaLayoutGuide.trailingAnchor, constant: -16).isActive = true
        }
        
        headerView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        headerView.heightAnchor.constraint(equalToConstant: 180).isActive = true
        
        firstItemPlaceHolder.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 16).isActive = true
        firstItemPlaceHolder.heightAnchor.constraint(equalToConstant: 152).isActive = true
        
        secondItemPlaceHolder.topAnchor.constraint(equalTo: firstItemPlaceHolder.bottomAnchor, constant: 16).isActive = true
        secondItemPlaceHolder.heightAnchor.constraint(equalToConstant: 152).isActive = true
    }
    
    private func setupChilds() {
        guard let user = self.user else { return }
        let headerVC = UserInfoHeaderViewController()
        headerVC.user = user
        self.addChildVC(headerVC, at: self.headerView)
        
        let firstItemVC = UserFollowInfoViewController(type: .follower, user: user)
        firstItemVC.delegate = self
        self.addChildVC(firstItemVC, at: self.firstItemPlaceHolder)
        
        let secondItemVC = UserReposInfoViewController(type: .report, user: user)
        secondItemVC.delegate = self
        self.addChildVC(secondItemVC, at: self.secondItemPlaceHolder)
    }
    
    @objc private func dismissVC() {
        self.dismiss(animated: true)
    }
}

extension UserDetailsViewController: UserInfoGithubDelegate, UserInfoFollowersDelegate {
    func didTapOnGithub(on user: User) {
        guard let url = URL(string: user.htmlUrl) else {
            self.showAlert(title: "Invalid URL", message: "The URL is invalid", action: "Ok")
            return
        }
        
        let safariVC = SFSafariViewController(url: url)
        safariVC.preferredControlTintColor = .systemGreen
        self.present(safariVC, animated: true)
    }
    
    func didTapOnGetFollowers(of user: User) {
        if (user.followers > 0) {
            self.delegate?.updateList(for: user)
            self.dismissVC()
        }
    }
    
    
}
