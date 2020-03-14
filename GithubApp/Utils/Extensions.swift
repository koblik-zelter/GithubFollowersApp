//
//  Extensions.swift
//  GithubApp
//
//  Created by Alex Koblik-Zelter on 3/9/20.
//  Copyright © 2020 Alex Koblik-Zelter. All rights reserved.
//

import Foundation
import UIKit

fileprivate var containerView: UIView!

extension UIViewController {
    func dismissKey()
    {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer( target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard()
    {
        view.endEditing(true)
    }
    
    func showAlert(title: String, message: String, action: String) {
        DispatchQueue.main.async {
            let vc = CustomAllertViewController(alertTitle: title, alertDescription: message, buttonTitle: action)
            vc.modalPresentationStyle = .overFullScreen
            vc.modalTransitionStyle = .crossDissolve
            self.present(vc, animated: true, completion: nil)
        }
    }
    
    func showLoadingView() {
        containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(containerView)
        containerView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        containerView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        containerView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        containerView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        containerView.backgroundColor = .systemBackground
        containerView.alpha = 0
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(activityIndicator)
        UIView.animate(withDuration: 0.25) {
            containerView.alpha = 0.8
        }
        activityIndicator.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
        activityIndicator.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        activityIndicator.startAnimating()
    }
    
    func stopAnimating() {
        DispatchQueue.main.async {
            containerView.removeFromSuperview()
            containerView = nil
        }
    }
    
    func showEmptyView(with message: String, in view: UIView) {
        let emptyView = EmptyStateView(message: message)
        emptyView.frame = view.bounds
        view.addSubview(emptyView)
    }
    
    func addChildVC(_ viewController: UIViewController, at view: UIView) {
        self.addChild(viewController)
        view.addSubview(viewController.view)
        viewController.view.frame = view.bounds
        viewController.didMove(toParent: self)
    }
}


extension UITableView {
    func removeEmptyRows() {
        self.tableFooterView = UIView(frame: .zero)
    }
}

extension UIView {
    func pinViewTo(_ view: UIView) {
        topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
}
