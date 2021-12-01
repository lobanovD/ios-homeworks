//
//  Brutforce.swift
//  Navigation
//
//  Created by Dmitrii Lobanov on 21.11.2021.
//

import Foundation

class Brutforce {

    static let shared = Brutforce()

    let arr =  ["a", "b", "c", "d", "e", "f", "g",
                "h", "i", "j", "k", "l", "m", "n",
                "o", "p", "q", "r", "s", "t", "u",
                "v", "w", "x", "y", "z","A", "B",
                "C", "D", "E", "F", "G", "H", "I",
                "J", "K", "L", "M", "N", "O", "P",
                "Q", "R", "S", "T", "U", "V", "W",
                "X", "Y", "Z", "1", "2", "3", "4",
                "5", "6", "7", "8", "9", "0"]

    func generate(length: Int) -> [String] {
        if length == 1 {
            return arr
        }
        else {
            let subStrings = generate(length: length - 1)

            var newArr = [String]()
            for i in arr {
                for sub in subStrings {
                    newArr.append(i + sub)
                }
            }
            return newArr
        }
    }
}
