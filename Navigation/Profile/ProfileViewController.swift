//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Dmitrii Lobanov on 23.08.2021.
//

import UIKit

class ProfileViewController: UIViewController {
    
    let header = ProfileHeaderView()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(header)
        
        view.backgroundColor = .lightGray
        self.title = "Profile"
    }
    
    override func viewWillLayoutSubviews() {
        self.header.frame = CGRect(x: view.frame.minX, y: view.frame.minY, width: view.frame.width, height: view.frame.height)
    }
    

}
