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
        addSubview(messageButton)
        addSubview(cameraButton)
        addSubview(callButton)
        addSubview(emailButton)
        addSubview(favouriteButton)
        addSubview(firstNameStaticLabel)
        addSubview(lastNameStaticLabel)
        addSubview(mobileStaticLabel)
        addSubview(emailStaticLabel)
        addSubview(firstNameTextField)
        addSubview(lastNameTextField)
        addSubview(mobileTextField)
        addSubview(emailTextField)
        addSubview(profileImageView)

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
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.layer.borderWidth = 3
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "placeholder_photo")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.textColor = UIColor.navigationTitleColor()
        label.numberOfLines = 1
        return label
    }()
    
    let firstNameStaticLabel: UILabel = {
        let label = UILabel()
        label.text = "First Name"
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
        label.text = "Last Name"
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
        label.text = "mobile"
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
        label.text = "email"
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
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    override func layoutIfNeeded() {
        super.layoutIfNeeded()
        
        profileImageView.layer.cornerRadius = profileImageView.frame.size.height/2

        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = [UIColor.white.cgColor, UIColor.init(hex: "#CAF7ED")!.cgColor]
        gradientLayer.opacity = 0.55
        layer.insertSublayer(gradientLayer, at: 0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupConstraints() {
        if (isUpdatedConstraints == false) {
            isUpdatedConstraints = true
            
            //Need to improve below code
            var constraints = NSLayoutConstraint.constraints(
                withVisualFormat: "V:[superview]-(<=1)-[profileImageView(124)]",
                options: NSLayoutConstraint.FormatOptions.alignAllCenterX,
                metrics: nil,
                views: ["superview":self, "profileImageView":profileImageView]) //Align profileImageView center
            addConstraints(constraints)
            
            constraints = NSLayoutConstraint.constraints(
                withVisualFormat: "V:[superview]-(<=1)-[nameLabel]",
                options: NSLayoutConstraint.FormatOptions.alignAllCenterX,
                metrics: nil,
                views: ["superview":self, "nameLabel":nameLabel]) //Align nameLabel center
            addConstraints(constraints)

            addConstraintsWithFormat("V:|-84-[v0(124)]", views: profileImageView)
            addConstraintsWithFormat("V:|-212-[v0(24)]", views: nameLabel) //84 + 120 + 8 = 212
            
            let screenWidth = UIScreen.main.bounds.width
            let distance = ((screenWidth - (44 * 4)) - 88)/3
            addConstraintsWithFormat("H:|-44-[v0(44)]-\(distance)-[v1(44)]-\(distance)-[v2(44)]-\(distance)-[v3(44)]-44-|", views: messageButton, callButton, emailButton, favouriteButton)
            addConstraintsWithFormat("V:|-260-[v0(44)]", views: messageButton) //212 + 24 + 24 = 260
            addConstraintsWithFormat("V:|-260-[v0(44)]", views: callButton) //212 + 24 + 24 = 260
            addConstraintsWithFormat("V:|-260-[v0(44)]", views: emailButton) //212 + 24 + 24 = 260
            addConstraintsWithFormat("V:|-260-[v0(44)]", views: favouriteButton) //212 + 24 + 24 = 260

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
            addConstraintsWithFormat("H:|-24-[v0(60)]-32-[v1]-10-|", views: firstNameStaticLabel, firstNameTextField)
            addConstraintsWithFormat("V:|-20-[v0(16)]-20-|", views: firstNameStaticLabel)
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
            addConstraintsWithFormat("H:|-24-[v0(60)]-32-[v1]-10-|", views: lastNameStaticLabel, lastNameTextField)
            addConstraintsWithFormat("V:|-20-[v0(16)]-20-|", views: lastNameStaticLabel)
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
            addConstraintsWithFormat("H:|-24-[v0(60)]-32-[v1]-10-|", views: mobileStaticLabel, mobileTextField)
            addConstraintsWithFormat("V:|-20-[v0(16)]-20-|", views: mobileStaticLabel)
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
            addConstraintsWithFormat("H:|-24-[v0(60)]-32-[v1]-10-|", views: emailStaticLabel, emailTextField)
            addConstraintsWithFormat("V:|-20-[v0(16)]-20-|", views: emailStaticLabel)
            addConstraintsWithFormat("V:|[v0(54)]", views: emailTextField)
        }
    }
    
}
