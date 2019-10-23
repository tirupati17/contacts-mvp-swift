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
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.perform(#selector(showMainView), with: nil, afterDelay: 0.1)
    }
    
    @objc func showMainView() {
        UIApplication.shared.delegate?.window??.rootViewController = UINavigationController.init(rootViewController: GKContactListView())
    }

}

