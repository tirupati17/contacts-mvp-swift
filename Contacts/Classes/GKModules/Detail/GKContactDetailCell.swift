//
//  GKContactDetailCell.swift
//  Contacts
//
//  Created by Tirupati Balan on 18/04/19.
//  Copyright © 2019 Tirupati Balan. All rights reserved.
//

import Foundation

class GKContactDetailCell : GKTableViewCell {
    var controller: GKContactDetailView?
    var isUpdatedConstraints: Bool? = false
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(nameLabel)
        addSubview(profileImageView)
        addSubview(messageButton)
        addSubview(cameraButton)
        addSubview(emailButton)
        addSubview(favouriteButton)
        addSubview(firstNameTextField)
        addSubview(lastNameTextField)
        addSubview(mobileTextField)
        addSubview(emailTextField)

        messageButton.addTarget(self, action: #selector(messageAction), for: .touchUpInside)
        cameraButton.addTarget(self, action: #selector(cameraAction), for: .touchUpInside)
        callButton.addTarget(self, action: #selector(callAction), for: .touchUpInside)
        emailButton.addTarget(self, action: #selector(emailAction), for: .touchUpInside)
        favouriteButton.addTarget(self, action: #selector(favouriteAction), for: .touchUpInside)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func cameraAction() {
        
    }

    @objc func favouriteAction() {
        
    }
    
    @objc func callAction() {
        
    }
    
    @objc func emailAction() {
        
    }
    
    @objc func messageAction() {
        
    }
    
    var contact : Contact? {
        didSet {
            if let firstName = contact?.firstName, let lastName = contact?.lastName {
                self.nameLabel.text = firstName.capitalized + " " + lastName.capitalized
            }
            
            if let profileImageUrl = contact?.profilePic {
                self.profileImageView.load(url: URL(string: (GKAPIConstant.sharedConstant.baseUrl() + profileImageUrl))!)
            }
            favouriteButton.setImage(contact?.favorite ?? false ? UIImage(named: "favourite_button_selected") : UIImage(named: "favourite_button"), for: .normal)
            
            if let firstName = contact?.firstName {
                self.firstNameTextField.text = firstName.capitalized
            }
            
            if let lastName = contact?.lastName {
                self.lastNameTextField.text = lastName.capitalized
            }
            
            if let mobile = contact?.phoneNumber {
                self.mobileTextField.text = mobile
            }
            
            if let email = contact?.email {
                self.emailTextField.text = email
            }
        }
    }
    
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 20
        imageView.layer.borderColor = UIColor.init(white: 0.96, alpha: 1).cgColor
        imageView.layer.borderWidth = 1
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = UIColor.navigationTitleColor()
        label.numberOfLines = 1
        return label
    }()
    
    let firstNameStaticLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = UIColor.navigationTitleColor(a: 0.5)
        label.numberOfLines = 1
        return label
    }()
    
    let firstNameTextField: UITextField = {
        let textField = UITextField()
        textField.font = UIFont.boldSystemFont(ofSize: 16)
        textField.textColor = UIColor.navigationTitleColor(a: 1.0)
        textField.isUserInteractionEnabled = false
        return textField
    }()
    
    let lastNameStaticLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = UIColor.navigationTitleColor(a: 0.5)
        label.numberOfLines = 1
        return label
    }()
    
    let lastNameTextField: UITextField = {
        let textField = UITextField()
        textField.font = UIFont.boldSystemFont(ofSize: 16)
        textField.textColor = UIColor.navigationTitleColor(a: 1.0)
        textField.isUserInteractionEnabled = false
        return textField
    }()

    let mobileStaticLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = UIColor.navigationTitleColor(a: 0.5)
        label.numberOfLines = 1
        return label
    }()
    
    let mobileTextField: UITextField = {
        let textField = UITextField()
        textField.font = UIFont.boldSystemFont(ofSize: 16)
        textField.textColor = UIColor.navigationTitleColor(a: 1.0)
        textField.isUserInteractionEnabled = false
        return textField
    }()
    
    let emailStaticLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = UIColor.navigationTitleColor(a: 0.5)
        label.numberOfLines = 1
        return label
    }()
    
    let emailTextField: UITextField = {
        let textField = UITextField()
        textField.font = UIFont.boldSystemFont(ofSize: 16)
        textField.textColor = UIColor.navigationTitleColor(a: 1.0)
        textField.isUserInteractionEnabled = false
        return textField
    }()

    let messageButton = GKContactListCell.buttonForTitle("message", imageName: "message_button")
    let cameraButton = GKContactListCell.buttonForTitle("", imageName: "camera_button")
    let callButton = GKContactListCell.buttonForTitle("call", imageName: "call_button")
    let emailButton = GKContactListCell.buttonForTitle("email", imageName: "email_button")
    let favouriteButton = GKContactListCell.buttonForTitle("favourite", imageName: "favourite_button")
    
    static func buttonForTitle(_ title: String, imageName: String) -> UIButton {
        let button = UIButton()
        button.setTitle(title, for: UIControl.State())
        button.setTitleColor(UIColor.lightGray, for: UIControl.State())
        
        button.setImage(UIImage(named: imageName), for: UIControl.State())
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 0)
        
        return button
    }
    
}

class GKContactDetailHeaderCell : GKContactDetailCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupConstraints() {
        if (isUpdatedConstraints == false) {
            isUpdatedConstraints = true
            
        }
    }
}

class GKContactDetailFirstNameCell : GKContactDetailCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupConstraints() {
        if (isUpdatedConstraints == false) {
            isUpdatedConstraints = true
            
            //As per given pdf size intructions
            addConstraintsWithFormat("H:|-24-[v0(60)]-32-[v1]|", views: firstNameStaticLabel, firstNameTextField)
            addConstraintsWithFormat("V:|-20-[v0(16)-20-]", views: firstNameStaticLabel)
            addConstraintsWithFormat("V:|[v0(54)]", views: firstNameTextField)
        }
    }

}

class GKContactDetailLastNameCell : GKContactDetailCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupConstraints() {
        if (isUpdatedConstraints == false) {
            isUpdatedConstraints = true
            
            //As per given pdf size intructions
            addConstraintsWithFormat("H:|-24-[v0(60)]-32-[v1]|", views: lastNameStaticLabel, lastNameTextField)
            addConstraintsWithFormat("V:|-20-[v0(16)-20-]", views: lastNameStaticLabel)
            addConstraintsWithFormat("V:|[v0(54)]", views: lastNameTextField)
        }
    }
    
}

class GKContactDetailMobileCell : GKContactDetailCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupConstraints() {
        if (isUpdatedConstraints == false) {
            isUpdatedConstraints = true
            
            //As per given pdf size intructions
            addConstraintsWithFormat("H:|-24-[v0(60)]-32-[v1]|", views: mobileStaticLabel, mobileTextField)
            addConstraintsWithFormat("V:|-20-[v0(16)-20-]", views: mobileStaticLabel)
            addConstraintsWithFormat("V:|[v0(54)]", views: mobileTextField)
        }
    }
    
}

class GKContactDetailEmailCell : GKContactDetailCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupConstraints() {
        if (isUpdatedConstraints == false) {
            isUpdatedConstraints = true
            
            //As per given pdf size intructions
            addConstraintsWithFormat("H:|-24-[v0(60)]-32-[v1]|", views: emailStaticLabel, emailTextField)
            addConstraintsWithFormat("V:|-20-[v0(16)-20-]", views: emailStaticLabel)
            addConstraintsWithFormat("V:|[v0(54)]", views: emailTextField)
        }
    }
    
}
