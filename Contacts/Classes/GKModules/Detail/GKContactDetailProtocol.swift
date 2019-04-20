//
//  GKContactDetailProtocol.swift
//  Contacts
//
//  Created by Tirupati Balan on 18/04/19.
//  Copyright © 2019 Tirupati Balan. All rights reserved.
//

protocol GKContactDetailViewProtocol : UIViewControllerProtocol {
    func updateContactDetail(_ contact: Contact?)
    func didSuccessfullyDeleted<T>(_ response : T)
    func didSuccessfullyAdded<T>(_ response : T)
}

protocol GKContactDetailPresenterProtocol {
    func didDeleteContact(contact : Contact)
    func didUpdateFavourite(forContact : Contact)
    func didUpdateContact(forContact : Contact)
    func didCreateContact(forContact : Contact)
    func didFetchContactDetail(_ id: String)
}
