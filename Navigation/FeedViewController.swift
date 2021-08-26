//
//  FeedViewController.swift
//  Navigation
//
//  Created by Dmitrii Lobanov on 23.08.2021.
//

import UIKit

class FeedViewController: UIViewController {
    
    
    let post = Post(title: "First post")

    var postButton = UIButton()
   
    // метод для кнопки
   @objc func openPost() {
        let postVC = PostViewController()
        navigationController?.pushViewController(postVC, animated: true)
    postVC.postTitle = post.title
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        self.title = "Feed"
        
        postButton = UIButton(frame: CGRect(x: view.frame.width/2-100, y: view.frame.height/2-25, width: 200, height: 50))
        postButton.layer.cornerRadius = 25
        postButton.backgroundColor = .green
        postButton.setTitle("Post", for: .normal)
        
        postButton.addTarget(self, action: #selector(openPost), for: .touchUpInside)

        view.addSubview(postButton)
        
    }
}
