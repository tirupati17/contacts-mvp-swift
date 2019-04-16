//
//  GKConstant.swift
//  Contacts
//
//  Created by Tirupati Balan on 15/04/19.
//  Copyright © 2019 Tirupati Balan. All rights reserved.
//

import Foundation

class GKConstant {
    static var AppBundleName : String {
        return Bundle.main.infoDictionary!["CFBundleIdentifier"] as! String
    }
}
