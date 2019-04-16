//
//  GKAPIStringUrl.swift
//  Contacts
//
//  Created by Tirupati Balan on 15/04/19.
//  Copyright © 2019 Tirupati Balan. All rights reserved.
//

import Foundation

enum GKRequestMethod : Int {
    case RequestMethodGet = 1
    case RequestMethodPost = 2
    case RequestMethodPut = 3
    case RequestMethodDelete = 4
}

class GKAPIStringUrl {
    static let kContactEndpoint = "contacts.json"
    static let kContactWithIdEndpoint = "contacts/%@.json"
    
    static func contactEndpoint() -> String {
        return kContactEndpoint
    }
    
    static func contactWithIdEndpoint(_ id : String) -> String {
        return String(format: kContactWithIdEndpoint, id)
    }
}
