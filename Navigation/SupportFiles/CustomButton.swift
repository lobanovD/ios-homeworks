//
//  MyCustomButton.swift
//  Navigation
//
//  Created by Dmitrii Lobanov on 06.11.2021.
//

import Foundation
import UIKit

final class CustomButton: UIButton {

    private var buttonAction: () -> Void

    init(title: String, titleColor: UIColor, buttonAction: @escaping () -> Void) {
        self.buttonAction = buttonAction
        super.init(frame: .zero)
        self.setTitle(title, for: .normal)
        self.setTitleColor(titleColor, for: .normal)
        self.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)

        self.toAutoLayout()
        self.backgroundColor = UIColor.rgb(2, 122, 255, 1)
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 4, height: 4)
        self.layer.shadowOpacity = 0.7
        self.layer.shadowRadius = 4

    }

    @objc private func buttonTapped() {
        self.buttonAction()
    }

    required init?(coder: NSCoder) {
        nil
    }
}
