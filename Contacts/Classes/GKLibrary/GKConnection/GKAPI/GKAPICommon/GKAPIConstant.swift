//
//  GKAPIConstant.swift
//  Contacts
//
//  Created by Tirupati Balan on 15/04/19.
//  Copyright © 2019 Tirupati Balan. All rights reserved.
//


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
    
    let baseLocalUrl = "assignment_host_url_here"
    let baseProductionUrl = "assignment_host_url_here"
    let baseStagingUrl = "assignment_host_url_here"
    
    static let apiVersion1 = ""
    static let apiVersion2 = ""
}
