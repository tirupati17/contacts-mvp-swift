//
//  GKLogger.swift
//  Contacts
//
//  Created by Tirupati Balan on 15/04/19.
//  Copyright © 2019 Tirupati Balan. All rights reserved.
//


class GKLogger {
    var isLogEnabled = true
    
    class var sharedLogger : GKLogger {
        struct defaultSingleton {
            static let loggerInstance = GKLogger()
        }
        return defaultSingleton.loggerInstance
    }
    
    class func log(_ logString : Any) {
        print(GKLogger.sharedLogger.isLogEnabled ? "GK: \(logString)" : "")
    }
}
