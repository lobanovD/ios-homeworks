//
//  FeedViewController.swift
//  Navigation
//
//  Created by Dmitrii Lobanov on 23.08.2021.
//

import UIKit

class FeedViewController: UIViewController {
    
    var passwordText: String = ""
    
    lazy private var firstButton: CustomButton = {
        var firstButton = CustomButton(title: "First Button", titleColor: .red) {
            let postVC = PostViewController()
            self.navigationController?.pushViewController(postVC, animated: true)
            postVC.postTitle = "First Button"
        }
        return firstButton
    }()
    
    lazy private var secondButton: CustomButton = {
        var secondButton = CustomButton(title: "Second Button", titleColor: .yellow) {
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
    
    var myCustomTF: MyCustomTextField = {
        let myCustomTF = MyCustomTextField {}
        return myCustomTF
    }()
    
    lazy private var passwordCheckButton: MyCustomButton = {
        var passwordCheckButton = MyCustomButton {}
        return passwordCheckButton
    }()
    
    lazy var stateLabel: UILabel = {
        let stateLabel = UILabel()
        stateLabel.isHidden = true
        return stateLabel
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Feed"
        self.view.addSubview(stackView)
        stackView.addArrangedSubviews(firstButton, secondButton, myCustomTF, passwordCheckButton, stateLabel)
        stackView.spacing = 10
        stackView.distribution = .fillEqually
        view.backgroundColor = .white
        setupConstraints()
        let nc = NotificationCenter.default
        nc.addObserver(self, selector: #selector(passwordIsRight), name: Notification.Name("passwordIsRight"), object: nil)
        nc.addObserver(self, selector: #selector(passwordIsNotRight), name: Notification.Name("passwordIsNotRight"), object: nil)

    }

    @objc
    private func passwordIsRight() {
        stateLabel.text = "Пароль верный"
        stateLabel.textColor = .green
        stateLabel.isHidden = false
    }

    @objc
    private func passwordIsNotRight() {
        stateLabel.text = "Пароль неверный"
        stateLabel.textColor = .red
        stateLabel.isHidden = false
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            stackView.widthAnchor.constraint(equalToConstant: self.view.bounds.width / 1.1),
            stackView.heightAnchor.constraint(equalToConstant: self.view.bounds.height / 4),
        ])
    }
}
