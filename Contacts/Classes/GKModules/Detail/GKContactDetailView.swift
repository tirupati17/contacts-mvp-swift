//
//  GKContactDetailView.swift
//  Contacts
//
//  Created by Tirupati Balan on 18/04/19.
//  Copyright © 2019 Tirupati Balan. All rights reserved.
//

import Foundation

let contactDetailCellId = "GKContactDetailCellId"
let contactDetailHeaderCellId = "GKContactDetailHeaderCellId"
let contactDetailFirstNameCellId = "GKContactDetailFirstNameCellId"
let contactDetailLastNameCellId = "GKContactDetailLastNameCellId"
let contactDetailMobileCellId = "GKContactDetailMobileCellId"
let contactDetailEmailCellId = "GKContactDetailEmailCellId"

class GKContactDetailView : GKViewController {
    var tableView : UITableView!
    var contactDetailPresenterProtocol : GKContactDetailPresenterProtocol!
    var contact : Contact!
    var isUpdatedConstraints: Bool? = false
    
    override func loadView() {
        super.loadView()
        self.configureDependencies()
        
        tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(GKContactDetailHeaderCell.self, forCellReuseIdentifier: contactDetailHeaderCellId)
        tableView.register(GKContactDetailMobileCell.self, forCellReuseIdentifier: contactDetailMobileCellId)
        tableView.register(GKContactDetailEmailCell.self, forCellReuseIdentifier: contactDetailEmailCellId)

        tableView.separatorColor = UIColor.tableViewSeparatorLineColor()
        tableView.sectionIndexColor = .darkGray
        tableView.sectionIndexBackgroundColor = .clear
        
        view.addSubview(tableView)
        
        self.setupConstraints()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: .edit, target: self, action: #selector(editContact))
    }
    
    func configureDependencies() {
        let contactDetailPresenter = GKContactDetailPresenter()
        contactDetailPresenter.contactDetailViewProtocol = self
        self.contactDetailPresenterProtocol = contactDetailPresenter
    }
    
    func setupConstraints() {
        if (isUpdatedConstraints == false) {
            isUpdatedConstraints = true
            
            view.addConstraintsWithFormat("H:|[v0]|", views: tableView)
            view.addConstraintsWithFormat("V:|[v0]|", views: tableView)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.startViewAnimation()
        
        loadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
    }
    
    override func handleRefresh(_ refreshControl: UIRefreshControl) {
        loadData()
    }
    
    override func didFailedResponse<T>(_ error: T) {
        super.didFailedResponse(error) //Call superview (i.e GKViewController) method didFailedResponse first to initiate common functionality like stop view animations
        
        DispatchQueue.main.async { //optional reload
            self.tableView.reloadData()
        }
    }
    
    override func loadData() {
        self.contactDetailPresenterProtocol.didFetchContactDetail(self.contact.id.toString())
    }
    
    @objc func editContact() {
        
    }
}

extension GKContactDetailView : GKContactDetailViewProtocol {
    func updateContactDetail(_ contact: Contact?) {
        if let contact = contact {
            self.contact = contact
        }
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        self.stopViewAnimation()
    }
}

extension GKContactDetailView : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}


extension GKContactDetailView : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
            case 0:
                return 334
            default:
                return 56
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
            case 0:
                if let cell = tableView.dequeueReusableCell(withIdentifier: contactDetailHeaderCellId) as? GKContactDetailHeaderCell {
                    cell.controller = self
                    if let contact = self.contact {
                        cell.contact = contact
                    }
                    return cell
                }
                break
            case 1:
                if let cell = tableView.dequeueReusableCell(withIdentifier: contactDetailMobileCellId) as? GKContactDetailMobileCell {
                    cell.controller = self
                    if let contact = self.contact {
                        cell.contact = contact
                    }
                    return cell
                }
                break
            case 2:
                if let cell = tableView.dequeueReusableCell(withIdentifier: contactDetailEmailCellId) as? GKContactDetailEmailCell {
                    cell.controller = self
                    if let contact = self.contact {
                        cell.contact = contact
                    }
                    return cell
                }
                break
            default:
                break
        }
        return GKContactDetailCell.init(style: .default, reuseIdentifier: contactDetailCellId)
    }
    
}
