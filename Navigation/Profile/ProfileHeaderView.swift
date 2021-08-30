//
//  ProfileHeaderView.swift
//  Navigation
//
//  Created by Dmitrii Lobanov on 28.08.2021.
//

import UIKit

class ProfileHeaderView: UIView {
    
    private var statusText: String = ""
    
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
        button.setTitle("Set status", for: .normal)
        button.setTitleColor(.lightGray, for: .highlighted)
        button.addTarget(self, action: #selector(pressButton), for: .touchUpInside)
        NSLayoutConstraint.activate([
            button.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16),
            button.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16),
            button.topAnchor.constraint(equalTo: avatar.bottomAnchor, constant: 42),
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
//        statusLabel.lineBreakMode = .byWordWrapping
        statusLabel.numberOfLines = 2
        statusLabel.textColor = .gray
        statusLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        
        NSLayoutConstraint.activate([
            statusLabel.leftAnchor.constraint(equalTo: avatar.rightAnchor, constant: 20),
            statusLabel.bottomAnchor.constraint(equalTo: setStatusTF.topAnchor, constant: -6),
            statusLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16),
        ])
    }
    /*--------------------------------------------------------------*/
//    TF
    var setStatusTF: UITextField = {
        let setStatusTF = UITextField()
        return setStatusTF
    }()
    
    private func setStatusTFBuild() {
        setStatusTF.translatesAutoresizingMaskIntoConstraints = false
        setStatusTF.layer.borderWidth = 1
        setStatusTF.layer.borderColor = UIColor.black.cgColor
        setStatusTF.layer.cornerRadius = 12
        setStatusTF.backgroundColor = .white
        setStatusTF.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        setStatusTF.textColor = .black
        setStatusTF.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: setStatusTF.frame.height))
        setStatusTF.leftViewMode = .always
        setStatusTF.placeholder = "Set status"
        setStatusTF.addTarget(self, action: #selector(statusTextChanged), for: .editingChanged)
        
        NSLayoutConstraint.activate([
            setStatusTF.leftAnchor.constraint(equalTo: avatar.rightAnchor, constant: 20),
            setStatusTF.bottomAnchor.constraint(equalTo: button.topAnchor, constant: -10),
            setStatusTF.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16),
            setStatusTF.heightAnchor.constraint(equalToConstant: 40)
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
        self.addSubview(setStatusTF)
        setStatusTFBuild()
        self.addSubview(statusLabel)
        statusLabelBuild()
    }
    
    // метод нажатия на кнопку
    @objc func pressButton(){
        if statusLabel.text != nil && statusText != "" {
            statusLabel.text = statusText
            setStatusTF.text = ""
        }
        
    }
    
    // метод для TF
    @objc func statusTextChanged(_ textField: UITextField) {
        guard let text = textField.text else { return }
        statusText = text
    }  
}
