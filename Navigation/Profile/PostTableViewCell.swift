//
//  PostTableViewCell.swift
//  Navigation
//
//  Created by Dmitrii Lobanov on 07.09.2021.
//

import UIKit

class PostTableViewCell: UITableViewCell {
    
    static let identifire = "PostTableViewCell"
    
    // MARK: Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubviews(postTitle, postImage, postDescription, postLikes, postViews)
        self.selectionStyle = .none
        setupConstraints()
    }
    
    // MARK: UI elements
    /// Post title
    private lazy var postTitle: UILabel = {
        let postTitle = UILabel()
        postTitle.toAutoLayout()
        postTitle.numberOfLines = 2
        postTitle.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        return postTitle
    }()
    
    /// Post image
    private lazy var postImage: UIImageView = {
        let postImage = UIImageView()
        postImage.toAutoLayout()
        postImage.backgroundColor = .black
        postImage.contentMode = .scaleAspectFit
        return postImage
    }()
    
    /// Post description
    private lazy var postDescription: UILabel = {
        let postDescription = UILabel()
        postDescription.toAutoLayout()
        postDescription.font = UIFont.systemFont(ofSize: 14)
        postDescription.textColor = .systemGray
        postDescription.numberOfLines = 0
        
        return postDescription
    }()
    
    /// Post likes
    private lazy var postLikes: UILabel = {
        let postLikes = UILabel()
        postLikes.toAutoLayout()
        postLikes.font = UIFont.systemFont(ofSize: 16)
        postLikes.textColor = .black
        return postLikes
    }()
    
    /// Post views
    private lazy var postViews: UILabel = {
        let postViews = UILabel()
        postViews.toAutoLayout()
        postLikes.font = UIFont.systemFont(ofSize: 16)
        postLikes.textColor = .black
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
    
    /// Cell config
    public func configureCell(title: String, image: String, description: String, likes: Int, views: Int) {
        self.postTitle.text = title
        self.postImage.image = UIImage(named: image)
        self.postDescription.text = description
        self.postLikes.text = "Likes: \(likes)"
        self.postViews.text = "Views: \(views)"
    }
    
    /// Setup constraints
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            
            contentView.widthAnchor.constraint(equalTo: self.widthAnchor),
            
            postTitle.topAnchor.constraint(equalTo: contentView.topAnchor, constant: PostTableViewCellConstants.postTitleTop),
            postTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: PostTableViewCellConstants.postTitleLeading),
            postTitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: PostTableViewCellConstants.postTitleTrailing),
            
            postImage.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            postImage.heightAnchor.constraint(equalTo: postImage.widthAnchor),
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
