//
//  GKSplashViewController.swift
//  Contacts
//
//  Created by Tirupati Balan on 15/04/19.
//  Copyright © 2019 Tirupati Balan. All rights reserved.
//

import UIKit

class GKSplashViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        GKAPIRequest.contactList({ (response) in
            print(response)
        }) { (error) in
            print(error)
        }
    }

}

