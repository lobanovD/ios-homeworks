//
//  LoginInspector.swift
//  Navigation
//
//  Created by Dmitrii Lobanov on 25.10.2021.
//

import Foundation
import FirebaseAuth
import UIKit
import RealmSwift

class LoginInspector: LoginViewControllerDelegate {
    
    func signIn(login: String, password: String) {
        /* Realm auth */
        let newUser = Users()
        newUser.login = login
        newUser.password = password
        newUser.isLogin = false
        
        guard let key = UserDefaults.standard.object(forKey: "RealmKey") else { return }
        
        let config = Realm.Configuration(encryptionKey: (key as! Data))
        
        do {
            
            let realm = try Realm(configuration: config)
            
            // проверка, существует ли пользователь
            let currentUser = realm.objects(Users.self).filter("login == '\(login)'").first
            
            if currentUser == nil {
                try! realm.write {
                    realm.add(newUser)
                    NotificationCenter.default.post(name: Notification.Name("signInSuccess"), object: nil)
                }
            } else {
                NotificationCenter.default.post(name: Notification.Name("userExists"), object: nil)
            }
            
        } catch {
            fatalError("Error opening realm: \(error.localizedDescription)")
        }
        
        
     
        
        //        print(Realm.Configuration.defaultConfiguration.fileURL)
        /* Finish Realm Auth */
        
        
        /* Firebase authorisation
         //        Auth.auth().createUser(withEmail: login, password: password) { result, error in
         //
         //            if let error = error {
         //                LoginViewController.signInError = error.localizedDescription
         //                NotificationCenter.default.post(name: Notification.Name("signInError"), object: nil)
         //            } else {
         //                NotificationCenter.default.post(name: Notification.Name("signInSuccess"), object: nil)
         //            }
         //        }
         */
    }
    
    func logIn(login: String, password: String) {
        
        /* Real Auth */
        
        guard let key = UserDefaults.standard.object(forKey: "RealmKey") else { return }
        
        let config = Realm.Configuration(encryptionKey: (key as! Data))
      
        do {
        
            let realm = try Realm(configuration: config)
            
            let currentUser = realm.objects(Users.self).filter("login == '\(login)'").first
            
            if currentUser == nil {
                // пользователя не существует
                NotificationCenter.default.post(name: Notification.Name("userNotExists"), object: nil)
            } else {
                // пользователь существует
                if currentUser?.password == password {
                    // пароль верный
                    try realm.write {
                        currentUser?.isLogin = true
                    }
                    
                    UserDefaults.standard.set(true, forKey: "isLogin")
                    
                    NotificationCenter.default.post(name: Notification.Name("logInSuccess"), object: nil)
                    
                } else {
                    // пароль неверный
                    NotificationCenter.default.post(name: Notification.Name("passwordIsWrong"), object: nil)
                }
            }
        } catch {
                    fatalError("Error opening realm: \(error.localizedDescription)")
                }
            
        }
       
        
        
        /* Finish Realm Auth */
        
        /* Firebase authorisation
         //        Auth.auth().signIn(withEmail: login, password: password) { authResult, error in
         //
         //            if let error = error {
         //                LoginViewController.logInError = error.localizedDescription
         //                NotificationCenter.default.post(name: Notification.Name("logInError"), object: nil)
         //            } else {
         //                NotificationCenter.default.post(name: Notification.Name("logInSuccess"), object: nil)
         //            }
         //        }
         */
    }

