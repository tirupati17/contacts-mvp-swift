//
//  GKContactDetailPresenter.swift
//  Contacts
//
//  Created by Tirupati Balan on 18/04/19.
//  Copyright © 2019 Tirupati Balan. All rights reserved.
//

import Foundation

class GKContactDetailPresenter {
    var contactDetailViewProtocol : GKContactDetailViewProtocol!
}

extension GKContactDetailPresenter : GKContactDetailPresenterProtocol {
    
    func didFetchContactDetail(_ id: String) {
        GKAPIRequest.contactDetail(id, success: { (response) in
            self.contactDetailViewProtocol.updateContactDetail(response as? Contact)
        }) { (error) in
            self.contactDetailViewProtocol.didFailedResponse(error)
        }
    }
    
    func didUpdateContact(forContact : Contact) {
        GKAPIRequest.contactUpdate(forContact.id.toString(), params: forContact.dictionary ?? [:], success: { (response) in
            self.contactDetailViewProtocol.updateContactDetail(response as? Contact)
        }) { (error) in
            self.contactDetailViewProtocol.didFailedResponse(error)
        }
    }
    
    func didCreateContact(forContact : Contact) {
        GKAPIRequest.contactCreate(forContact.dictionary ?? [:], success: { (response) in
            self.contactDetailViewProtocol.didSuccessfulResponse(response as? Contact)
        }) { (error) in
            self.contactDetailViewProtocol.didFailedResponse(error)
        }
    }
    
    func didDeleteContact(contact : Contact) {
        
    }
    
    func didUpdateFavourite(forContact : Contact) {
        
    }
    
}
