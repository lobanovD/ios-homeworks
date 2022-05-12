//
//  PostTableViewCell.swift
//  Navigation
//
//  Created by Dmitrii Lobanov on 07.09.2021.
//

import UIKit
import iOSIntPackage

class PostTableViewCell: UITableViewCell {
    
    static let identifire = "PostTableViewCell"
    
    // MARK: Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubviews(postTitle, postImage, postDescription, postLikes, postViews)
        self.selectionStyle = .none
        contentView.backgroundColor = ColorPallete.backgroundColor
        setupConstraints()
    }
    
    // MARK: UI elements
    // Post title
    private lazy var postTitle: UILabel = {
        let postTitle = UILabel()
        postTitle.toAutoLayout()
        postTitle.numberOfLines = 2
        postTitle.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        return postTitle
    }()
    
    // Post image
    private lazy var postImage: UIImageView = {
        let postImage = UIImageView()
        postImage.toAutoLayout()
        postImage.contentMode = .scaleToFill
        return postImage
    }()
    
    // Post description
    private lazy var postDescription: UILabel = {
        let postDescription = UILabel()
        postDescription.toAutoLayout()
        postDescription.font = UIFont.systemFont(ofSize: 14)
        postDescription.textColor = ColorPallete.cellText
        postDescription.numberOfLines = 0
        return postDescription
    }()
    
    // Post likes
    private lazy var postLikes: UILabel = {
        let postLikes = UILabel()
        postLikes.toAutoLayout()
        postLikes.font = UIFont.systemFont(ofSize: 16)
//        postLikes.textColor = .black
        return postLikes
    }()
    
    // Post views
    private lazy var postViews: UILabel = {
        let postViews = UILabel()
        postViews.toAutoLayout()
        postViews.font = UIFont.systemFont(ofSize: 16)
//        postViews.textColor = .black
        return postViews
    }()
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
}

// MARK: Actions
extension PostTableViewCell {
    
    // Cell config
    public func configureCell(title: String, image: String, description: String, likes: Int, views: Int) {
        self.postTitle.text = title
        self.postImage.image = UIImage(named: image)

        // применяем рандомный фильтр к изображению
        let randomInt = Int.random(in: 1...8)
        let filter: ColorFilter?

        switch randomInt {
        case 1: filter = .posterize
        case 2: filter = .colorInvert
        case 3: filter = .transfer
        case 4: filter = .noir
        case 5: filter = .tonal
        case 6: filter = .process
        case 7: filter = .chrome
        case 8: filter = .fade
        default: filter = nil
        }

        let processor = ImageProcessor()
        guard let filter = filter else { return }
        guard let image = postImage.image else { return }

        processor.processImage(sourceImage: image, filter: filter) { filteredImage in
            postImage.image = filteredImage
        }

        self.postDescription.text = description
        
        self.postLikes.text = "\("likes_lable_text".localized(file: "Localizable_ProfileView")): \(likes)"
        let viewsLableText = "views_lable_text".localized(file: "Localizable_ProfileView")
        self.postViews.text = "\(viewsLableText) : \(views)"
    }
    
    // Setup constraints
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            
            contentView.widthAnchor.constraint(equalTo: self.widthAnchor),
            
            postTitle.topAnchor.constraint(equalTo: contentView.topAnchor, constant: PostTableViewCellConstants.postTitleTop),
            postTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: PostTableViewCellConstants.postTitleLeading),
            postTitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: PostTableViewCellConstants.postTitleTrailing),
            
            postImage.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            postImage.heightAnchor.constraint(equalToConstant: CGFloat(contentView.frame.width / 1.5) ),
            postImage.topAnchor.constraint(equalTo: postTitle.bottomAnchor, constant: PostTableViewCellConstants.postImageTop),
            
            postDescription.topAnchor.constraint(equalTo: postImage.bottomAnchor, constant: PostTableViewCellConstants.postDescriptionTop),
            postDescription.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: PostTableViewCellConstants.postDescriptionLeading),
            postDescription.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: PostTableViewCellConstants.postDescriptionTrailing),
            
            postLikes.topAnchor.constraint(equalTo: postDescription.bottomAnchor, constant: PostTableViewCellConstants.postLikesTop),
            postLikes.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: PostTableViewCellConstants.postLikesLeading),
            postLikes.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: PostTableViewCellConstants.postLikesBottom),
            
            postViews.topAnchor.constraint(equalTo: postDescription.bottomAnchor, constant: PostTableViewCellConstants.postViewsTop),
            postViews.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: PostTableViewCellConstants.postViewsTrailing),
            postViews.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: PostTableViewCellConstants.postViewsBottom),
        ])
    }
    
}
