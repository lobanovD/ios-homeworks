//
//  LoginChecker.swift
//  Navigation
//
//  Created by Dmitrii Lobanov on 25.10.2021.
//

import Foundation

class LoginChecker {

    private let login = "lobanov"
    private let pswd = "lobanov"
    static let shared = LoginChecker()

    func check(login: String, password: String) -> Bool {
        if login.hash == self.login.hash && password.hash == self.pswd.hash {
            print("данные верны")
            return true
        } else {
            return false
        }
    }
}
