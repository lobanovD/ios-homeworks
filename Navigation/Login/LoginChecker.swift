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

    func check(login: Int, password: Int) -> (login: Int, password: Int) {
        if login == self.login.hash && password == self.pswd.hash {
            print("данные верны")
            return (self.login.hash, self.pswd.hash)
        }
        else {
            return (0, 0)
        }
    }
}
