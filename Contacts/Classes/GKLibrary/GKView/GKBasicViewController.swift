//
//  GKBasicViewController.swift
//  Contacts
//
//  Created by Tirupati Balan on 15/04/19.
//  Copyright © 2019 Tirupati Balan. All rights reserved.
//

import Foundation
import UIKit

protocol DismissProtocol {
    func dismiss(_ sender : Any)
}

protocol PopViewProtocol {
    func popView(_ sender : Any)
}

class GKBasicViewController : UIViewController {
    var dismissProtocol : DismissProtocol!
    var popViewProtocol : PopViewProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func dismiss() {
        if ((self.dismissProtocol) != nil) {
            self.dismissProtocol.dismiss(self)
        }
    }
    
    func dismissSelf() {
        self.dismiss(animated: true) { //Trying to dismiss from default dismiss func of view controller
            self.dismiss() //If not then trying to look into via calling dismiss func of DismissProtocol
        }
    }
    
    func popViewController() {
        self.dismiss() //Check if dismiss protocol assign so that calling protocol func become priority
        if ((self.popViewProtocol) != nil) {
            self.popViewProtocol.popView(self)
        } else { //If no protocol assignment call popViewController manually
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    func goBack() {
        if ((self.navigationController) != nil) { //navigation pop priority
            self.popViewController()
        }
        self.dismiss()
    }

}
