//
//  GKContactDetailCell.swift
//  Contacts
//
//  Created by Tirupati Balan on 18/04/19.
//  Copyright © 2019 Tirupati Balan. All rights reserved.
//

import Foundation

enum ButtonTag : Int {
    case messageButtonTag = 1
    case cameraButtonTag = 2
    case callButtonTag = 3
    case emailButtonTag = 4
    case favouriteButtonTag = 5
    case undefinedTag = 0
}

enum TextFieldTag : Int {
    case firstNameFieldTag = 1
    case lastNameFieldTag = 2
    case emailFieldTag = 3
    case phoneNumberFieldTag = 4
    case undefinedTag = 0
}

class GKContactDetailCell : GKTableViewCell {
    var controller: GKContactDetailView?
    var isUpdatedConstraints: Bool? = false
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(nameLabel)
        addSubview(messageButton)
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
        addSubview(cameraButton)

        cameraButton.addTarget(self, action: #selector(self.buttonAction(_:)), for: .touchUpInside)
        messageButton.addTarget(self, action: #selector(self.buttonAction(_:)), for: .touchUpInside)
        callButton.addTarget(self, action: #selector(self.buttonAction(_:)), for: .touchUpInside)
        emailButton.addTarget(self, action: #selector(self.buttonAction(_:)), for: .touchUpInside)
        favouriteButton.addTarget(self, action: #selector(self.buttonAction(_:)), for: .touchUpInside)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
        label.textAlignment = .center
        return label
    }()
    
    let firstNameStaticLabel: UILabel = {
        let label = UILabel()
        label.text = "First Name"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textAlignment = .right
        label.textColor = UIColor.navigationTitleColor(a: 0.5)
        label.numberOfLines = 1
        return label
    }()
    
    let firstNameTextField: UITextField = {
        let textField = UITextField()
        textField.font = UIFont.boldSystemFont(ofSize: 16)
        textField.tag = TextFieldTag.firstNameFieldTag.rawValue
        textField.placeholder = "Enter first name"
        textField.textColor = UIColor.navigationTitleColor(a: 1.0)
        textField.isUserInteractionEnabled = false
        return textField
    }()
    
    let lastNameStaticLabel: UILabel = {
        let label = UILabel()
        label.text = "Last Name"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textAlignment = .right
        label.textColor = UIColor.navigationTitleColor(a: 0.5)
        label.numberOfLines = 1
        return label
    }()
    
    let lastNameTextField: UITextField = {
        let textField = UITextField()
        textField.font = UIFont.boldSystemFont(ofSize: 16)
        textField.tag = TextFieldTag.lastNameFieldTag.rawValue
        textField.placeholder = "Enter last name"
        textField.textColor = UIColor.navigationTitleColor(a: 1.0)
        textField.isUserInteractionEnabled = false
        return textField
    }()

    let mobileStaticLabel: UILabel = {
        let label = UILabel()
        label.text = "Mobile"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textAlignment = .right
        label.textColor = UIColor.navigationTitleColor(a: 0.5)
        label.numberOfLines = 1
        return label
    }()
    
    let mobileTextField: UITextField = {
        let textField = UITextField()
        textField.font = UIFont.boldSystemFont(ofSize: 16)
        textField.placeholder = "Enter mobile"
        textField.tag = TextFieldTag.phoneNumberFieldTag.rawValue
        textField.textColor = UIColor.navigationTitleColor(a: 1.0)
        textField.isUserInteractionEnabled = false
        return textField
    }()
    
    let emailStaticLabel: UILabel = {
        let label = UILabel()
        label.text = "Email"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textAlignment = .right
        label.textColor = UIColor.navigationTitleColor(a: 0.5)
        label.numberOfLines = 1
        return label
    }()
    
    let emailTextField: UITextField = {
        let textField = UITextField()
        textField.font = UIFont.boldSystemFont(ofSize: 16)
        textField.placeholder = "Enter email"
        textField.tag = TextFieldTag.emailFieldTag.rawValue
        textField.textColor = UIColor.navigationTitleColor(a: 1.0)
        textField.isUserInteractionEnabled = false
        return textField
    }()

    let messageButton = GKContactDetailCell.buttonForTitle("message", imageName: "message_button", tag: .messageButtonTag)
    let cameraButton = GKContactDetailCell.buttonForTitle("camera", imageName: "camera_button", tag: .cameraButtonTag)
    let callButton = GKContactDetailCell.buttonForTitle("call", imageName: "call_button", tag: .callButtonTag)
    let emailButton = GKContactDetailCell.buttonForTitle("email", imageName: "email_button", tag: .emailButtonTag)
    let favouriteButton = GKContactDetailCell.buttonForTitle("favourite", imageName: "favourite_button", tag: .favouriteButtonTag)
    
    static func buttonForTitle(_ title: String, imageName: String, tag: ButtonTag) -> UIButton {
        let button = UIButton()
        button.tag = tag.rawValue
        button.setTitle(title, for: UIControl.State())
        button.setTitleColor(UIColor.lightGray, for: UIControl.State())
        button.setImage(UIImage(named: imageName), for: UIControl.State())
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 0)
        return button
    }
    
    @objc func buttonAction(_ sender : UIButton) {
        if let controller = self.controller {
            switch sender.tag {
                case ButtonTag.cameraButtonTag.rawValue:
                    controller.cameraAction(self)
                    break
                case ButtonTag.favouriteButtonTag.rawValue:
                    if let contact = self.contact {
                        self.contact?.favorite = !(contact.favorite)
                    }
                    controller.favouriteAction(self)
                    break
                case ButtonTag.callButtonTag.rawValue:
                    controller.callAction(self)
                    break
                case ButtonTag.emailButtonTag.rawValue:
                    controller.emailAction(self)
                    break
                case ButtonTag.messageButtonTag.rawValue:
                    controller.messageAction(self)
                    break
                default:
                    break
            }
        }
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

        _ = contentView.layer.sublayers?.popLast()
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = [UIColor.white.cgColor, UIColor.init(hex: "#CAF7ED")!.cgColor]
        gradientLayer.opacity = 0.55
        contentView.layer.addSublayer(gradientLayer)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupConstraints() {
        if (isUpdatedConstraints == false) {
            isUpdatedConstraints = true
            let screenWidth = UIScreen.main.bounds.width

            //WTF! Need to improve below code
            var xCenter = (screenWidth/2) - 62 // 124/2 = 62
            addConstraintsWithFormat("H:|-\(xCenter)-[v0(124)]", views: profileImageView)
            addConstraintsWithFormat("V:|-84-[v0(124)]", views: profileImageView)

            addConstraintsWithFormat("H:|-\((xCenter + 80))-[v0(44)]", views: cameraButton)
            addConstraintsWithFormat("V:|-160-[v0(44)]", views: cameraButton) //84 + 120 - 44 = 160
            
            xCenter = (screenWidth/2) - 100 // 200/2 = 100
            addConstraintsWithFormat("H:|-\(xCenter)-[v0(200)]", views: nameLabel)
            addConstraintsWithFormat("V:|-212-[v0(24)]", views: nameLabel) //84 + 120 + 8 = 212
            
            let distance = ((screenWidth - (44 * 4)) - 88)/3
            addConstraintsWithFormat("H:|-44-[v0(44)]-\(distance)-[v1(44)]-\(distance)-[v2(44)]-\(distance)-[v3(44)]", views: messageButton, callButton, emailButton, favouriteButton)
            addConstraintsWithFormat("V:|-260-[v0(44)]", views: messageButton) //212 + 24 + 24 = 260
            addConstraintsWithFormat("V:|-260-[v0(44)]", views: callButton)
            addConstraintsWithFormat("V:|-260-[v0(44)]", views: emailButton)
            addConstraintsWithFormat("V:|-260-[v0(44)]", views: favouriteButton)

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
            addConstraintsWithFormat("H:|-24-[v0(100)]-32-[v1]-10-|", views: firstNameStaticLabel, firstNameTextField)
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
            addConstraintsWithFormat("H:|-24-[v0(100)]-32-[v1]-10-|", views: lastNameStaticLabel, lastNameTextField)
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
            addConstraintsWithFormat("H:|-24-[v0(100)]-32-[v1]-10-|", views: mobileStaticLabel, mobileTextField)
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
            addConstraintsWithFormat("H:|-24-[v0(100)]-32-[v1]-10-|", views: emailStaticLabel, emailTextField)
            addConstraintsWithFormat("V:|-20-[v0(16)]-20-|", views: emailStaticLabel)
            addConstraintsWithFormat("V:|[v0(54)]", views: emailTextField)
        }
    }
    
}
