//
//  GKAPIRequestType.swift
//  Contacts
//
//  Created by Tirupati Balan on 15/04/19.
//  Copyright © 2019 Tirupati Balan. All rights reserved.
//

import Foundation

enum GKAPIRequestType: Int {
    case APIRequestContactList = 1
    case APIRequestContactDetail = 2
    case APIRequestContactCreate = 3
    case APIRequestContactUpdate = 4
    case APIRequestContactDelete = 5
    case APIRequestUndefined = 100
}
