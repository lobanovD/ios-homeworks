//
//  MyLoginFactory.swift
//  Navigation
//
//  Created by Dmitrii Lobanov on 26.10.2021.
//

import Foundation

class MyLoginFactory: LoginFactoryProtocol {
    func createLoginInspector() -> LoginInspector {
        let inspector = LoginInspector()
        return inspector
    }
}
