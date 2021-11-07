//
//  MyCustomButton.swift
//  Navigation
//
//  Created by Dmitrii Lobanov on 06.11.2021.
//

import Foundation
import UIKit

final class MyCustomButton: UIButton {

    let title: String
    let titleColor: UIColor

    var didTap: ((String, UIColor) -> Void)?

    init (title: String, titleColor: UIColor) {
        self.title = title
        self.titleColor = titleColor
        self.didTap?(title, titleColor)
        super.init(frame: .zero)
    }

    required init?(coder: NSCoder) {
        nil
    }

    func buttonTapped() {
        didTap?(title, titleColor)
    }


}
