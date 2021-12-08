//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Dmitrii Lobanov on 23.08.2021.
//

import UIKit
import StorageService

class ProfileViewController: UIViewController {

    var login: String?

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white

        view.addSubview(ProfileViewController.postTableView)
        setupConstraints()
        ProfileViewController.postTableView.dataSource = self
        ProfileViewController.postTableView.delegate = self
        ProfileViewController.postTableView.refreshControl = UIRefreshControl()
        ProfileViewController.postTableView.refreshControl?.addTarget(self, action: #selector(updatePostArray), for: .valueChanged)
        timer()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
    }
    
    // MARK: UI elements
    
    /// Post table view
    static var postTableView: UITableView = {
        let postTableView = UITableView(frame: .zero, style: .grouped)
        postTableView.toAutoLayout()
        postTableView.register(PostTableViewCell.self, forCellReuseIdentifier: PostTableViewCell.identifire)
        postTableView.register(ProfileHeaderView.self, forHeaderFooterViewReuseIdentifier: ProfileHeaderView.identifire)
        postTableView.register(PhotoTableViewCell.self, forCellReuseIdentifier: PhotoTableViewCell.identifire)
        postTableView.separatorInset = .zero
        return postTableView
    }()
}

// MARK: Delegate and Datasource
extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 1 {
            return postArray.count
        } else {
            return 1
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 1 {
            let cell = ProfileViewController.postTableView.dequeueReusableCell(withIdentifier: PostTableViewCell.identifire, for: indexPath) as! PostTableViewCell

            cell.configureCell(title: postArray[indexPath.row].title,
                               image: postArray[indexPath.row].image,
                               description: postArray[indexPath.row].description,
                               likes: postArray[indexPath.row].likes,
                               views: postArray[indexPath.row].views)
            return cell
        } else {
            let cell = ProfileViewController.postTableView.dequeueReusableCell(withIdentifier: PhotoTableViewCell.identifire, for: indexPath) as! PhotoTableViewCell
            let gesture = UITapGestureRecognizer(target: self, action: #selector(arrowButtonAction))
            PhotoTableViewCell.arrowButton.addGestureRecognizer(gesture)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            let photoVC = PhotoViewController()
            navigationController?.pushViewController(photoVC, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: ProfileHeaderView.identifire) as! ProfileHeaderView
            
            return headerView
            
        } else {
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 220
        } else {
            return 0
        }
    }
}


// MARK: Actions
extension ProfileViewController {
    /// Update data
    @objc func updatePostArray() {
        print("Количество постов в ленте до обновления данных - \(postArray.count)")
        postArray.append(post1)
        print("Количество постов в ленте после обновления данных - \(postArray.count)")
        ProfileViewController.postTableView.reloadData()
        ProfileViewController.postTableView.refreshControl?.endRefreshing()
        print("данные успешно обновлены")
    }


    /// Setup constraints
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            ProfileViewController.postTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            ProfileViewController.postTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            ProfileViewController.postTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            ProfileViewController.postTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
        ])
    }
    
    /// Arrow Button Action
    @objc private func arrowButtonAction() {
        let photoVC = PhotoViewController()
        self.navigationController?.pushViewController(photoVC, animated: true)
    }

    // метод таймера
    private func timer() {
        var timerData = 20
        ProfileHeaderView.timerLabel.text = "\(timerData)"

        DispatchQueue.global().async {
            let timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
                timerData -= 1
                DispatchQueue.main.async {
                    ProfileHeaderView.timerLabel.text = "\(timerData)"
                }
                if timerData == -1 {
                    timerData = 20
                    DispatchQueue.main.async {
                        ProfileHeaderView.timerLabel.text = "\(timerData)"
                    }
                    print("обновление данных")
                    DispatchQueue.main.async {
                        self.updatePostArray()
                    }
                }
            }
            RunLoop.current.add(timer, forMode: .common)
            RunLoop.current.run()
        }
    }
}
