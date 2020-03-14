//
//  FollowersListViewController.swift
//  GithubApp
//
//  Created by Alex Koblik-Zelter on 3/11/20.
//  Copyright © 2020 Alex Koblik-Zelter. All rights reserved.
//

import UIKit

class FollowersListViewController: UIViewController {
    
    var username: String?
    private var collectionViewLayout = UICollectionViewFlowLayout()
    private var collectionView: UICollectionView!
    private var hasMoreFollowers: Bool = true
    private var followersPage = 1
    private var followers: [Follower] = []
    private var filterFollowers: [Follower] = []
    private var isSearching = false
    private var filter = ""
    
    private lazy var diffableDataSource: UICollectionViewDiffableDataSource<Section, Follower> = .init(collectionView: self.collectionView) { (collectionView, indexPath, follower) -> UICollectionViewCell? in
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FollowerCell.cellId, for: indexPath) as? FollowerCell else { return UICollectionViewCell() }
        cell.follower = follower
        return cell
    }
    
    enum Section {
        case follower
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupCollectionView()
        self.setupSearchController()
        self.getFollowers()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.navigationController?.navigationBar.prefersLargeTitles = true
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addToFavorites))
        self.navigationItem.rightBarButtonItem = addButton
        self.navigationItem.title = self.username
    }
    
    private func setupCollectionView() {
        self.view.backgroundColor = .systemBackground
        self.collectionViewLayout.scrollDirection = .vertical
        self.collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: collectionViewLayout)
        self.collectionView.translatesAutoresizingMaskIntoConstraints = false
        self.collectionView.delegate = self
        self.collectionView.dataSource = diffableDataSource
        self.view.addSubview(collectionView)
        collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.cellId)
        self.collectionView.backgroundColor = .systemBackground
        collectionView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
    }
    
    private func setupSearchController() {
        let searchController = UISearchController()
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = "Search for a username"
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
        self.navigationItem.searchController = searchController
    }
    
    private func getFollowers() {
        self.showLoadingView()
        guard let username = username else { return }
        NetworkManager.shared.getFollowers(for: username, page: self.followersPage) { [unowned self] (result) in
            self.stopAnimating()
            switch result {
                case .success(let followers):
                    if (followers.count < 100) {
                        self.hasMoreFollowers = false
                    }
                    if (followers.count == 0) {
                        DispatchQueue.main.async {
                            self.showEmptyView(with: "This user doesn't have any followers. Go follow them!", in: self.view)
                        }
                    }
                    self.followers.append(contentsOf: followers)
                    self.updateDataSource(on: self.followers)
                case .failure(let error):
                    self.showAlert(title: "Bad request", message: error.rawValue, action: "Ok")
            }
        }
    }
    
    private func updateDataSource(on followers: [Follower]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Follower>()
        snapshot.appendSections([.follower])
        snapshot.appendItems(followers)
        DispatchQueue.main.async {
            self.diffableDataSource.apply(snapshot, animatingDifferences: true)
        }
    }
    
    @objc private func addToFavorites() {
        self.showLoadingView()
        guard let username = username else { return }
        NetworkManager.shared.getUserInfo(for: username) { [unowned self] result in
            self.stopAnimating()
            
            switch result {
            case .success(let user):
                let favorite = Follower(login: user.login, avatarUrl: user.avatarUrl)
                
                PersitenceManager.updateWith(favorite: favorite, actionType: .add) { [unowned self] error in
                    guard let error = error else {
                        self.showAlert(title: "Success!", message: "You have successfully favorited this user 🎉", action: "Hooray!")
                        return
                    }
                    
                    self.showAlert(title: "Something went wrong", message: error.rawValue, action: "Ok")
                }
                
            case .failure(let error):
                self.showAlert(title: "Something went wrong", message: error.rawValue, action: "Ok")
            }
        }
    }
}

extension FollowersListViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = self.view.bounds.width
        let itemWidth = (width - 48) / 3
        return CGSize(width: itemWidth, height: itemWidth + 40)
    }
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let scrollViewHeight = scrollView.frame.size.height
        let contentViewHeight = scrollView.contentSize.height
        let offset = scrollView.contentOffset.y
        
        if offset > contentViewHeight - scrollViewHeight && !isSearching {
            guard hasMoreFollowers else { return }
            self.followersPage += 1
            self.getFollowers()
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let activeArray = isSearching ? self.filterFollowers : self.followers
        let follower = activeArray[indexPath.item]
        let vc = UserDetailsViewController()
        vc.delegate = self
        vc.userName = follower.login
        let navVC = UINavigationController(rootViewController: vc)
        self.present(navVC, animated: true)
    }
}

extension FollowersListViewController: UISearchResultsUpdating, UISearchBarDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        guard let filter = searchController.searchBar.text, !filter.isEmpty else {
            self.isSearching = false
            self.updateDataSource(on: self.followers)
            return
        }
        self.isSearching = true
        self.filter = filter
        self.filterFollowers = followers.filter { $0.login.lowercased().contains(filter.lowercased()) }
        self.updateDataSource(on: self.filterFollowers)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.updateDataSource(on: self.followers)
        self.isSearching = false
    }
}

extension FollowersListViewController: UserListDelegate {
    func updateList(for user: User) {
        self.username = user.login
        self.navigationItem.title = self.username
        self.isSearching = false
        self.followersPage = 1
        self.followers.removeAll()
        self.filterFollowers.removeAll()
        self.collectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .centeredVertically, animated: true)
        self.getFollowers()
    }
}
