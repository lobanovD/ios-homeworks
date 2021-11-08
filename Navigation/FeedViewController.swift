//
//  FeedViewController.swift
//  Navigation
//
//  Created by Dmitrii Lobanov on 23.08.2021.
//

import UIKit

class FeedViewController: UIViewController {

    lazy private var firstButton: MyCustomButton = {
        var firstButton = MyCustomButton(title: "First Button", titleColor: .red) {
            let postVC = PostViewController()
            self.navigationController?.pushViewController(postVC, animated: true)
            postVC.postTitle = "First Button"
        }
        return firstButton
    }()
    
    lazy private var secondButton: MyCustomButton = {
        var secondButton = MyCustomButton(title: "Second Button", titleColor: .yellow) {
            let postVC = PostViewController()
            self.navigationController?.pushViewController(postVC, animated: true)
            postVC.postTitle = "Second Button"
        }
        return secondButton
    }()
    
    lazy private var stackView: UIStackView = {
        var stackView = UIStackView()
        stackView.toAutoLayout()
        stackView.axis = .vertical
        stackView.spacing = 10
        
        
        stackView.backgroundColor = .lightGray
        return stackView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Feed"
        self.view.addSubview(stackView)
        stackView.addArrangedSubview(firstButton)
        stackView.addArrangedSubview(secondButton)
        stackView.spacing = 10
        stackView.distribution = .fillEqually
        view.backgroundColor = .white
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            stackView.widthAnchor.constraint(equalToConstant: self.view.bounds.width / 1.1),
            stackView.heightAnchor.constraint(equalToConstant: self.view.bounds.height / 4),
        ])
    }
    
    @objc private func openPostVC() {
        let postVC = PostViewController()
        navigationController?.pushViewController(postVC, animated: true)
//                postVC.postTitle = post.title
    }
    
}


