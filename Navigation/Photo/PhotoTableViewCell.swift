//
//  PhotosTableViewCell.swift
//  Navigation
//
//  Created by Dmitrii Lobanov on 14.09.2021.
//

import UIKit

class PhotoTableViewCell: UITableViewCell {
    
    static let identifire = "PhotosTableViewCell"
    
    //MARK: Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        contentView.addSubviews(photosLabel, PhotoTableViewCell.arrowButton, previewStackView)
        previewStackView.addArrangedSubviews(previewImage1, previewImage2, previewImage3, previewImage4)
        setupConstraints()
    }
    
    // MARK: UI elements
    
    /// Label
    private lazy var photosLabel: UILabel = {
        let photosLabel = UILabel()
        photosLabel.text = "Photos"
        photosLabel.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        photosLabel.textColor = .black
        photosLabel.toAutoLayout()
        return photosLabel
    }()
    
    /// Arrow Button
    static var arrowButton: UIButton = {
        let arrowButton = UIButton()
        arrowButton.setImage(UIImage(systemName: "arrow.right", withConfiguration: UIImage.SymbolConfiguration(pointSize: 40))?.withTintColor(.black, renderingMode: .alwaysOriginal), for: .normal)
        arrowButton.setImage(UIImage(systemName: "arrow.right", withConfiguration: UIImage.SymbolConfiguration(pointSize: 20))?.withTintColor(.gray, renderingMode: .alwaysOriginal), for: .highlighted)
        arrowButton.toAutoLayout()
        return arrowButton
    }()
    
    
    
    /// PreviewStackView
    private lazy var previewStackView: UIStackView = {
        let previewStackView = UIStackView()
        previewStackView.toAutoLayout()
        previewStackView.axis = .horizontal
        previewStackView.distribution = .fillEqually
        previewStackView.alignment = .center
        previewStackView.spacing = 8
        return previewStackView
    }()
    
    /// Preview Image 1
    private lazy var previewImage1:UIImageView = {
        let previewImage1 = UIImageView()
        previewImage1.image = photosArray[0]
        previewImage1.toAutoLayout()
        previewImage1.layer.cornerRadius = 6
        previewImage1.clipsToBounds = true
        return previewImage1
    }()
    
    /// Preview Image 2
    private lazy var previewImage2:UIImageView = {
        let previewImage2 = UIImageView()
        previewImage2.image = photosArray[1]
        previewImage2.toAutoLayout()
        previewImage2.layer.cornerRadius = 6
        previewImage2.clipsToBounds = true
        return previewImage2
    }()
    
    /// Preview Image 3
    private lazy var previewImage3:UIImageView = {
        let previewImage3 = UIImageView()
        previewImage3.image = photosArray[2]
        previewImage3.toAutoLayout()
        previewImage3.layer.cornerRadius = 6
        previewImage3.clipsToBounds = true
        return previewImage3
    }()
    
    /// Preview Image 4
    private lazy var previewImage4:UIImageView = {
        let previewImage4 = UIImageView()
        previewImage4.image = photosArray[3]
        previewImage4.toAutoLayout()
        previewImage4.layer.cornerRadius = 6
        previewImage4.clipsToBounds = true
        return previewImage4
    }()
    
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
}

// MARK: Actions
extension PhotoTableViewCell {
    /// Setup constraints
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            
            photosLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: PhotoTableViewCellConstants.photosLabelLeading),
            photosLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: PhotoTableViewCellConstants.photosLabelTop),
            
            PhotoTableViewCell.arrowButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: PhotoTableViewCellConstants.arrowButtonTrailing),
            PhotoTableViewCell.arrowButton.centerYAnchor.constraint(equalTo: photosLabel.centerYAnchor),
            PhotoTableViewCell.arrowButton.heightAnchor.constraint(equalToConstant: PhotoTableViewCellConstants.arrowButtonHeight),
            PhotoTableViewCell.arrowButton.widthAnchor.constraint(equalToConstant: PhotoTableViewCellConstants.arrowButtonWidth),
            
            previewStackView.topAnchor.constraint(equalTo: photosLabel.bottomAnchor, constant: PhotoTableViewCellConstants.previewStackViewTop),
            previewStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: PhotoTableViewCellConstants.previewStackViewLeading),
            previewStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: PhotoTableViewCellConstants.previewStackViewTrailing),
            previewStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: PhotoTableViewCellConstants.previewStackViewBottom),
            
            previewImage1.widthAnchor.constraint(greaterThanOrEqualToConstant: (contentView.frame.width - 16) / 4),
            previewImage1.heightAnchor.constraint(equalTo: previewImage1.widthAnchor),
            
            previewImage2.widthAnchor.constraint(greaterThanOrEqualToConstant: (contentView.frame.width - 16) / 4),
            previewImage2.heightAnchor.constraint(equalTo: previewImage2.widthAnchor),
            
            previewImage3.widthAnchor.constraint(greaterThanOrEqualToConstant: (contentView.frame.width - 16) / 4),
            previewImage3.heightAnchor.constraint(equalTo: previewImage2.widthAnchor),
            
            previewImage4.widthAnchor.constraint(greaterThanOrEqualToConstant: (contentView.frame.width - 16) / 4),
            previewImage4.heightAnchor.constraint(equalTo: previewImage2.widthAnchor),
            
        ])
    }
    
}
