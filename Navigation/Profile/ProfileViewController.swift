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
        view.backgroundColor = .lightGray
        view.addSubview(header)
        header.addView()
        self.title = "Profile"
    }
    
    override func viewWillLayoutSubviews() {
        
        guard let navigationController = navigationController else { return }
        
        header.frame = CGRect(x: view.frame.minX,
                              y: view.frame.minY +  navigationController.navigationBar.frame.maxY,
                              width: view.frame.width,
                              height: view.frame.height -
                                view.safeAreaInsets.top -
                                view.safeAreaInsets.bottom)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
