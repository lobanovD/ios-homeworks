//
//  FeedViewController.swift
//  Navigation
//
//  Created by Dmitrii Lobanov on 23.08.2021.
//

import UIKit

class FeedViewController: UIViewController {
    
    //    let post = Post(title: "Post")
    
    lazy private var firstButton: MyCustomButton = {
        var firstButton = MyCustomButton(title: "234", titleColor: .black)
        firstButton.buttonTapped()
        
        firstButton.toAutoLayout()
        firstButton.backgroundColor = UIColor.rgb(2, 122, 255, 1)
        firstButton.layer.shadowColor = UIColor.black.cgColor
        firstButton.layer.shadowOffset = CGSize(width: 4, height: 4)
        firstButton.layer.shadowOpacity = 0.7
        firstButton.layer.shadowRadius = 4
        firstButton.setTitle("First Button", for: .normal)
        firstButton.setTitleColor(.lightGray, for: .highlighted)
        //firstButton.addTarget(self, action: #selector(openPostVC), for: .touchUpInside)
        return firstButton
    }()
    
    lazy private var secondButton: UIButton = {
        var secondButton = UIButton()
        secondButton.toAutoLayout()
        secondButton.backgroundColor = UIColor.rgb(2, 122, 255, 1)
        secondButton.layer.shadowColor = UIColor.black.cgColor
        secondButton.layer.shadowOffset = CGSize(width: 4, height: 4)
        secondButton.layer.shadowOpacity = 0.7
        secondButton.layer.shadowRadius = 4
        secondButton.setTitle("Second Button", for: .normal)
        secondButton.setTitleColor(.lightGray, for: .highlighted)
        secondButton.addTarget(self, action: #selector(openPostVC), for: .touchUpInside)
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
        //        postVC.postTitle = post.title
    }
    
}


