//
//  FavoritesCell.swift
//  GithubApp
//
//  Created by Alex Koblik-Zelter on 3/14/20.
//  Copyright © 2020 Alex Koblik-Zelter. All rights reserved.
//

import UIKit

class FavoritesCell: UITableViewCell {
    
    static let cellId = "FavoritesID"
    
    
    var follower: Follower? {
        didSet {
            guard let follower = follower else { return }
            self.favoriteName.text = follower.login
            self.favoriteImage.setImage(urlString: follower.avatarUrl)
        }
    }
        
    private let favoriteImage = MyImageView(frame: .zero)
    private let favoriteName = CustomLabel(textAlignment: .left, fontSize: 26)
        
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        self.addSubview(favoriteImage)
        self.addSubview(favoriteName)
        self.accessoryType = .disclosureIndicator
        
        favoriteImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16).isActive = true
        favoriteImage.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        favoriteImage.widthAnchor.constraint(equalToConstant: 60).isActive = true
        favoriteImage.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        favoriteName.centerYAnchor.constraint(equalTo: self.favoriteImage.centerYAnchor).isActive = true
        favoriteName.leadingAnchor.constraint(equalTo: self.favoriteImage.trailingAnchor, constant: 24).isActive = true
        favoriteName.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16).isActive = true
        favoriteName.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.favoriteImage.image = nil
        self.favoriteName.text = ""
    }
}
