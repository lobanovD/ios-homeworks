//
//  MyModel.swift
//  Navigation
//
//  Created by Dmitrii Lobanov on 09.11.2021.
//

import Foundation

class MyModel {

    static let shared = MyModel()

    let password: String = "Password"
    var gettingPassword: String = ""

    init() {}

    func check() {
        if gettingPassword == password {
            let nc = NotificationCenter.default
            nc.post(name: Notification.Name("passwordIsRight"), object: nil)
        } else {
            let nc = NotificationCenter.default
            nc.post(name: Notification.Name("passwordIsNotRight"), object: nil)
        }
    }
}
