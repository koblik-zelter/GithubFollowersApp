//
//  CustomAllertViewController.swift
//  GithubApp
//
//  Created by Alex Koblik-Zelter on 3/9/20.
//  Copyright © 2020 Alex Koblik-Zelter. All rights reserved.
//

import UIKit

class CustomAllertViewController: UIViewController {
    
    private let containerView = UIView()
    private let titleLabel = CustomLabel(textAlignment: .center, fontSize: 20)
    private let descriptionLabel = CustomDescriptionLabel(textAlignment: .center)
    private let actionButton = CustomButton(backgroundColor: .systemPink, title: "Ok")
    
    var alertTitle: String?
    var alertDescription: String?
    var buttonTitle: String?
    
    init(alertTitle: String?, alertDescription: String?, buttonTitle: String?) {
        super.init(nibName: nil, bundle: nil)
        self.alertTitle = alertTitle
        self.alertDescription = alertDescription
        self.buttonTitle = buttonTitle
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupViews()
    }
    
    private func setupViews() {
        self.view.backgroundColor = .init(red: 0, green: 0, blue: 0, alpha: 0.75)
        self.configureContainerView()
        self.configureTitleLabel()
        self.configureActionButton()
        self.configureDescriptionLabel()
    }
    
    private func configureContainerView() {
        self.view.addSubview(containerView)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        containerView.backgroundColor = .systemBackground
        containerView.layer.cornerRadius = 10
        containerView.layer.borderWidth = 2.0
        containerView.layer.borderColor = UIColor.white.cgColor
        containerView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        containerView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        containerView.heightAnchor.constraint(equalToConstant: 220).isActive = true
        containerView.widthAnchor.constraint(equalToConstant: 280).isActive = true
    }
    
    private func configureTitleLabel() {
        self.containerView.addSubview(titleLabel)
        titleLabel.text = self.alertTitle
        titleLabel.topAnchor.constraint(equalTo: self.containerView.topAnchor, constant: 20).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: self.containerView.leadingAnchor, constant: 20).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: self.containerView.trailingAnchor, constant: -20).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 28).isActive = true
    }
    
    private func configureActionButton() {
        self.containerView.addSubview(actionButton)
        actionButton.setTitle(self.buttonTitle, for: .normal)
        actionButton.addTarget(self, action: #selector(dismissAlert), for: .touchUpInside)
        
        actionButton.bottomAnchor.constraint(equalTo: self.containerView.bottomAnchor, constant: -20).isActive = true
        actionButton.leadingAnchor.constraint(equalTo: self.containerView.leadingAnchor, constant: 20).isActive = true
        actionButton.trailingAnchor.constraint(equalTo: self.containerView.trailingAnchor, constant: -20).isActive = true
        actionButton.heightAnchor.constraint(equalToConstant: 48).isActive = true
    }
    
    private func configureDescriptionLabel() {
        self.containerView.addSubview(descriptionLabel)
        descriptionLabel.text = self.alertDescription
        
        descriptionLabel.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 8).isActive = true
        descriptionLabel.leadingAnchor.constraint(equalTo: self.containerView.leadingAnchor, constant: 20).isActive = true
        descriptionLabel.trailingAnchor.constraint(equalTo: self.containerView.trailingAnchor, constant: -20).isActive = true
        descriptionLabel.bottomAnchor.constraint(equalTo: self.actionButton.topAnchor, constant: -8).isActive = true
    }
    @objc private func dismissAlert() {
        self.dismiss(animated: true, completion: nil)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
