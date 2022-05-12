//
//  LoginViewController.swift
//  Navigation
//
//  Created by Dmitrii Lobanov on 05.09.2021.
//

import UIKit
import FirebaseAuth
import RealmSwift

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    var isLogin: Bool = false
    
    var delegate: LoginViewControllerDelegate?
    
    static var signInError: String?
    static var logInError: String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.loginTF.delegate = self
        self.passwordTF.delegate = self
        navigationController?.navigationBar.isHidden = true
        setupViews()
        
        // скрытие клавиатуры по нажатию вне TF
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tap))
        self.view.addGestureRecognizer(tapGesture)
        

        addNotification()
        
        // проверка состояния логина при запуске
        isLogin = UserDefaults.standard.bool(forKey: "isLogin")
        if isLogin {
            NotificationCenter.default.post(name: Notification.Name("logInSuccess"), object: nil)
        }
    }
    
    @objc func logInError() {
        if let logInError = LoginViewController.logInError {
            let alertVC = UIAlertController(title: "Error", message: "\(String(describing: logInError))", preferredStyle: .alert)
            let action = UIAlertAction(title: "ОК", style: .default, handler: nil)
            alertVC.addAction(action)
            self.present(alertVC, animated: true, completion: nil)
        }
    }
    
    private func addNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.signInError), name: Notification.Name("signInError"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.signInSuccess), name: Notification.Name("signInSuccess"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.logInError), name: Notification.Name("logInError"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.logInSuccess), name: Notification.Name("logInSuccess"), object: nil)
        
        // Notification for Realm
        NotificationCenter.default.addObserver(self, selector: #selector(self.userExists), name: Notification.Name("userExists"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.userNotExists), name: Notification.Name("userNotExists"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.passwordIsWrong), name: Notification.Name("passwordIsWrong"), object: nil)
    }
    
    @objc func logInSuccess() {
        let profileVC = ProfileViewController()
        self.navigationController?.pushViewController(profileVC, animated: false)
        let loginVC = LoginViewController()
        loginVC.dismiss(animated: true)
        let feedVC = FeedViewController()
        
        let loginVCTabbarTitle = "login_vc_tabbar_title".localized(file: "Localizable_TabBar")
        let feedVCTabbarTitle = "feed_vc_tabbar_title".localized(file: "Localizable_TabBar")
        loginVC.tabBarItem = UITabBarItem(title: loginVCTabbarTitle, image: UIImage(systemName: "person.crop.circle"), tag: 0)
        profileVC.tabBarItem = UITabBarItem(title: loginVCTabbarTitle, image: UIImage(systemName: "person.crop.circle"), tag: 0)
        let feedNavigationVC = UINavigationController(rootViewController: feedVC)
        feedNavigationVC.tabBarItem = UITabBarItem(title: feedVCTabbarTitle, image: UIImage(systemName: "note.text"), tag: 0)
        var currentVC: UIViewController {
            if UserDefaults.standard.bool(forKey: "isLogin") {
                return profileVC
            } else {
                return loginVC
            }
        }
        let profileNavigationVC = UINavigationController(rootViewController: currentVC)
        self.tabBarController?.viewControllers = [profileNavigationVC, feedNavigationVC]
    }
    
    @objc func signInError() {
        if let signInError = LoginViewController.signInError {
            let alertVC = UIAlertController(title: "Ошибка", message: "\(String(describing: signInError))", preferredStyle: .alert)
            let action = UIAlertAction(title: "ОК", style: .default, handler: nil)
            alertVC.addAction(action)
            self.present(alertVC, animated: true, completion: nil)
        }
    }
    
    @objc func signInSuccess() {
        let signInSuccesTitle = "sign_in_succes_allert_title".localized(file: "Localizable_LoginVC")
        let signInSuccesMessage = "sign_in_succes_allert_message".localized(file: "Localizable_LoginVC")
        let signInSuccesResult = "sign_in_succes_allert_result".localized(file: "Localizable_LoginVC")
        let alertVC = UIAlertController(title: signInSuccesTitle, message: signInSuccesMessage, preferredStyle: .alert)
        let action = UIAlertAction(title: signInSuccesResult, style: .default, handler: nil)
        alertVC.addAction(action)
        self.present(alertVC, animated: true, completion: nil)
        self.loginTF.text?.removeAll()
        self.passwordTF.text?.removeAll()
    }
    
    @objc func userExists() {
        let userExistAlertTitle = "user_exist_allert_title".localized(file: "Localizable_LoginVC")
        let userExistAlertMessage = "user_exist_allert_message".localized(file: "Localizable_LoginVC")
        let userExistAlertResult = "user_exist_allert_result".localized(file: "Localizable_LoginVC")
        let alertVC = UIAlertController(title: userExistAlertTitle, message: userExistAlertMessage, preferredStyle: .alert)
        let action = UIAlertAction(title: userExistAlertResult, style: .default, handler: nil)
        alertVC.addAction(action)
        self.present(alertVC, animated: true, completion: nil)
    }
    
    @objc func userNotExists() {
        let userNotExistAlertTitle = "user_not_exist_allert_title".localized(file: "Localizable_LoginVC")
        let userNotExistAlertMessage = "user_not_exist_allert_message".localized(file: "Localizable_LoginVC")
        let userNotExistAlertResult = "user_not_exist_allert_result".localized(file: "Localizable_LoginVC")
        let alertVC = UIAlertController(title: userNotExistAlertTitle, message: userNotExistAlertMessage, preferredStyle: .alert)
        let action = UIAlertAction(title: userNotExistAlertResult, style: .default, handler: nil)
        alertVC.addAction(action)
        self.present(alertVC, animated: true, completion: nil)
    }
    
    @objc func passwordIsWrong() {
        let passwordIsWrongAlertTitle = "password_is_wrong_allert_title".localized(file: "Localizable_LoginVC")
        let passwordIsWrongAlertMessage = "password_is_wrong_allert_message".localized(file: "Localizable_LoginVC")
        let passwordIsWrongAlertResult = "password_is_wrong_allert_result".localized(file: "Localizable_LoginVC")
        let alertVC = UIAlertController(title: passwordIsWrongAlertTitle, message: passwordIsWrongAlertMessage, preferredStyle: .alert)
        let action = UIAlertAction(title: passwordIsWrongAlertResult, style: .default, handler: nil)
        alertVC.addAction(action)
        self.present(alertVC, animated: true, completion: nil)
    }
    
    
    
    // MARK: Setup View
    private func setupViews() {
        // view.backgroundColor = UIColor.createColor(lightMode: .white, darkMode: .blue)
        loginScrollView.backgroundColor = ColorPallete.backgroundColor
        view.addSubview(loginScrollView)
        loginScrollView.addSubview(contentView)
        contentView.addSubviews(VKIcon, loginFormStackView, loginButton, signInButton) //, brutPasswordButton, activityIndicator)
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
    // Login Scroll View
    private lazy var loginScrollView: UIScrollView = {
        let loginScrollView = UIScrollView()
        loginScrollView.toAutoLayout()
        return loginScrollView
    }()
    
    // Content View
    private lazy var contentView: UIView = {
        let contentView = UIView()
        contentView.toAutoLayout()
        return contentView
    }()
    
    // VK icon
    private lazy var VKIcon: UIImageView = {
        let VKIcon = UIImageView()
        VKIcon.image = UIImage(named: "logo")
        VKIcon.toAutoLayout()
        return VKIcon
    }()
    
    // Login form stack view
    private lazy var loginFormStackView: UIStackView = {
        let loginFormStackView = UIStackView()
        loginFormStackView.toAutoLayout()
        loginFormStackView.axis = .vertical
        loginFormStackView.layer.borderColor = UIColor.lightGray.cgColor
        loginFormStackView.layer.borderWidth = 0.5
        loginFormStackView.layer.cornerRadius = 10
        loginFormStackView.distribution = .fillProportionally
        loginFormStackView.backgroundColor = ColorPallete.textFieldBackground
        loginFormStackView.clipsToBounds = true
        return loginFormStackView
    }()
    
    // Login Text field
    private lazy var loginTF: UITextField = {
        let loginTF = UITextField()
        loginTF.toAutoLayout()
        loginTF.leftViewMode = .always
        let placeholder = "email_placeholder".localized(file: "Localizable_LoginVC")
        loginTF.placeholder = placeholder
        loginTF.layer.borderColor = UIColor.lightGray.cgColor
        loginTF.layer.borderWidth = 0.25
        loginTF.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: loginTF.frame.height))
        loginTF.keyboardType = .emailAddress
        loginTF.textColor = ColorPallete.TFText
        loginTF.font = UIFont.systemFont(ofSize: 16)
        loginTF.autocapitalizationType = .none
        loginTF.returnKeyType = .done
        loginTF.tintColor = ColorPallete.TFCursor
        return loginTF
    }()
    
    // Password text field
    private lazy var passwordTF: UITextField = {
        let passwordTF = UITextField()
        passwordTF.toAutoLayout()
        passwordTF.leftViewMode = .always
        let placeholder = "password_placeholder".localized(file: "Localizable_LoginVC")
        passwordTF.placeholder = placeholder
        passwordTF.layer.borderColor = UIColor.lightGray.cgColor
        passwordTF.layer.borderWidth = 0.25
        passwordTF.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: passwordTF.frame.height))
        passwordTF.isSecureTextEntry = true
        passwordTF.textColor = ColorPallete.TFText
        passwordTF.font = UIFont.systemFont(ofSize: 16)
        passwordTF.autocapitalizationType = .none
        passwordTF.returnKeyType = .done
        passwordTF.tintColor = ColorPallete.TFCursor
        return passwordTF
    }()
    
    // Login button
    private lazy var loginButton: UIButton = {
        let loginButton = UIButton()
        loginButton.toAutoLayout()
//        if let image = UIImage(named: "blue_pixel") {
//            loginButton.setBackgroundImage(image.image(alpha: 1), for: .normal)
//            loginButton.setBackgroundImage(image.image(alpha: 0.1), for: .selected)
//            loginButton.setBackgroundImage(image.image(alpha: 0.1), for: .highlighted)
//            loginButton.setBackgroundImage(image.image(alpha: 0.1), for: .disabled)
//            loginButton.setBackgroundImage(image.image(alpha: 0.1), for: .reserved)
//            loginButton.setBackgroundImage(image.image(alpha: 0.1), for: .focused)
//            loginButton.setBackgroundImage(image.image(alpha: 0.1), for: .application)
//        }
        loginButton.backgroundColor = ColorPallete.button
        let title = "log_in".localized(file: "Localizable_LoginVC")
        loginButton.setTitle(title, for: .normal)
        loginButton.setTitleColor(.white, for: .normal)
        loginButton.addTarget(self, action: #selector(loginButtonPressed), for: .touchUpInside)
        loginButton.layer.cornerRadius = 10
        loginButton.clipsToBounds = true
        return loginButton
    }()
    
    // Login button
    private lazy var signInButton: UIButton = {
        let signInButton = UIButton()
        signInButton.toAutoLayout()
//        if let image = UIImage(named: "blue_pixel") {
//            signInButton.setBackgroundImage(image.image(alpha: 1), for: .normal)
//            signInButton.setBackgroundImage(image.image(alpha: 0.1), for: .selected)
//            signInButton.setBackgroundImage(image.image(alpha: 0.1), for: .highlighted)
//            signInButton.setBackgroundImage(image.image(alpha: 0.1), for: .disabled)
//            signInButton.setBackgroundImage(image.image(alpha: 0.1), for: .reserved)
//            signInButton.setBackgroundImage(image.image(alpha: 0.1), for: .focused)
//            signInButton.setBackgroundImage(image.image(alpha: 0.1), for: .application)
//
//        }
        signInButton.backgroundColor = ColorPallete.button
        let title = "sign_in".localized(file: "Localizable_LoginVC")
        signInButton.setTitle(title, for: .normal)
        signInButton.setTitleColor(.white, for: .normal)
        signInButton.addTarget(self, action: #selector(signInButtonPressed), for: .touchUpInside)
        signInButton.layer.cornerRadius = 10
        signInButton.clipsToBounds = true
        return signInButton
    }()
}


// MARK: Actions
extension LoginViewController {
    
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
            
            signInButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: LoginVCConstants.loginButtonTop),
            signInButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: LoginVCConstants.loginButtonLeading),
            signInButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: LoginVCConstants.loginButtonTrailing),
            signInButton.heightAnchor.constraint(equalToConstant: LoginVCConstants.loginButtonHeight),
            
        ])
    }
    
    // Keyboard actions
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
    
    // Login button action
    @objc private func loginButtonPressed() {
        
        //        if let image = UIImage(named: "blue_pixel") {
        //            loginButton.setBackgroundImage(image.image(alpha: 0.8), for: .normal)
        //            DispatchQueue.main.asyncAfter(deadline: .now()+0.1) {
        //                self.loginButton.setBackgroundImage(image.image(alpha: 1), for: .normal)
        //            }
        //        }
        
        // проверка на заполнение полей
        guard loginTF.text?.isEmpty == false else {
            let alertTitle = "no_login_error_title".localized(file: "Localizable_LoginVC")
            let alertMessage = "no_login_error_message".localized(file: "Localizable_LoginVC")
            let alertButtonText = "no_login_error_button_text".localized(file: "Localizable_LoginVC")
            let alertVC = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
            let action = UIAlertAction(title: alertButtonText, style: .default, handler: nil)
            alertVC.addAction(action)
            self.present(alertVC, animated: true, completion: nil)
            return }
        
        guard passwordTF.text?.isEmpty == false else {
            let alertTitle = "no_password_error_title".localized(file: "Localizable_LoginVC")
            let alertMessage = "no_password_error_message".localized(file: "Localizable_LoginVC")
            let alertButtonText = "no_password_error_button_text".localized(file: "Localizable_LoginVC")
            let alertVC = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
            let action = UIAlertAction(title: alertButtonText, style: .default, handler: nil)
            alertVC.addAction(action)
            self.present(alertVC, animated: true, completion: nil)
            return }
        
        guard let login = loginTF.text else { return }
        guard let password = passwordTF.text else { return }
        guard let delegate = delegate else { return }
        
        delegate.logIn(login: login, password: password)
    }
    
    // Sign in button action
    @objc private func signInButtonPressed() {
        
        // проверка на заполнение полей
        let checkEmptyFieldTitle = "check_empty_field_title".localized(file: "Localizable_LoginVC")
        let checkEmptyFieldLoginMessage = "check_empty_field_login_message".localized(file: "Localizable_LoginVC")
        let checkEmptyFieldPasswordMessage = "check_empty_field_password_message".localized(file: "Localizable_LoginVC")
        let checkEmptyFieldResult = "check_empty_field_result".localized(file: "Localizable_LoginVC")
        guard loginTF.text?.isEmpty == false else {
            let alertVC = UIAlertController(title: checkEmptyFieldTitle, message: checkEmptyFieldLoginMessage, preferredStyle: .alert)
            let action = UIAlertAction(title: checkEmptyFieldResult, style: .default, handler: nil)
            alertVC.addAction(action)
            self.present(alertVC, animated: true, completion: nil)
            return }
        
        guard passwordTF.text?.isEmpty == false else {
            let alertVC = UIAlertController(title: checkEmptyFieldTitle, message: checkEmptyFieldPasswordMessage, preferredStyle: .alert)
            let action = UIAlertAction(title: checkEmptyFieldResult, style: .default, handler: nil)
            alertVC.addAction(action)
            self.present(alertVC, animated: true, completion: nil)
            return }
        
        guard let login = loginTF.text else { return }
        guard let password = passwordTF.text else { return }
        guard let delegate = delegate else { return }
        
        delegate.signIn(login: login, password: password)
        
    }
}
