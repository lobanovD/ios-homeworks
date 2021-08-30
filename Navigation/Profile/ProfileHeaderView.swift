//
//  ProfileHeaderView.swift
//  Navigation
//
//  Created by Dmitrii Lobanov on 28.08.2021.
//

import UIKit

class ProfileHeaderView: UIView {
    
    /*--------------------------------------------------------------*/
    // аватар
    var avatar: UIImageView = {
        let image = UIImageView()
        return image
    }()
    
    private func avatarBuild() {
        avatar.translatesAutoresizingMaskIntoConstraints = false
        avatar.clipsToBounds = true
        avatar.image = UIImage(named: "avatar")
        avatar.layer.cornerRadius = 50
        avatar.layer.borderWidth = 3
        avatar.layer.borderColor = CGColor(red: 255, green: 255, blue: 255, alpha: 1)
        NSLayoutConstraint.activate([
            avatar.widthAnchor.constraint(equalToConstant: 100),
            avatar.heightAnchor.constraint(equalTo: avatar.widthAnchor),
            avatar.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16),
            avatar.topAnchor.constraint(equalTo: self.topAnchor, constant: 16)
        ])
    }
    /*--------------------------------------------------------------*/
    // имя
    var nameLabel: UILabel = {
        let nameLabel = UILabel()
        return nameLabel
    }()
    
    private func nameLabelBuild() {
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.text = "Dmitriy Lobanov"
        nameLabel.textColor = .black
        nameLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        NSLayoutConstraint.activate([
            nameLabel.leftAnchor.constraint(equalTo: avatar.rightAnchor, constant: 20),
            nameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 27)
        ])
    }
    /*--------------------------------------------------------------*/
    // кнопка
    
    var button: UIButton = {
        let button = UIButton()
        return button
    }()
    
    private func buttonBuild() {
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor(cgColor: CGColor(red: 2/255, green: 122/255, blue: 255/255, alpha: 1))
        button.layer.cornerRadius = 4
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 4, height: 4)
        button.layer.shadowOpacity = 0.7
        button.layer.shadowRadius = 4
        button.setTitle("Show status", for: .normal)
        button.setTitleColor(.lightGray, for: .highlighted)
        button.addTarget(self, action: #selector(pressButton), for: .touchUpInside)
        NSLayoutConstraint.activate([
            button.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16),
            button.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16),
            button.topAnchor.constraint(equalTo: avatar.bottomAnchor, constant: 16),
            button.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    /*--------------------------------------------------------------*/
    // статус
    var statusLabel: UILabel = {
        let statusLabel = UILabel()
        return statusLabel
    }()
    
    private func statusLabelBuild() {
        statusLabel.translatesAutoresizingMaskIntoConstraints = false
        statusLabel.text = "Waiting for something"
        statusLabel.textColor = .gray
        statusLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        
        NSLayoutConstraint.activate([
            statusLabel.leftAnchor.constraint(equalTo: avatar.rightAnchor, constant: 20),
            statusLabel.bottomAnchor.constraint(equalTo: button.topAnchor, constant: -34)
        ])
    }
    /*--------------------------------------------------------------*/
    
    //    метод отображения всех элементов
    func addView() {
        self.addSubview(avatar)
        avatarBuild()
        self.addSubview(nameLabel)
        nameLabelBuild()
        self.addSubview(button)
        buttonBuild()
        self.addSubview(statusLabel)
        statusLabelBuild()
        
    }
    
    // метод нажатия на кнопку
    @objc func pressButton(){
        if statusLabel.text != nil {
            print(statusLabel.text!)
        }
        
    }
    
}
