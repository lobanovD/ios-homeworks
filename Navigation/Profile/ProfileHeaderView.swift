//
//  ProfileHeaderView.swift
//  Navigation
//
//  Created by Dmitrii Lobanov on 28.08.2021.
//

import UIKit
import SnapKit

class ProfileHeaderView: UITableViewHeaderFooterView {
    
    private(set) var statusText: String = ""
    static let identifire = "ProfileHeaderView"
    var defaultAvatarCenter: CGPoint = CGPoint(x: 0, y: 0)
    
    // MARK: UI elements
    
    /// Plag View
    private lazy var plagView: UIView = {
        let plagView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        plagView.toAutoLayout()
        plagView.backgroundColor = .gray
        plagView.alpha = 0
        return plagView
    }()
    
    /// Plag Escape Button
    private lazy var plagEscButton: UIButton = {
        let plagEscButton = UIButton()
        plagEscButton.toAutoLayout()
        plagEscButton.setImage(UIImage(named: "esc"), for: .normal)
        plagEscButton.imageView?.contentMode = .scaleAspectFit
        let gesture = UITapGestureRecognizer(target: self, action: #selector(self.tapPlagEscButton))
        plagEscButton.addGestureRecognizer(gesture)
        plagEscButton.isUserInteractionEnabled = true
        plagEscButton.alpha = 0
        return plagEscButton
    }()
    
    
    /// Avatar image
    private(set) lazy var avatarImageView: UIImageView = {
        let avatarImageView = UIImageView()
        avatarImageView.toAutoLayout()
        avatarImageView.clipsToBounds = true
        avatarImageView.image = UIImage(named: "avatar")
        avatarImageView.layer.cornerRadius = 50
        avatarImageView.layer.borderWidth = 3
        avatarImageView.layer.borderColor = CGColor(red: 255, green: 255, blue: 255, alpha: 1)
        let gesture = UITapGestureRecognizer(target: self, action: #selector(self.tapOnAvatar))
        avatarImageView.addGestureRecognizer(gesture)
        avatarImageView.isUserInteractionEnabled = true
        return avatarImageView
    }()
    
    /// Name label
    private(set) lazy var fullNameLabel: UILabel = {
        let fullNameLabel = UILabel()
        fullNameLabel.toAutoLayout()
        fullNameLabel.text = "Dmitriy Lobanov"
        fullNameLabel.textColor = .black
        fullNameLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        return fullNameLabel
    }()
    
    /// Set status Button
    private(set) lazy var setStatusButton: UIButton = {
        let setStatusButton = UIButton()
        setStatusButton.toAutoLayout()
        setStatusButton.backgroundColor = UIColor.rgb(2, 122, 255, 1)
        setStatusButton.layer.cornerRadius = 4
        setStatusButton.layer.shadowColor = UIColor.black.cgColor
        setStatusButton.layer.shadowOffset = CGSize(width: 4, height: 4)
        setStatusButton.layer.shadowOpacity = 0.7
        setStatusButton.layer.shadowRadius = 4
        let setStatusText = "set_status_text".localized(file: "Localizable_ProfileView")
        setStatusButton.setTitle(setStatusText, for: .normal)
        setStatusButton.setTitleColor(.lightGray, for: .highlighted)
        setStatusButton.addTarget(self, action: #selector(setStatus), for: .touchUpInside)
        return setStatusButton
    }()
    
    /// Status label
    private(set) lazy var statusLabel: UILabel = {
        let statusLabel = UILabel()
        statusLabel.toAutoLayout()
        statusLabel.text = ""
        statusLabel.numberOfLines = 2
        statusLabel.textColor = .gray
        statusLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        return statusLabel
    }()
    
    /// TF for status setting
    private(set) lazy var statusTextField: UITextField = {
        let statusTextField = UITextField()
        statusTextField.toAutoLayout()
        statusTextField.layer.borderWidth = 1
        statusTextField.layer.borderColor = UIColor.black.cgColor
        statusTextField.layer.cornerRadius = 12
        statusTextField.backgroundColor = .white
        statusTextField.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        statusTextField.textColor = .black
        statusTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: statusTextField.frame.height))
        statusTextField.leftViewMode = .always
        let statusTFPlaceholderText = "status_tf_placeholder_text".localized(file: "Localizable_ProfileView")
        statusTextField.placeholder = statusTFPlaceholderText
        statusTextField.addTarget(self, action: #selector(statusTextChanged), for: .editingChanged)
        return statusTextField
    }()
    
    // MARK: Init
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        addView()
    }
    
    // MARK: Add Subviews
    func addView() {
        contentView.addSubviews(fullNameLabel, setStatusButton, statusTextField, statusLabel, plagView, plagEscButton, avatarImageView, plagEscButton)
        self.setupConstraints()
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


// MARK: Actions
extension ProfileHeaderView {
    
    // Setup constraints
    private func setupConstraints() {

        avatarImageView.snp.makeConstraints { constraint in
            constraint.width.equalTo(ProfileHeaderViewConstants.avatarWidth)
            constraint.height.equalTo(ProfileHeaderViewConstants.avatarWidth)
            constraint.leftMargin.equalTo(ProfileHeaderViewConstants.avatarLeading)
            constraint.topMargin.equalTo(ProfileHeaderViewConstants.avatarTop)
        }

        fullNameLabel.snp.makeConstraints { constraint in
            constraint.left.equalTo(avatarImageView.snp.right).offset(ProfileHeaderViewConstants.fullNameLeading)
            constraint.top.equalTo(self.snp.top).offset(ProfileHeaderViewConstants.fullNameTop)
        }

        setStatusButton.snp.makeConstraints { constraint in
            constraint.left.equalTo(self.snp.left).offset(ProfileHeaderViewConstants.setStatusButtonLeading)
            constraint.right.equalTo(self.snp.right).offset(ProfileHeaderViewConstants.setStatusButtonTrailing)
            constraint.top.equalTo(avatarImageView.snp.bottom).offset(ProfileHeaderViewConstants.setStatusButtonTop)
            constraint.height.equalTo(ProfileHeaderViewConstants.setStatusButtonHeight)
        }

        statusLabel.snp.makeConstraints { constraint in
            constraint.left.equalTo(avatarImageView.snp.right).offset(ProfileHeaderViewConstants.statusLabelLeading)
            constraint.bottom.equalTo(statusTextField.snp.top).offset(ProfileHeaderViewConstants.statusLabelBottom)
            constraint.right.greaterThanOrEqualTo(contentView.snp.right).offset(ProfileHeaderViewConstants.statusLabelTrailing)
        }

        statusTextField.snp.makeConstraints { constraint in
            constraint.left.equalTo(avatarImageView.snp.right).offset(ProfileHeaderViewConstants.statusTextFieldLeading)
            constraint.bottom.equalTo(setStatusButton.snp.top).offset(ProfileHeaderViewConstants.statusTextFieldBottom)
            constraint.right.greaterThanOrEqualTo(contentView.snp.right).offset(ProfileHeaderViewConstants.statusTextFieldTrailing)
            constraint.height.equalTo(ProfileHeaderViewConstants.statusTextFieldHeight)
        }

        plagEscButton.snp.makeConstraints { constraint in
            constraint.top.equalTo(contentView.snp.top).offset(ProfileHeaderViewConstants.plagEscButtonTop)
            constraint.right.equalTo(contentView.snp.right).offset(ProfileHeaderViewConstants.plagEscButtonTrailing)
            constraint.width.equalTo(ProfileHeaderViewConstants.plagEscButtonWidth)
            constraint.height.equalTo(ProfileHeaderViewConstants.plagEscButtonHeight)
        }
    }
    
    // TF Action
    @objc func statusTextChanged(_ textField: UITextField) {
        guard let text = textField.text else { return }
        statusText = text
    }
    
    // Button Action
    @objc func setStatus() {
        if statusLabel.text != nil && statusText != "" {
            statusLabel.text = statusText
            statusTextField.text = ""
            statusTextField.resignFirstResponder()
        }
    }
    
    // Avatar press action
    
    
    @objc func tapOnAvatar() {
        UIImageView.animate(withDuration: 0.5,
                            animations: {
            self.defaultAvatarCenter = self.avatarImageView.center
            self.avatarImageView.center = CGPoint(x: UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height / 2)
            self.avatarImageView.transform = CGAffineTransform(scaleX: self.contentView.frame.width / self.avatarImageView.frame.width, y: self.contentView.frame.width / self.avatarImageView.frame.width)
            self.avatarImageView.layer.cornerRadius = 0
            self.plagView.alpha = 0.9
            ProfileViewController.postTableView.isScrollEnabled = false
            ProfileViewController.postTableView.cellForRow(at: IndexPath(item: 0, section: 0))?.isUserInteractionEnabled = false
            self.avatarImageView.isUserInteractionEnabled = false
        },
                            completion: { _ in
            UIImageView.animate(withDuration: 0.3) {
                self.plagEscButton.alpha = 1
            }
        })
    }
    
    // Plag View Esc Button Action
    @objc func tapPlagEscButton() {
        UIImageView.animate(withDuration: 0.3,
                            animations: {
            self.plagEscButton.alpha = 0
        },
                            completion: { _ in
            UIImageView.animate(withDuration: 0.5) {
                self.avatarImageView.center = self.defaultAvatarCenter
                self.avatarImageView.transform = CGAffineTransform(scaleX: 1, y: 1)
                self.avatarImageView.layer.cornerRadius = self.avatarImageView.frame.width / 2
                self.plagView.alpha = 0
                ProfileViewController.postTableView.isScrollEnabled = true
                ProfileViewController.postTableView.cellForRow(at: IndexPath(item: 0, section: 0))?.isUserInteractionEnabled = true
                self.avatarImageView.isUserInteractionEnabled = true
            }
        })
    }
}
