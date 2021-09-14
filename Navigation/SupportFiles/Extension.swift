//
//  Extension.swift
//  Navigation
//
//  Created by Dmitrii Lobanov on 14.09.2021.
//

import UIKit

// MARK: Alpha UIImage
extension UIImage {
    func image(alpha: CGFloat) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        draw(at: .zero, blendMode: .normal, alpha: alpha)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
}

// MARK: UIStackView
public extension UIStackView {
    func addArrangedSubviews(_ subviews: UIView...) {
        for subview in subviews {
            self.addArrangedSubview(subview)
        }
    }
    
}

// MARK: UIView
public extension UIView {
    
    func addSubviews(_ subviews: UIView...) {
        for subview in subviews {
            self.addSubview(subview)
        }
    }
    
    
    func toAutoLayout() {
        translatesAutoresizingMaskIntoConstraints = false
    }
}


