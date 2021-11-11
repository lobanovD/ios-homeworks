//
//  MyCustomTextField.swift
//  Navigation
//
//  Created by Dmitrii Lobanov on 09.11.2021.
//

import Foundation
import UIKit

final class MyCustomTextField: UITextField {

    private let changeText: () -> Void

    var passwordText: String = ""
    

    init(changeText: @escaping () -> Void) {
        self.changeText = changeText
        super.init(frame: .zero)
        self.addTarget(self, action: #selector(inputText), for: .editingChanged)
        self.toAutoLayout()
        self.backgroundColor = .white
        self.placeholder = "Введите пароль"
    }

    required init?(coder: NSCoder) {
        nil
    }

    @objc
    private func inputText() {
        self.changeText()
        self.passwordText = self.text ?? ""
        print(passwordText)

    }

}
