//
//  Config.swift
//  Navigation
//
//  Created by Dmitrii Lobanov on 05.02.2022.
//

import Foundation

enum AppConfiguration: String {
    case url1 = "https://swapi.dev/api/people/8"
    case url2 = "https://swapi.dev/api/starships/3"
    case url3 = "https://swapi.dev/api/planets/5"
}

extension AppConfiguration: CaseIterable {
    
    static func randomURL() -> String {
        guard let result = allCases.randomElement()?.rawValue else { return "Произошла ошибка получения рандомного URL" }
        return result
    }
}
