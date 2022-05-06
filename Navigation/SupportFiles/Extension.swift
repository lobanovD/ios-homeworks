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
    
    func resizeWithWidth(width: CGFloat) -> UIImage? {
        let imageView = UIImageView(frame: CGRect(origin: .zero, size: CGSize(width: width, height: CGFloat(ceil(width/size.width * size.height)))))
        imageView.contentMode = .scaleAspectFit
        imageView.image = self
        UIGraphicsBeginImageContextWithOptions(imageView.bounds.size, false, scale)
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        imageView.layer.render(in: context)
        guard let result = UIGraphicsGetImageFromCurrentImageContext() else { return nil }
        UIGraphicsEndImageContext()
        return result
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


// MARK: String

extension String {
    func localized(file: String) -> String {
        NSLocalizedString(self, tableName: file, bundle: Bundle.main, value: self, comment: "")
    }
}
