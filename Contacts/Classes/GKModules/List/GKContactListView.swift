//
//  GKContactListView.swift
//  Contacts
//
//  Created by Tirupati Balan on 17/04/19.
//  Copyright © 2019 Tirupati Balan. All rights reserved.
//

let contactListCellId = "GKContactListCellId"

class GKContactListView : GKViewController {
    var tableView : UITableView!
    var contactListPresenterProtocol : GKContactListPresenterProtocol!
    var contacts = [Contact]()
    var isUpdatedConstraints: Bool? = false
    var sections = [Section]()
    struct Section {
        let letter : String
        let contacts : [Contact]
    }
    
    override func loadView() {
        super.loadView()
        self.configureDependencies()
        
        tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(GKContactListCell.self, forCellReuseIdentifier: contactListCellId)
        
        tableView.separatorColor = UIColor.tableViewSeparatorLineColor()
        tableView.backgroundColor = UIColor.tableViewBackgroundColor()
        tableView.sectionIndexColor = .darkGray
        tableView.sectionIndexBackgroundColor = .clear
        tableView.refreshControl = self.refreshControl
        
        view.addSubview(tableView)
        
        self.setupConstraints()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Contact"
        navigationItem.rightBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: .add, target: self, action: #selector(addContact))
        navigationItem.leftBarButtonItem = UIBarButtonItem.init(title: "Groups", style: .plain, target: self, action: #selector(groupAction))
        super.loadData()
    }
    
    func configureDependencies() {
        let contactListPresenter = GKContactListPresenter()
        contactListPresenter.contactListViewProtocol = self
        self.contactListPresenterProtocol = contactListPresenter
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
        self.contactListPresenterProtocol.didFetchContacts()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
    }
    
    override func handleRefresh(_ refreshControl: UIRefreshControl) {
        self.contactListPresenterProtocol.didFetchContacts()
    }
    
    override func loadData() { //load with activity indicator
        super.loadData()
        self.contactListPresenterProtocol.didFetchContacts()
    }
    
    override func didFailedResponse<T>(_ error: T) {
        super.didFailedResponse(error) //Call superview (i.e GKViewController) method didFailedResponse first to initiate common functionality like stop view animations
        
        DispatchQueue.main.async { //optional reload
            self.tableView.reloadData()
        }
    }
    
    @objc func addContact() {
        let contactDetailView = GKContactDetailView()
        contactDetailView.viewMode = .add
        contactDetailView.dismissProtocol = self
        self.presentController(UINavigationController.init(rootViewController: contactDetailView))
    }
    
    @objc func groupAction() {
        
    }
}

extension GKContactListView : DismissProtocol {
    func dismiss(_ sender : Any) { //Load data after contact add

    }
}

extension GKContactListView : GKContactListViewProtocol {

    func updateContactList(_ contacts: [Contact]) {
        self.contacts = contacts
        
        /*
         Dictionary(grouping:by:) introduced in Swift 4.0
         Ref: https://developer.apple.com/documentation/swift/dictionary/2995342-init
         */
        
        let groupedDictionary = Dictionary(grouping: self.contacts, by: {String($0.firstName!.prefix(1))}) // group contact array to ["A" : ["Amitabh", "Ashish", "Abhishek"], "S" : ["Shah Rukh", "Salman"], "B" : ["Balan"]]
        
        let keys = groupedDictionary.keys.sorted() // get all keys and sort it in ascending order i.e keys become ["A", "B", "S"]
        
        self.sections = keys.map{ Section(letter: $0, contacts: groupedDictionary[$0]!.sorted(by: { $0.firstName! > $1.firstName!}))} // map sorted keys to section struct i.e if $0 = "A" then letter = "A", groupedDictionary[$0]! = ["Amitabh", "Ashish", "Abhishek"] and after sorted groupedDictionary[$0]! = ["Amitabh", "Abhishek", "Ashish"]
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        self.stopViewAnimation()
    }
    
    func updateFavouriteStatus() {
        
    }
}

extension GKContactListView : UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 64
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if let contact = self.sections[safe : indexPath.section]?.contacts[safe : indexPath.row] {
            let contactDetailView = GKContactDetailView()
            contactDetailView.contact = contact
            self.pushController(contactDetailView)
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        view.tintColor = UIColor.tableViewGroupHeaderColor()
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.textColor = UIColor.black
    }

}

extension GKContactListView : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.sections[section].contacts.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.sections.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: contactListCellId) as? GKContactListCell {
            cell.controller = self
            if let contact = self.sections[safe : indexPath.section]?.contacts[safe : indexPath.row] {
                cell.contact = contact
            }
            return cell
        }
        return GKContactListCell.init(style: .default, reuseIdentifier: contactListCellId)
    }
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return sections.map{$0.letter}
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section].letter
    }
    
}
