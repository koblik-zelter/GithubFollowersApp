//
//  CustomTextField.swift
//  GithubApp
//
//  Created by Alex Koblik-Zelter on 3/8/20.
//  Copyright © 2020 Alex Koblik-Zelter. All rights reserved.
//

import UIKit

class CustomTextField: UITextField {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(placeHolder: String) {
        self.init(frame: .zero)
        self.placeholder = placeholder
    }
    
    private func configure() {
        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.layer.cornerRadius = 10
        self.layer.borderWidth = 2.0
        self.layer.borderColor = UIColor.systemGray4.cgColor
        
        self.textColor = .label
        self.tintColor = .label
        self.font = UIFont.preferredFont(forTextStyle: .title2)
        self.adjustsFontSizeToFitWidth = true
        self.textAlignment = .center
        self.minimumFontSize = 12
        self.returnKeyType = .go
        self.backgroundColor = .tertiarySystemBackground
        self.autocorrectionType = .no
        self.clearButtonMode = .whileEditing
        self.placeholder = "Enter a username"
    }
}
