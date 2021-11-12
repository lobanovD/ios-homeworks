//
//  LoginInspector.swift
//  Navigation
//
//  Created by Dmitrii Lobanov on 25.10.2021.
//

import Foundation

class LoginInspector: LoginViewControllerDelegate {

    func check(login: String, password: String) -> Bool {
        let data = LoginChecker.shared.check(login: login, password: password)
        if data {
            print("Такой пользователь существует")
            return true
        } else {
            print("Такого пользователя не существует")
            return false
        }
    }
}
