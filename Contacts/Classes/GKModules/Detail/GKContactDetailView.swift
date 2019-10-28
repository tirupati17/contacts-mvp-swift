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

class GKContactDetailView : GKTableViewController {
    var contactDetailPresenterProtocol : GKContactDetailPresenterProtocol!
    var contact : Contact!
    var isUpdatedConstraints : Bool? = false
    var viewMode : ViewMode = .view
    var contactDetailCell : GKContactDetailCell? = nil
    
    override func loadView() {
        super.loadView()
        self.configureDependencies()
        
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
        
        self.setupConstraints()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let nv = navigationController {
            nv.navigationBar.setBackgroundImage(UIImage(), for: .default)
            nv.navigationBar.shadowImage = UIImage()
            nv.navigationBar.isTranslucent = false
        }

        switch self.viewMode {
            case .add:
                navigationItem.leftBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: .cancel, target: self, action: #selector(cancelAdd))
                navigationItem.rightBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: .save, target: self, action: #selector(addContact))
                
                self.contact = Contact(id: 0, firstName: "", lastName: "", email: "", phoneNumber: "", profilePic: "", favorite: false, createdAt: "", updatedAt: "")
                self.viewMode = .add
                break
            default:
                navigationItem.rightBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: .edit, target: self, action: #selector(editContact))
                loadData()
                break
        }
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
            
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
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
        if let contact = self.contact {
            self.contactDetailPresenterProtocol.didFetchContactDetail(contact.id.toString())
        }
    }
    
    @objc func editContact() {
        navigationItem.leftBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: .cancel, target: self, action: #selector(cancelEdit))
        navigationItem.rightBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: .done, target: self, action: #selector(doneEdit))

        self.viewMode = .edit
        self.tableView.reloadData()
        self.tableView.layoutIfNeeded()
    }
    
    @objc func doneEdit() {
        navigationItem.leftBarButtonItem = nil
        navigationItem.rightBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: .edit, target: self, action: #selector(editContact))

        self.viewMode = .view
        self.tableView.reloadData()
        self.tableView.layoutIfNeeded()
        
        self.startViewAnimation()
        if let contact = self.contact {
            self.contactDetailPresenterProtocol.didUpdateContact(forContact: contact)
        }
    }
    
    @objc func addContact() {
        if let contact = self.contact {
            if let firstName = contact.firstName, firstName.count == 0 {
                self.showAlertWithTitleAndMessage(title: "Validation Error!", message: "First name field can not be blank.")
                return
            }
            if let lastName = contact.lastName, lastName.count == 0 {
                self.showAlertWithTitleAndMessage(title: "Validation Error!", message: "Last name field can not be blank.")
                return
            }
            if let email = contact.email, email.isValidEmail() == false {
                self.showAlertWithTitleAndMessage(title: "Validation Error!", message: "Invalid email id.")
                return
            }
            self.startViewAnimation()
            self.contactDetailPresenterProtocol.didCreateContact(forContact: contact)
        }
    }
    
    @objc func cancelAdd() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func cancelEdit() {
        navigationItem.leftBarButtonItem = nil
        navigationItem.rightBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: .edit, target: self, action: #selector(editContact))
        self.viewMode = .view
        self.tableView.reloadData()
        self.tableView.layoutIfNeeded()
    }
    
    @objc func cameraAction(_ cell : GKContactDetailCell) {
        contactDetailCell = cell
        DispatchQueue.main.async {
            let imagePicker = UIImagePickerController()
            if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum){
                imagePicker.delegate = self
                imagePicker.sourceType = .savedPhotosAlbum
                imagePicker.allowsEditing = false
                self.present(imagePicker, animated: true, completion: nil)
            }
        }
    }
    
    @objc func favouriteAction(_ cell : GKContactDetailCell) {
        if let contact = cell.contact {
            self.contactDetailPresenterProtocol.didUpdateContact(forContact: contact)
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    @objc func callAction(_ cell : GKContactDetailCell) {
        if let contact = cell.contact {
            if let url = URL(string: "tel://\(contact.phoneNumber ?? "")") {
                if UIApplication.shared.canOpenURL(url) {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                }
            }
        }
    }
    
    @objc func emailAction(_ cell : GKContactDetailCell) {
        if let contact = cell.contact {
            if let url = URL(string: "mailto:\(contact.email ?? "")") {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
    }
    
    @objc func messageAction(_ cell : GKContactDetailCell) {
        if let contact = cell.contact {
            if let url = URL(string: "sms:\(contact.phoneNumber ?? "")") {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
    }
    
    @objc func deleteAction() {
        if let contact = self.contact {
            self.startViewAnimation()
            self.contactDetailPresenterProtocol.didDeleteContact(contact: contact)
        }
    }
    
}

extension GKContactDetailView : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            DispatchQueue.main.async {
                if let cell = self.contactDetailCell {
                    cell.profileImageView.image = image
                }
            }
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController!, didFinishPickingImage image: UIImage!, editingInfo: NSDictionary!){

    }
}

extension GKContactDetailView : GKContactDetailViewProtocol {
    
    func didSuccessfullyAdded<T>(_ response : T) {
        self.stopViewAnimation()
        DispatchQueue.main.async {
            self.dismiss(animated: true, completion: nil)
        }
    }

    func didSuccessfullyDeleted<T>(_ response : T) {
        self.stopViewAnimation()
        DispatchQueue.main.async {
            if let navigationController = self.navigationController {
                navigationController.popViewController(animated: true)
            }
        }
    }

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

extension GKContactDetailView {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension GKContactDetailView  {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch self.viewMode {
            case .add, .edit:
                return 5
            default:
                return 3
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
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

    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return self.viewMode == .edit || self.viewMode == .view ? 50 : 0
    }

    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let button = UIButton()
        button.frame = CGRect(x: 0, y: 0, width: tableView.frame.width, height: 50)
        button.setTitle("Delete", for: .normal)
        button.setTitleColor(UIColor.red, for: .normal)
        button.addTarget(self, action: #selector(self.deleteAction), for: .touchUpInside)
        return button
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
            case 0:
                if let cell = tableView.dequeueReusableCell(withIdentifier: contactDetailHeaderCellId) as? GKContactDetailHeaderCell {
                    cell.controller = self
                    cell.cameraButton.isHidden = (self.viewMode == .view)
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
                    cell.mobileTextField.delegate = self
                    cell.mobileTextField.keyboardType = .phonePad
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
                    cell.emailTextField.delegate = self
                    cell.mobileTextField.autocapitalizationType = .none
                    cell.mobileTextField.keyboardType = .emailAddress
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
                    cell.firstNameTextField.delegate = self
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
                    cell.lastNameTextField.delegate = self
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

extension GKContactDetailView : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let text = textField.text, let range = Range.init(range, in: text) {
            let updatedText = text.replacingCharacters(in: range, with: string)
            switch textField.tag {
                case TextFieldTag.emailFieldTag.rawValue:
                    self.contact.email = updatedText
                    break
                case TextFieldTag.phoneNumberFieldTag.rawValue:
                    self.contact.phoneNumber = updatedText
                    break
                case TextFieldTag.firstNameFieldTag.rawValue:
                    self.contact.firstName = updatedText
                    break
                case TextFieldTag.lastNameFieldTag.rawValue:
                    self.contact.lastName = updatedText
                    break
            default:
                    break
            }
        }
        return true
    }

}
