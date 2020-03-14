//
//  MainTabBarViewController.swift
//  GithubApp
//
//  Created by Alex Koblik-Zelter on 3/8/20.
//  Copyright © 2020 Alex Koblik-Zelter. All rights reserved.
//

import UIKit

class MainTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.createTabBar()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.configureNavigationBar()
    }
    
    private func createSearchViewController() -> UINavigationController {
        let vc = SearchViewController()
        vc.title = "Search"
        vc.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
        return UINavigationController(rootViewController: vc)
    }
    
    private func createFavoritesViewController() -> UINavigationController {
        let vc = FavoritesViewController()
        vc.title = "Favorites"
        vc.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
        return UINavigationController(rootViewController: vc)
    }
    
    private func createTabBar() {
        UITabBar.appearance().tintColor = .systemGreen
        self.viewControllers = [createSearchViewController(), createFavoritesViewController()]
    }
    
    
    private func configureNavigationBar() {
        UINavigationBar.appearance().tintColor = .systemGreen
    }

}
