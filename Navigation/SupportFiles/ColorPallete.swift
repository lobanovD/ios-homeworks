//
//  ColorPallete.swift
//  Navigation
//
//  Created by Dmitrii Lobanov on 11.05.2022.
//

import Foundation
import UIKit

struct ColorPallete {
    
    // фон
    static var backgroundColor = UIColor.createThemeColor(lightMode: .white, darkMode: .darkGray)
    // фон TabBar
    static var tabBarBackground = UIColor.createThemeColor(lightMode: .white, darkMode: .darkGray)
    // tabBar иконки
    static var tabBarItem = UIColor.createThemeColor(lightMode: .darkGray, darkMode: .white)
    // TextFields LoginVC
    static var textFieldBackground = UIColor.createThemeColor(lightMode: .systemGray6, darkMode: .systemGray3)
    // Цвет курсора TextField
    static var TFCursor = UIColor.createThemeColor(lightMode: .darkGray, darkMode: .white)
    // Цвет текста TextField
    static var TFText = UIColor.createThemeColor(lightMode: .darkGray, darkMode: .white)
    // кнопки
    static var button = UIColor.createThemeColor(lightMode: UIColor(named: "VKColor")!, darkMode: UIColor(named: "VKColor")!)
    
    //Цвет текста профайла
    static var nameColor = UIColor.createThemeColor(lightMode: .black, darkMode: .white)
    //Цвет стрелочки фото плашки
    static var photoArrow = UIColor.createThemeColor(lightMode: .black, darkMode: .white)
    // цвет разделителя ячеек
    static var separator = UIColor.createThemeColor(lightMode: .black, darkMode: .white)
    // цвет текса в ячейке
    static var cellText = UIColor.createThemeColor(lightMode: .black, darkMode: .white)
}

