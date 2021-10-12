//
//  LogInViewController.swift
//  Navigation
//
//  Created by Dmitrii Lobanov on 05.09.2021.
//

import UIKit

class LogInViewController: UIViewController, UITextFieldDelegate {
    
    var isLogin: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loginTF.delegate = self
        self.passwordTF.delegate = self
        navigationController?.navigationBar.isHidden = true
        setupViews()
        
        /// скрытие клавиатуры по нажатию вне TF
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tap))
        self.view.addGestureRecognizer(tapGesture)
        
    }
    
    // MARK: Setup View
    private func setupViews() {
        view.backgroundColor = .white
        view.addSubview(loginScrollView)
        loginScrollView.addSubview(contentView)
        contentView.addSubviews(VKIcon, loginFormStackView, loginButton)
        loginFormStackView.addArrangedSubview(loginTF)
        loginFormStackView.addArrangedSubview(passwordTF)
        setupConstraints()
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    // MARK: UI elements
    /// Login Scroll View
    private lazy var loginScrollView: UIScrollView = {
        let loginScrollView = UIScrollView()
        loginScrollView.toAutoLayout()
        return loginScrollView
    }()
    
    /// Content View
    private lazy var contentView: UIView = {
        let contentView = UIView()
        contentView.toAutoLayout()
        return contentView
    }()
    
    /// VK icon
    private lazy var VKIcon: UIImageView = {
        let VKIcon = UIImageView()
        VKIcon.image = UIImage(named: "logo")
        VKIcon.toAutoLayout()
        return VKIcon
    }()
    
    /// Login form stack view
    private lazy var loginFormStackView: UIStackView = {
        let loginFormStackView = UIStackView()
        loginFormStackView.toAutoLayout()
        loginFormStackView.axis = .vertical
        loginFormStackView.layer.borderColor = UIColor.lightGray.cgColor
        loginFormStackView.layer.borderWidth = 0.5
        loginFormStackView.layer.cornerRadius = 10
        loginFormStackView.distribution = .fillProportionally
        loginFormStackView.backgroundColor = .systemGray6
        loginFormStackView.clipsToBounds = true
        return loginFormStackView
    }()
    
    /// Login Text field
    private lazy var loginTF: UITextField = {
        let loginTF = UITextField()
        loginTF.toAutoLayout()
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
    
    /// Password text field
    private lazy var passwordTF: UITextField = {
        let passwordTF = UITextField()
        passwordTF.toAutoLayout()
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
    
    /// Login button
    private lazy var loginButton: UIButton = {
        let loginButton = UIButton()
        loginButton.toAutoLayout()
        if let image = UIImage(named: "blue_pixel") {
            loginButton.setBackgroundImage(image.image(alpha: 1), for: .normal)
            loginButton.setBackgroundImage(image.image(alpha: 0.8), for: .selected)
            loginButton.setBackgroundImage(image.image(alpha: 0.8), for: .highlighted)
            loginButton.setBackgroundImage(image.image(alpha: 0.8), for: .disabled)
        }
        loginButton.setTitle("Log In", for: .normal)
        loginButton.setTitleColor(.white, for: .normal)
        loginButton.addTarget(self, action: #selector(loginButtonPressed), for: .touchUpInside)
        loginButton.layer.cornerRadius = 10
        loginButton.clipsToBounds = true
        return loginButton
        
    }()
}


// MARK: Actions
extension LogInViewController {
    
    /// Setup constraints
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            
            loginScrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            loginScrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            loginScrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            loginScrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: loginScrollView.topAnchor),
            contentView.trailingAnchor.constraint(equalTo: loginScrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: loginScrollView.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: loginScrollView.leadingAnchor),
            contentView.centerXAnchor.constraint(equalTo: loginScrollView.centerXAnchor),
            contentView.centerYAnchor.constraint(equalTo: loginScrollView.centerYAnchor),
            
            VKIcon.topAnchor.constraint(equalTo: contentView.topAnchor, constant: LoginVCConstants.vkIconTop),
            VKIcon.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            VKIcon.heightAnchor.constraint(equalToConstant: LoginVCConstants.vkIconHeight),
            VKIcon.widthAnchor.constraint(equalToConstant: LoginVCConstants.vkIconWidth),
            
            loginFormStackView.topAnchor.constraint(equalTo: VKIcon.bottomAnchor, constant: LoginVCConstants.loginFormStackViewTop),
            loginFormStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: LoginVCConstants.loginFormStackViewLeading),
            loginFormStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: LoginVCConstants.loginFormStackViewTrailing),
            loginFormStackView.heightAnchor.constraint(equalToConstant: LoginVCConstants.loginFormStackViewHeight),
            
            loginButton.topAnchor.constraint(equalTo: loginFormStackView.bottomAnchor, constant: LoginVCConstants.loginButtonTop),
            loginButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: LoginVCConstants.loginButtonLeading),
            loginButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: LoginVCConstants.loginButtonTrailing),
            loginButton.heightAnchor.constraint(equalToConstant: LoginVCConstants.loginButtonHeight),
        ])
    }
    
    /// Keyboard actions
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        loginTF.resignFirstResponder()
        passwordTF.resignFirstResponder()
        return true;
    }
    
    @objc func tap() {
        passwordTF.resignFirstResponder()
        loginTF.resignFirstResponder()
    }
    
    @objc func keyboardShow(_ notification: Notification){
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            loginScrollView.contentOffset.y = keyboardRectangle.height - (loginScrollView.frame.height - loginButton.frame.minY) + LoginVCConstants.indent
        }
    }
    
    @objc func keyboardHide(_ notification: Notification){
        loginScrollView.contentOffset = CGPoint(x: 0, y: 0)
    }
    
    /// Login button action
    @objc private func loginButtonPressed() {
        isLogin = true
        if let image = UIImage(named: "blue_pixel") {
            loginButton.setBackgroundImage(image.image(alpha: 0.8), for: .normal)
            DispatchQueue.main.asyncAfter(deadline: .now()+0.1) {
                self.loginButton.setBackgroundImage(image.image(alpha: 1), for: .normal)
            }
        }
        
        let profileVC = ProfileViewController()
        navigationController?.pushViewController(profileVC, animated: false)
        
        if isLogin {
            navigationController?.setViewControllers([profileVC], animated: true)
        }
    }   
}





