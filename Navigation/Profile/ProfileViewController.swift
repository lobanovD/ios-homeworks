//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Dmitrii Lobanov on 23.08.2021.
//

import UIKit

class ProfileViewController: UIViewController {
    
    lazy private(set) var header = ProfileHeaderView()
    
    lazy private(set) var setTitleButton:UIButton = {
        var setTitleButton = UIButton()
        setTitleButton.translatesAutoresizingMaskIntoConstraints = false
        setTitleButton.backgroundColor = UIColor.rgb(2, 122, 255, 1)
        setTitleButton.setTitle("Set title", for: .normal)
        setTitleButton.setTitleColor(.lightGray, for: .highlighted)
        setTitleButton.addTarget(self, action: #selector(pressButton), for: .touchUpInside)
        return setTitleButton
    }()
    
    @objc private func pressButton() {
        self.title = "New title"
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            setTitleButton.leftAnchor.constraint(equalTo: view.leftAnchor),
            setTitleButton.rightAnchor.constraint(equalTo: view.rightAnchor),
            setTitleButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            setTitleButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .lightGray
        self.view.addSubview(header)
        header.addView()
        self.title = "Profile"
        self.view.addSubview(setTitleButton)
        self.setupConstraints()
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}


extension UIColor {
    class func rgb(_ r: CGFloat, _ g: CGFloat, _ b: CGFloat, _ alpha: CGFloat) -> UIColor {
        let color = UIColor(red: r / 255, green: g / 255, blue: b / 255, alpha: alpha)
        return color
    }
}


