//
//  GKTableViewController.swift
//  Contacts
//
//  Created by Tirupati Balan on 20/04/19.
//  Copyright © 2019 Tirupati Balan. All rights reserved.
//

import Foundation

class GKTableViewController : UITableViewController, UIViewControllerProtocol, StoryboardIdentifiable {
    
    var activityIndicatorView = UIActivityIndicatorView(style: .gray)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(activityIndicatorView)
        
        self.activityIndicatorView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        self.activityIndicatorView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func startViewAnimation() {
        DispatchQueue.main.async {
            self.activityIndicatorView.startAnimating()
        }
    }
    
    func stopViewAnimation() {
        DispatchQueue.main.async {
            self.activityIndicatorView.stopAnimating()
        }
    }
    
    func loadData() {
        self.startViewAnimation()
    }
    
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        
    }
    
    func showAlertWithTitleAndMessage(title: String, message: String, handler: ((UIAlertAction) -> Swift.Void)? = nil) {
        DispatchQueue.main.async {
            let alert = UIAlertController.init(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: handler))
            self.present(alert, animated: true, completion: {
            })
        }
    }
    
    func presentController<T>(_ vc: T) {
        if let vc = vc as? UIViewController {
            present(vc, animated: true) {
                
            }
        }
    }
    
    func pushController<T>(_ vc: T) {
        if let vc = vc as? UIViewController {
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func didFailedResponse<T>(_ error : T) {
        self.stopViewAnimation()
        if let error = error as? GKError {
            self.showAlertWithTitleAndMessage(title: "Error!", message: error.localizedDescription)
        }
    }
    
    func didSuccessfulResponse<T>(_ response: T) {
        self.stopViewAnimation()
    }
    
}
