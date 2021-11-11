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

     var myCustomTF: MyCustomTextField {
        let myCustomTF = MyCustomTextField {}
        return myCustomTF
    }

    lazy private var passwordCheckButton: MyCustomButton = {
        var passwordCheckButton = MyCustomButton { [weak self] in
//            let model = MyModel()
//
//            print(1, self!.myCustomTF.passwordText)
//            guard let password = self?.passwordText else { return }

//            if model.check(word: password) {
//                print(self?.passwordText)
////                показать зеленый
//            } else {
//                print(self?.passwordText)
////                 показать красный
//            }

        }
        return passwordCheckButton
    }()

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Feed"
        self.view.addSubview(stackView)
        stackView.addArrangedSubviews(firstButton, secondButton, myCustomTF, passwordCheckButton)
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
}
