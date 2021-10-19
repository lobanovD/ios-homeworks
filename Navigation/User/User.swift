//
//  User.swift
//  Navigation
//
//  Created by Dmitrii Lobanov on 19.10.2021.
//

import Foundation
import UIKit

class User {
    let login: String?
    let userFullName: String?
    let userAvatar: UIImage?
    let userStatus: String?

    init(login: String?, userFullName: String?, userAvatar: UIImage?, userStatus: String?) {
        self.login = login
        self.userFullName = userFullName
        self.userAvatar = userAvatar
        self.userStatus = userStatus
    }
}
