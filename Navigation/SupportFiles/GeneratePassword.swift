//
//  GeneratePassword.swift
//  Navigation
//
//  Created by Dmitrii Lobanov on 28.11.2021.
//

import Foundation

final class GeneratePassword {
    
    static let shared = GeneratePassword()
    
    var generatedPassword = ""
    
    func generatePass(count: Int) {
        generatedPassword = ""
        
        let charactersArray:[String] = ["a", "b", "c", "d", "e", "f", "g",
                                        "h", "i", "j", "k", "l", "m", "n",
                                        "o", "p", "q", "r", "s", "t", "u",
                                        "v", "w", "x", "y", "z","A", "B",
                                        "C", "D", "E", "F", "G", "H", "I",
                                        "J", "K", "L", "M", "N", "O", "P",
                                        "Q", "R", "S", "T", "U", "V", "W",
                                        "X", "Y", "Z", "1", "2", "3", "4",
                                        "5", "6", "7", "8", "9", "0"]
        
        for _ in 1...count {
            let newChar = charactersArray.randomElement()
            guard let str = newChar else { return }
            generatedPassword.append(str)
        }
    }
}
