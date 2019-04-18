//
//  GKContactListPresenter.swift
//  Contacts
//
//  Created by Tirupati Balan on 17/04/19.
//  Copyright © 2019 Tirupati Balan. All rights reserved.
//


class GKContactListPresenter {
    var contactListViewProtocol : GKContactListViewProtocol!
}

extension GKContactListPresenter : GKContactListPresenterProtocol {
    
    func didDeleteContact(contact : Contact) {

    }
    
    func didSelectContact(contact : Contact) {

    }
    
    func didUpdateFavourite(forContact : Contact) {

    }
    
    func didFetchContacts() {
        GKAPIRequest.contactList({ (response) in
            if let response = response as? [Contact] {
                self.contactListViewProtocol.updateContactList(response)
            } else {
                self.contactListViewProtocol.updateContactList([])
            }
        }) { (error) in
            self.contactListViewProtocol.didFailedResponse(error)
        }
    }
}
