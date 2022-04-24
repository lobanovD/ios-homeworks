//
//  RealmEncrypt.swift
//  Navigation
//
//  Created by Dmitrii Lobanov on 25.04.2022.
//

import Foundation

class RealmEncrypt {
    
    static var shared = RealmEncrypt()
    
    func generateAndSaveKey() {
        
        // создаем ключ
        var key = Data(count: 64)
        _ = key.withUnsafeMutableBytes { (pointer: UnsafeMutableRawBufferPointer) in
            SecRandomCopyBytes(kSecRandomDefault, 64, pointer.baseAddress!) }
        
        print("сгенерированный ключ -", key)
        
        // сохраняем ключ
        if UserDefaults.standard.object(forKey: "RealmKey") == nil {
            UserDefaults.standard.set(key, forKey: "RealmKey")
            print("Ключ RealmKey сохранен")
        } else {
            print("Ключ RealmKey уже существует")
        }
    }
}
