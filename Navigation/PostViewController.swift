//
//  PostViewController.swift
//  Navigation
//
//  Created by Dmitrii Lobanov on 23.08.2021.
//

import UIKit

class PostViewController: UIViewController {
    
    var postTitle: String?
    


    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        // цвет фона основного View
        view.backgroundColor = .brown
        
        // Заголовок
        self.title = postTitle
        
        
        // создаем кнопку в NavigationBar
        let infoBarItem: UIBarButtonItem = UIBarButtonItem(title: "Info", style: .plain, target: self, action: #selector(openInfo))
        
        // размещаем кнопку справа
        navigationItem.rightBarButtonItem = infoBarItem

    }
    
    
    // метод для кнопки Info
    @objc func openInfo() {
        let infoVC = InfoViewController()
        navigationController?.present(infoVC, animated: true)
    }



}
