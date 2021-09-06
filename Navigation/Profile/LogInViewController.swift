//
//  LogInViewController.swift
//  Navigation
//
//  Created by Dmitrii Lobanov on 05.09.2021.
//

import UIKit

class LogInViewController: UIViewController {
    
    @objc func kbWillShow(){
        loginScrollView.contentOffset = CGPoint(x: 0, y: 50)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        view.backgroundColor = .white
        view.addSubview(loginScrollView)
        loginScrollView.addSubview(contentView)
        contentView.addSubview(VKIcon)
        contentView.addSubview(loginFormStackView)
        contentView.addSubview(loginButton)
        loginFormStackView.addArrangedSubview(loginTF)
        loginFormStackView.addArrangedSubview(passwordTF)
        setupConstraints()
        
        NotificationCenter.default.addObserver(self, selector: #selector(kbWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    
    let loginScrollView: UIScrollView = {
        var loginScrollView = UIScrollView()
        loginScrollView.translatesAutoresizingMaskIntoConstraints = false
        
        return loginScrollView
    }()
    
    let contentView: UIView = {
        var contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        return contentView
    }()
    
    let VKIcon: UIImageView = {
        var VKIcon = UIImageView()
        VKIcon.image = #imageLiteral(resourceName: "logo")
        VKIcon.translatesAutoresizingMaskIntoConstraints = false
        return VKIcon
    }()
    
    let loginFormStackView: UIStackView = {
        var loginFormStackView = UIStackView()
        loginFormStackView.translatesAutoresizingMaskIntoConstraints = false
        loginFormStackView.axis = .vertical
        loginFormStackView.layer.borderColor = UIColor.lightGray.cgColor
        loginFormStackView.layer.borderWidth = 0.5
        loginFormStackView.layer.cornerRadius = 10
        loginFormStackView.distribution = .fillProportionally
        loginFormStackView.backgroundColor = .systemGray6
        loginFormStackView.clipsToBounds = true
        return loginFormStackView
    }()
    
    let loginTF: UITextField = {
        var loginTF = UITextField()
        loginTF.translatesAutoresizingMaskIntoConstraints = false
        loginTF.leftViewMode = .always
        loginTF.placeholder = "Email or phone"
        loginTF.layer.borderColor = UIColor.lightGray.cgColor
        loginTF.layer.borderWidth = 0.25
        loginTF.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: loginTF.frame.height))
        loginTF.keyboardType = .emailAddress
        loginTF.textColor = .black
        loginTF.font = UIFont.systemFont(ofSize: 16)
        loginTF.autocapitalizationType = .none
        loginTF.returnKeyType = .done
        return loginTF
    }()
    
    
    
    let passwordTF: UITextField = {
        var passwordTF = UITextField()
        passwordTF.translatesAutoresizingMaskIntoConstraints = false
        passwordTF.leftViewMode = .always
        passwordTF.placeholder = "Password"
        passwordTF.layer.borderColor = UIColor.lightGray.cgColor
        passwordTF.layer.borderWidth = 0.25
        passwordTF.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: passwordTF.frame.height))
        passwordTF.isSecureTextEntry = true
        passwordTF.textColor = .black
        passwordTF.font = UIFont.systemFont(ofSize: 16)
        passwordTF.autocapitalizationType = .none
        passwordTF.returnKeyType = .done
        return passwordTF
    }()
    
    let loginButton: UIButton = {
        var loginButton = UIButton()
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        if let patternImage = UIImage(named: "blue_pixel") {
            loginButton.backgroundColor = UIColor(patternImage: patternImage)
        }
        return loginButton
    }()
    
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
        
            loginScrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            loginScrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            loginScrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            loginScrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: loginScrollView.topAnchor),
            contentView.trailingAnchor.constraint(equalTo: loginScrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: loginScrollView.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: loginScrollView.leadingAnchor),
            contentView.centerXAnchor.constraint(equalTo: loginScrollView.centerXAnchor),
            contentView.centerYAnchor.constraint(equalTo: loginScrollView.centerYAnchor),
            
            VKIcon.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 120),
            VKIcon.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            VKIcon.heightAnchor.constraint(equalToConstant: 100),
            VKIcon.widthAnchor.constraint(equalToConstant: 100),
            

            loginFormStackView.topAnchor.constraint(equalTo: VKIcon.bottomAnchor, constant: 120),
            loginFormStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            loginFormStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            loginFormStackView.heightAnchor.constraint(equalToConstant: 100),
            
            loginButton.topAnchor.constraint(equalTo: loginFormStackView.bottomAnchor, constant: 16),
            loginButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            loginButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
        ])

    }
    

    
    

}
