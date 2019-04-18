//
//  GKSplashViewController.swift
//  Contacts
//
//  Created by Tirupati Balan on 15/04/19.
//  Copyright © 2019 Tirupati Balan. All rights reserved.
//

import UIKit

class GKSplashViewController: GKViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let vc = GKContactListView()
        let nv = UINavigationController.init(rootViewController: vc)
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            self.presentController(nv)
        }
    }

}

