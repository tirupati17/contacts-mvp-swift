//
//  GKViewController.swift
//  Contacts
//
//  Created by Tirupati Balan on 15/04/19.
//  Copyright © 2019 Tirupati Balan. All rights reserved.
//


class GKViewController : GKBasicViewController, UIViewControllerProtocol, StoryboardIdentifiable {
    var activityIndicatorView = UIActivityIndicatorView(style: .gray)
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(self.handleRefresh(_:)), for: UIControl.Event.valueChanged)
        return refreshControl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(activityIndicatorView)
        
        self.activityIndicatorView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        self.activityIndicatorView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
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
            self.refreshControl.endRefreshing()
        }
    }
    
    func loadData() {
        self.startViewAnimation()
    }
    
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        
    }
    
    func showAlertWithTitleAndMessage(title: String, message: String, handler: ((UIAlertAction) -> Swift.Void)? = nil) {
        let alert = UIAlertController.init(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: handler))
        self.present(alert, animated: true, completion: {
        })
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
    }
}
