//
//  GKContactListCell.swift
//  Contacts
//
//  Created by Tirupati Balan on 17/04/19.
//  Copyright © 2019 Tirupati Balan. All rights reserved.
//


class GKContactListCell : GKTableViewCell {
    var controller: GKContactListView?
    var isUpdatedConstraints: Bool? = false

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = UIColor.init(hex: "#F9F9F9") //Cell background color
        addSubview(nameLabel)
        addSubview(profileImageView)
        addSubview(favouriteButton)

        favouriteButton.addTarget(self, action: #selector(favouriteAction), for: .touchUpInside)
        self.setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func favouriteAction() {

    }
    
    var contact : Contact? {
        didSet {
            if let firstName = contact?.firstName, let lastName = contact?.lastName {
                self.nameLabel.text = firstName.capitalized + " " + lastName.capitalized
            }
            if let profileImageUrl = contact?.profilePic {
                self.profileImageView.load(url: URL(string: (GKAPIConstant.sharedConstant.baseUrl() + profileImageUrl))!)
            }
            favouriteButton.setImage(contact?.favorite ?? false ? UIImage(named: "home_favourite") : nil, for: .normal)
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

    let favouriteButton = GKContactListCell.buttonForTitle("", imageName: "favourite_button")

    static func buttonForTitle(_ title: String, imageName: String) -> UIButton {
        let button = UIButton()
        button.setTitle(title, for: UIControl.State())
        button.setTitleColor(UIColor.lightGray, for: UIControl.State())
        
        button.setImage(UIImage(named: imageName), for: UIControl.State())
        button.setImage(UIImage(named: "favourite_button_selected"), for: .selected)
        button.setImage(UIImage(named: "favourite_button_selected"), for: .highlighted)
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 0)
        
        return button
    }

    func setupConstraints() {
        if (isUpdatedConstraints == false) {
            isUpdatedConstraints = true
            
            //As per given pdf size intructions
            addConstraintsWithFormat("H:|-16-[v0(40)]-16-[v1][v2(40)]-32-|", views: profileImageView, nameLabel, favouriteButton)
            
            addConstraintsWithFormat("V:|-12-[v0(40)]", views: profileImageView)
            addConstraintsWithFormat("V:|-24-[v0(16)]", views: nameLabel)
            addConstraintsWithFormat("V:|-12-[v0(40)]", views: favouriteButton)
        }
    }
}
