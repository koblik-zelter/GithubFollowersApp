//
//  EmptyStateView.swift
//  GithubApp
//
//  Created by Alex Koblik-Zelter on 3/13/20.
//  Copyright © 2020 Alex Koblik-Zelter. All rights reserved.
//

import UIKit

class EmptyStateView: UIView {
    
    let logoImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "empty-state-logo")
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    let messageLabel: CustomLabel = {
        let label = CustomLabel(textAlignment: .center, fontSize: 28)
        label.textColor = .secondaryLabel
        label.numberOfLines = 3
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(message: String) {
        super.init(frame: .zero)
        self.messageLabel.text = message
        self.setupViews()
    }
    
    private func setupViews() {
        self.backgroundColor = .systemBackground
        self.addSubview(messageLabel)
        self.addSubview(logoImageView)
        
        messageLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -150).isActive = true
        messageLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 40).isActive = true
        messageLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -40).isActive = true
        messageLabel.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
        logoImageView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1.3).isActive = true
        logoImageView.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1.3).isActive = true
        logoImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 170).isActive = true
        logoImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 40).isActive = true

    }
}
