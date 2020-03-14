//
//  FollowerCell.swift
//  GithubApp
//
//  Created by Alex Koblik-Zelter on 3/11/20.
//  Copyright © 2020 Alex Koblik-Zelter. All rights reserved.
//

import UIKit

class FollowerCell: UICollectionViewCell {
    
    static let cellId = "FollowerID"
    var follower: Follower? {
        didSet {
            guard let follower = follower else { return }
            self.followerName.text = follower.login
            self.followerImage.setImage(urlString: follower.avatarUrl)
        }
    }
    
    private let followerImage = MyImageView(frame: .zero)
    private let followerName = CustomLabel(textAlignment: .center, fontSize: 16)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        self.addSubview(followerImage)
        self.addSubview(followerName)
        
        followerImage.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true
        followerImage.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 8).isActive = true
        followerImage.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -8).isActive = true
        followerImage.heightAnchor.constraint(equalTo: self.followerImage.widthAnchor).isActive = true
        
        followerName.topAnchor.constraint(equalTo: self.followerImage.bottomAnchor, constant: 12).isActive = true
        followerName.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 8).isActive = true
        followerName.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -8).isActive = true
        followerName.heightAnchor.constraint(equalToConstant: 20).isActive = true

    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.followerImage.image = nil
        self.followerName.text = ""
    }
}
