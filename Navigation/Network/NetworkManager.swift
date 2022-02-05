//
//  NetworkManager.swift
//  Navigation
//
//  Created by Dmitrii Lobanov on 05.02.2022.
//

import Foundation

struct NetworkManager {
    
    static let shared = NetworkManager()
    
    func getData(url: String) {
        
        guard let URL = URL(string: url) else { return }
        
        let session = URLSession(configuration: .default)
        
        session.dataTask(with: URL) { data, responce, error in
            
            guard let data = data, let responce = responce as? HTTPURLResponse else {
                guard let error = error else { return }
                print(error.localizedDescription)
                return }
            
            print(String(decoding: data, as: UTF8.self))
            print("allHeaderFields - \(responce.allHeaderFields)")
            print("statusCode - \(responce.statusCode)")
            
        }.resume()
    }
}
