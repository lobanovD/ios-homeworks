//
//  LoginViewControllerDelegate.swift
//  Navigation
//
//  Created by Dmitrii Lobanov on 25.10.2021.
//

import Foundation
import UIKit

protocol LoginViewControllerDelegate {
    func signIn(login: String, password: String)
    func logIn(login: String, password: String)
}
