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
    
    
    func signIn(login: String, password: String, vc: UIViewController) -> Void {
        Auth.auth().createUser(withEmail: login, password: password) { result, error in
            // обработка ошибок
            
            
            if let error = error {
                let alertVC = UIAlertController(title: "Ошибка", message: "\(error.localizedDescription)", preferredStyle: .alert)
                let action = UIAlertAction(title: "ОК", style: .default, handler: nil)
                alertVC.addAction(action)
                
                vc.present(alertVC, animated: true, completion: nil)
            } else {
                let alertVC = UIAlertController(title: "Поздравляем!", message: "аккаунт успешно зарегистрирован", preferredStyle: .alert)
                let action = UIAlertAction(title: "ОК", style: .default, handler: nil)
                alertVC.addAction(action)

                vc.present(alertVC, animated: true, completion: nil)
            }
        }
    }
    
    func logIn(login: String, password: String, vc: UIViewController) -> Void {
        
        Auth.auth().signIn(withEmail: login, password: password) { [weak self] authResult, error in
            guard self != nil else { return }
            
            // обработка ошибок
            if let error = error {
                let alertVC = UIAlertController(title: "Ошибка", message: "\(error.localizedDescription)", preferredStyle: .alert)
                let action = UIAlertAction(title: "ОК", style: .default, handler: nil)
                alertVC.addAction(action)
                vc.present(alertVC, animated: true, completion: nil)
            } else {
                let profileVC = ProfileViewController()
                vc.navigationController?.pushViewController(profileVC, animated: false)
            }
        }
        
    }
}
