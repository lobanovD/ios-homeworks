//
//  UserService.swift
//  Navigation
//
//  Created by Dmitrii Lobanov on 19.10.2021.
//

import Foundation

protocol UserServiceProtocol {

    func getUser(login: String) -> User?

}
