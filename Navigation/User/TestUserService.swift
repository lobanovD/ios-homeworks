//
//  TestUserService.swift
//  Navigation
//
//  Created by Dmitrii Lobanov on 20.10.2021.
//

import Foundation
import UIKit

final class TestUserService: UserServiceProtocol {

    let user = User(login: "test", userFullName: "Тест Тест", userAvatar: UIImage(named: "avatar2"), userStatus: "It's test!")

    func getUser(login: String) -> User? {

        if login == user.login {
            return user
        } else {
            return nil
        }
    }
    
}
