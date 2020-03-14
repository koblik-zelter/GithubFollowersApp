//
//  UserInfoHeaderViewController.swift
//  GithubApp
//
//  Created by Alex Koblik-Zelter on 3/14/20.
//  Copyright © 2020 Alex Koblik-Zelter. All rights reserved.
//

import UIKit

class UserInfoHeaderViewController: UIViewController {
    
    let avatarImageView = MyImageView(frame: .zero)
    let usernameLabel = CustomLabel(textAlignment: .left, fontSize: 34)
    let nameLabel = CustomSecondaryTitleLabel(fontSize: 18)
    let locationImageView = UIImageView()
    let locationLabel = CustomSecondaryTitleLabel(fontSize: 18)
    let bioLabel = CustomDescriptionLabel(textAlignment: .left)
    
    var user: User!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layoutUI()
        configureUIElements()
    }
    
    func configureUIElements() {
        avatarImageView.setImage(urlString: user.avatarUrl)
        usernameLabel.text = user.login
        nameLabel.text = user.name ?? ""
        locationLabel.text = user.location ?? "No Location"
        bioLabel.text = user.bio ?? "No bio available"
        bioLabel.numberOfLines = 3
        
        locationImageView.image = UIImage(systemName: Symbols.location)
        locationImageView.tintColor = .secondaryLabel
        locationImageView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func layoutUI() {
        let views = [avatarImageView, usernameLabel, nameLabel, locationImageView, locationLabel, bioLabel]
        
        views.forEach { self.view.addSubview($0) }
        
        avatarImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20).isActive = true
        avatarImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        avatarImageView.widthAnchor.constraint(equalToConstant: 90).isActive = true
        avatarImageView.heightAnchor.constraint(equalToConstant: 90).isActive = true
        
        usernameLabel.topAnchor.constraint(equalTo: avatarImageView.topAnchor).isActive = true
        usernameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 16).isActive = true
        usernameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        usernameLabel.heightAnchor.constraint(equalToConstant: 36).isActive = true
            
        nameLabel.centerYAnchor.constraint(equalTo: avatarImageView.centerYAnchor, constant: 8).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 16).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        nameLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
            
        locationImageView.bottomAnchor.constraint(equalTo: avatarImageView.bottomAnchor).isActive = true
        locationImageView.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 12).isActive = true
        locationImageView.widthAnchor.constraint(equalToConstant: 20).isActive = true
        locationImageView.heightAnchor.constraint(equalToConstant: 20).isActive = true
            
        locationLabel.centerYAnchor.constraint(equalTo: locationImageView.centerYAnchor).isActive = true
        locationLabel.leadingAnchor.constraint(equalTo: locationImageView.trailingAnchor, constant: 8).isActive = true
        locationLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        locationLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
            
        bioLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 16).isActive = true
        bioLabel.leadingAnchor.constraint(equalTo: avatarImageView.leadingAnchor).isActive = true
        bioLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        bioLabel.heightAnchor.constraint(equalToConstant: 64).isActive = true
    }
}
