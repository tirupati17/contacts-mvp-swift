//
//  GKAPIConstant.swift
//  Contacts
//
//  Created by Tirupati Balan on 15/04/19.
//  Copyright © 2019 Tirupati Balan. All rights reserved.
//

import Foundation

enum DeploymentType : Int {
    case kLocal = 1
    case kProduction = 2
    case kStaging = 3
}

class GKAPIConstant {
    static let sharedConstant = GKAPIConstant()
    var deploymentType : DeploymentType = .kStaging
    
    func baseUrl() -> String {
        switch self.deploymentType {
            case .kProduction:
                return self.baseProductionUrl
            case .kStaging:
                return self.baseStagingUrl
            default:
                return self.baseLocalUrl
        }
    }
    
    let baseLocalUrl = "http://gojek-contacts-app.herokuapp.com"
    let baseProductionUrl = "http://gojek-contacts-app.herokuapp.com"
    let baseStagingUrl = "http://gojek-contacts-app.herokuapp.com"
    
    static let apiVersion1 = ""
    static let apiVersion2 = ""
}
