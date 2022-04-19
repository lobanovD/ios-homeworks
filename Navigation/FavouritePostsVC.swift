//
//  FavouritePostsVC.swift
//  Navigation
//
//  Created by Dmitrii Lobanov on 14.03.2022.
//

import UIKit

class FavouritePostsVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        CoreDataManager.shared.getPostFromFavourite()
        view.addSubviews(favouritePostsTableView)
        setupConstraints()
        favouritePostsTableView.delegate = self
        favouritePostsTableView.dataSource = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateFavouritePosts), name: NSNotification.Name.init(rawValue: "updateFavouritePosts"), object: nil)
    }
    
    
    @objc func updateFavouritePosts() {
        CoreDataManager.shared.getPostFromFavourite()
        self.favouritePostsTableView.reloadData()
        self.favouritePostsTableView.refreshControl?.endRefreshing()
    }
    
    private lazy var favouritePostsTableView: UITableView = {
        let favouritePostsTableView = UITableView(frame: .zero, style: .grouped)
        favouritePostsTableView.toAutoLayout()
        favouritePostsTableView.register(PostTableViewCell.self, forCellReuseIdentifier: PostTableViewCell.identifire)
        favouritePostsTableView.separatorInset = .zero
        return favouritePostsTableView
    }()
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            favouritePostsTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            favouritePostsTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            favouritePostsTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            favouritePostsTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
        ])
    }
}

extension FavouritePostsVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CoreDataManager.favouritePostsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = favouritePostsTableView.dequeueReusableCell(withIdentifier: PostTableViewCell.identifire, for: indexPath) as! PostTableViewCell

        cell.configureCell(title: CoreDataManager.favouritePostsArray[indexPath.row].title,
                           image: CoreDataManager.favouritePostsArray[indexPath.row].image,
                           description: CoreDataManager.favouritePostsArray[indexPath.row].description,
                           likes: CoreDataManager.favouritePostsArray[indexPath.row].likes,
                           views: CoreDataManager.favouritePostsArray[indexPath.row].views)
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let action = UIContextualAction(style: .destructive, title: "Delete", handler: { (_, _, completionHandler) in
            completionHandler(true)
            
            CoreDataManager.shared.deletePostFromFavourite(postIndex: indexPath.row)
            
        })
        
        
     
        
        return UISwipeActionsConfiguration(actions: [action])
    }
}
