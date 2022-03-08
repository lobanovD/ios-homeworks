//
//  UserModel.swift
//  Navigation
//
//  Created by Dmitrii Lobanov on 07.03.2022.
//

import Foundation
import RealmSwift

class Users: Object {
    @Persisted var login: String
    @Persisted var password: String
    @Persisted var isLogin: Bool
}


