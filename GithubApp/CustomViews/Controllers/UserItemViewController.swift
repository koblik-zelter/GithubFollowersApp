//
//  UserItemViewController.swift
//  GithubApp
//
//  Created by Alex Koblik-Zelter on 3/14/20.
//  Copyright © 2020 Alex Koblik-Zelter. All rights reserved.
//

import UIKit


enum ItemTypes {
    case report
    case follower
}

class UserItemViewController: UIViewController {
    
    private let stackView = UIStackView()
    private let itemInfoViewOne = CustomItemInfoView()
    private let itemInfoViewTwo = CustomItemInfoView()
    
    let actionButton = CustomButton()
    
    weak var followersDelegate: UserInfoFollowersDelegate?
    
    var itemType: ItemTypes! {
        didSet {
            self.configureItems()
        }
    }
    var user: User!
    
    init(type: ItemTypes, user: User) {
        super.init(nibName: nil, bundle: nil)
        self.itemType = type
        self.user = user
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureBackgroundView()
        self.layoutUI()
        self.configureStackView()
        self.configureItems()
    }
    
    private func configureBackgroundView() {
        view.layer.cornerRadius = 18
        view.backgroundColor = .secondarySystemBackground
    }
    
    private func configureStackView() {
        self.stackView.axis = .horizontal
        self.stackView.distribution = .equalSpacing
        
        self.stackView.addArrangedSubview(itemInfoViewOne)
        self.stackView.addArrangedSubview(itemInfoViewTwo)
    }
    
    private func layoutUI() {
        view.addSubview(stackView)
        view.addSubview(actionButton)
        self.actionButton.addTarget(self, action: #selector(didTapActionButton), for: .touchUpInside)
        
        self.stackView.translatesAutoresizingMaskIntoConstraints = false
        let padding: CGFloat = 20
        
      
        stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: padding).isActive = true
        stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding).isActive = true
        stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding).isActive = true
        stackView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        actionButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -padding).isActive = true
        actionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding).isActive = true
        actionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding).isActive = true
        actionButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
        
    }
    
    func configureItems() {
        switch self.itemType {
            case .follower:
                self.itemInfoViewOne.set(itemInfoType: .followers, withCount: user.followers)
                self.itemInfoViewTwo.set(itemInfoType: .following, withCount: user.following)
                self.actionButton.set(backgroundColor: .systemGreen, title: "Get Followers")
            case .report:
                self.itemInfoViewOne.set(itemInfoType: .repos, withCount: user.publicRepos)
                self.itemInfoViewTwo.set(itemInfoType: .gists, withCount: user.publicGists)
                self.actionButton.set(backgroundColor: .systemPurple, title: "GitHub Profile")
            default:
                print("ERROR")
        }
    }
    
    @objc func didTapActionButton() { }
}
