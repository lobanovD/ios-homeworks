//
//  MyCustomButton.swift
//  Navigation
//
//  Created by Dmitrii Lobanov on 09.11.2021.
//

import Foundation
import UIKit

final class MyCustomButton: UIButton {
    var buttonTap: () -> Void

    init(buttonTap: @escaping () -> Void) {


        self.buttonTap = buttonTap
        super.init(frame: .zero)
        self.addTarget(self, action: #selector(tapForCheck), for: .touchUpInside)
        self.toAutoLayout()
        self.backgroundColor = UIColor.rgb(2, 122, 255, 1)
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 4, height: 4)
        self.layer.shadowOpacity = 0.7
        self.layer.shadowRadius = 4
        self.setTitle("Проверить пароль", for: .normal)
        self.setTitleColor(.black, for: .normal)
    }

    required init?(coder: NSCoder) {
        nil
    }

    @objc
    private func tapForCheck() {
        self.buttonTap()
        let vc = FeedViewController()
        print(vc.myCustomTF.passwordText)

    }


}
