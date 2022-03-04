//
//  LoginInspector.swift
//  Navigation
//
//  Created by Dmitrii Lobanov on 25.10.2021.
//

import Foundation
import FirebaseAuth
import UIKit

class LoginInspector: LoginViewControllerDelegate {
    
    func signIn(login: String, password: String) {
        
        Auth.auth().createUser(withEmail: login, password: password) { result, error in
            
            if let error = error {
                LoginViewController.signInError = error.localizedDescription
                NotificationCenter.default.post(name: Notification.Name("signInError"), object: nil)
            } else {
                NotificationCenter.default.post(name: Notification.Name("signInSuccess"), object: nil)
            }
        }
    }
    
    
    func logIn(login: String, password: String) {
        
        Auth.auth().signIn(withEmail: login, password: password) { authResult, error in
            
            if let error = error {
                LoginViewController.logInError = error.localizedDescription
                NotificationCenter.default.post(name: Notification.Name("logInError"), object: nil)
            } else {
                NotificationCenter.default.post(name: Notification.Name("logInSuccess"), object: nil)
            }
        }
    }
}
