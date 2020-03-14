//
//  ViewController.swift
//  GithubApp
//
//  Created by Alex Koblik-Zelter on 3/8/20.
//  Copyright © 2020 Alex Koblik-Zelter. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {

    private let logo: UIImageView = {
        var iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.image = UIImage(named: "gh-logo")
        return iv
    }()
    
    private let usernameTextField = CustomTextField()
    private let searchButton = CustomButton(backgroundColor: .systemGreen, title: "Get Followers")
    
    private var isUsernameEntered: Bool { return !usernameTextField.text!.isEmpty }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupViews()
        self.dismissKey()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    private func setupViews() {
        self.view.backgroundColor = .systemBackground
        self.setupLogo()
        self.setupTextField()
        self.setupSearchButton()
    }
    
    private func setupLogo() {
        self.view.addSubview(logo)
        logo.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 80).isActive = true
        logo.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        logo.heightAnchor.constraint(equalToConstant: 200).isActive = true
        logo.widthAnchor.constraint(equalToConstant: 200).isActive = true
    }

    private func setupTextField() {
        self.view.addSubview(usernameTextField)
        usernameTextField.topAnchor.constraint(equalTo: self.logo.bottomAnchor, constant: 64).isActive = true
        usernameTextField.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 48).isActive = true
        usernameTextField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -48).isActive = true
        usernameTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    private func setupSearchButton() {
        self.view.addSubview(searchButton)
        searchButton.addTarget(self, action: #selector(searchFollowers), for: .touchUpInside)
        searchButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -64).isActive = true
        searchButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 48).isActive = true
        searchButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -48).isActive = true
        searchButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    @objc private func searchFollowers() {
        guard isUsernameEntered else {
            self.showAlert(title: "Empty username", message: "Please, enter username. We need to know who to look for", action: "Cancel")
            return
        }
        self.usernameTextField.resignFirstResponder()
        let vc = FollowersListViewController()
        vc.username = self.usernameTextField.text
        self.navigationController?.pushViewController(vc, animated: true)
    }

}


extension SearchViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("tap go")
        return true
    }
}

