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

enum ViewMode {
    case add
    case edit
    case view
}

class GKContactDetailView : GKViewController {
    var tableView : UITableView!
    var contactDetailPresenterProtocol : GKContactDetailPresenterProtocol!
    var contact : Contact!
    var isUpdatedConstraints : Bool? = false
    var viewMode : ViewMode = .view
    
    override func loadView() {
        super.loadView()
        self.configureDependencies()
        
        tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(GKContactDetailHeaderCell.self, forCellReuseIdentifier: contactDetailHeaderCellId)
        tableView.register(GKContactDetailMobileCell.self, forCellReuseIdentifier: contactDetailMobileCellId)
        tableView.register(GKContactDetailEmailCell.self, forCellReuseIdentifier: contactDetailEmailCellId)
        tableView.register(GKContactDetailFirstNameCell.self, forCellReuseIdentifier: contactDetailFirstNameCellId)
        tableView.register(GKContactDetailLastNameCell.self, forCellReuseIdentifier: contactDetailLastNameCellId)

        tableView.separatorColor = UIColor.tableViewSeparatorLineColor()
        tableView.sectionIndexColor = .darkGray
        tableView.sectionIndexBackgroundColor = .clear
        tableView.tableFooterView = UIView.init()
        
        view.addSubview(tableView)
        
        self.setupConstraints()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController!.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController!.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = false

        navigationItem.rightBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: .edit, target: self, action: #selector(editContact))
    }
    
    override func viewWillDisappear(_ animated: Bool) {
         super.viewWillDisappear(animated)
         self.navigationController?.navigationBar.shadowImage = nil
         self.navigationController?.navigationBar.isTranslucent = false
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
        super.loadData()
        self.contactDetailPresenterProtocol.didFetchContactDetail(self.contact.id.toString())
    }
    
    @objc func editContact() {
        navigationItem.rightBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: .cancel, target: self, action: #selector(cancelEdit))

        self.viewMode = .edit
        self.tableView.reloadData()
        self.tableView.layoutIfNeeded()
    }
    
    @objc func cancelEdit() {
        navigationItem.rightBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: .edit, target: self, action: #selector(editContact))
        self.viewMode = .view
        self.tableView.reloadData()
        self.tableView.layoutIfNeeded()
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
        switch self.viewMode {
            case .add, .edit:
                return 5
            default:
                return 3
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch self.viewMode {
            case .add, .edit:
                switch indexPath.row {
                    case 0:
                        return 250
                    default:
                        return 56
                }
            default:
                switch indexPath.row {
                    case 0:
                        return 334
                    default:
                        return 56
                }
        }

    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
            case 0:
                if let cell = tableView.dequeueReusableCell(withIdentifier: contactDetailHeaderCellId) as? GKContactDetailHeaderCell {
                    cell.controller = self
                    cell.emailButton.isHidden = (self.viewMode == .edit || self.viewMode == .add)
                    cell.callButton.isHidden = (self.viewMode == .edit || self.viewMode == .add)
                    cell.messageButton.isHidden = (self.viewMode == .edit || self.viewMode == .add)
                    cell.favouriteButton.isHidden = (self.viewMode == .edit || self.viewMode == .add)
                    
                    cell.cameraButton.isHidden = !(self.viewMode == .edit || self.viewMode == .add)
                    cell.layoutIfNeeded()
                    if let contact = self.contact {
                        cell.contact = contact
                    }
                    return cell
                }
                break
            case 1:
                if let cell = tableView.dequeueReusableCell(withIdentifier: contactDetailMobileCellId) as? GKContactDetailMobileCell {
                    cell.controller = self
                    cell.mobileTextField.isUserInteractionEnabled = (self.viewMode == .edit || self.viewMode == .add)
                    if let contact = self.contact {
                        cell.contact = contact
                    }
                    return cell
                }
                break
            case 2:
                if let cell = tableView.dequeueReusableCell(withIdentifier: contactDetailEmailCellId) as? GKContactDetailEmailCell {
                    cell.controller = self
                    cell.emailTextField.isUserInteractionEnabled = (self.viewMode == .edit || self.viewMode == .add)
                    if let contact = self.contact {
                        cell.contact = contact
                    }
                    return cell
                }
                break
            case 3:
                if let cell = tableView.dequeueReusableCell(withIdentifier: contactDetailFirstNameCellId) as? GKContactDetailFirstNameCell {
                    cell.controller = self
                    cell.firstNameTextField.isUserInteractionEnabled = true
                    if let contact = self.contact {
                        cell.contact = contact
                    }
                    return cell
                }
                break
            case 4:
                if let cell = tableView.dequeueReusableCell(withIdentifier: contactDetailLastNameCellId) as? GKContactDetailLastNameCell {
                    cell.controller = self
                    cell.lastNameTextField.isUserInteractionEnabled = true
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
