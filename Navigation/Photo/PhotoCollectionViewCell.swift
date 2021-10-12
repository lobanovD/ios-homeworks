//
//  PhotoCollectionViewCell.swift
//  Navigation
//
//  Created by Dmitrii Lobanov on 14.09.2021.
//

import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {
    
    static let identifire = "PhotoCollectionViewCell"
    
    // MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(photo)
        setupConstraints()
    }
    
    // MARK: UI elements
    
    /// Photo image
    private lazy var photo: UIImageView = {
        let photo = UIImageView()
        photo.toAutoLayout()
        return photo
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
}

// MARK: Actions
extension PhotoCollectionViewCell {
    
    /// Cell config
    public func configureCell(image: UIImage) {
        self.photo.image = image
    }
    
    /// Setup constraints
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            photo.topAnchor.constraint(equalTo: self.topAnchor),
            photo.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            photo.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            photo.trailingAnchor.constraint(equalTo: self.trailingAnchor),
        ])
    }
    
}
