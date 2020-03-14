//
//  FavoritesViewController.swift
//  GithubApp
//
//  Created by Alex Koblik-Zelter on 3/8/20.
//  Copyright © 2020 Alex Koblik-Zelter. All rights reserved.
//

import UIKit

class FavoritesViewController: UIViewController {
    
    var favorites: [Follower] = []
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.title = "Favorites"
        self.getFavorites()
    }
    
    private func setupViews() {
        self.view.backgroundColor = .systemBackground
        self.view.addSubview(tableView)
        self.tableView.removeEmptyRows()
        tableView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(FavoritesCell.self, forCellReuseIdentifier: FavoritesCell.cellId)
    }
    
    private func getFavorites() {
        PersitenceManager.retrieveFavorites { (result) in
            switch result {
            case .success(let favorites):
                if (favorites.isEmpty) {
                    self.showEmptyView(with: "No Favorites\n Add one on the follower screen?", in: self.view)
                    return
                }
                self.favorites.removeAll()
                self.favorites.append(contentsOf: favorites)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    self.view.bringSubviewToFront(self.tableView)
                }
            case .failure(let error):
                self.showAlert(title: "Something went wrong", message: error.localizedDescription, action: "Ok")
            }
        }
    }
}

extension FavoritesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FavoritesCell.cellId, for: indexPath) as? FavoritesCell else { return UITableViewCell() }
        cell.follower = favorites[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favorites.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let user = favorites[indexPath.row]
        let vc = FollowersListViewController()
        vc.username = user.login
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }
        let favorite = self.favorites[indexPath.row]
        PersitenceManager.updateWith(favorite: favorite, actionType: .remove) { [unowned self] (error) in
            guard let error = error else {
                self.favorites.remove(at: indexPath.row)
                self.tableView.deleteRows(at: [indexPath], with: .left)
                if (self.favorites.isEmpty) {
                    UIView.animate(withDuration: 0.25) {
                        self.showEmptyView(with: "No Favorites\n Add one on the follower screen?", in: self.view)
                    }
                }
                return
            }
            self.showAlert(title: "Unable to remove", message: error.localizedDescription, action: "Ok")
        }
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}
