//
//  CurrentUserService.swift
//  Navigation
//
//  Created by Dmitrii Lobanov on 19.10.2021.
//

import Foundation
import UIKit

final class CurrentUserService: UserServiceProtocol {

    let user = User(login: "lobanov", userFullName: "Дмитрий Лобанов", userAvatar: UIImage(named: "avatar"), userStatus: "It's work!(c)Apache")

    func getUser(login: String) -> User? {

        if login == user.login {
            return user
        } else {
            return nil
        }
    }
}
