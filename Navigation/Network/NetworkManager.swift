//
//  NetworkManager.swift
//  Navigation
//
//  Created by Dmitrii Lobanov on 05.02.2022.
//

import Foundation

struct NetworkManager {
    
    static let shared = NetworkManager()
    
    static var title = ""
    static var orbitalPeriod = ""
    
    // ДЗ 1.2 п.1
    func getDataFromJsonplaceholder() {
        
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/todos/1") else {
            print("не удалось получить URL")
            return }

        let session = URLSession(configuration: .default)
        
        session.dataTask(with: url) { data, responce, error in
            guard let data = data else { return }
            do {
                if let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String : Any] {
                    
                    guard let title = json["title"] as? String else { return }
                    NetworkManager.title = title
                    
                } else {
                    print("Не удалось сериализовать")
                }
            }
        }.resume()
    }
    
    func getDataAboutPlanet() {
        
        guard let url = URL(string: "https://swapi.dev/api/planets/1") else {
            print("не удалось получить URL")
            return }

        let session = URLSession(configuration: .default)
        
        session.dataTask(with: url) { data, responce, error in
            guard let data = data else { return }
            do {
                if let json = try? JSONDecoder().decode(PlanetModel.self, from: data) {
                    NetworkManager.orbitalPeriod = json.orbitalPeriod
                } else {
                    print("Не удалось сериализовать")
                }
            }
        }.resume()
    }
}
