//
//  UIStoryboard+Extension.swift
//  Contacts
//
//  Created by Tirupati Balan on 17/04/19.
//  Copyright © 2019 Tirupati Balan. All rights reserved.
//

import Foundation

extension UIStoryboard {
    
    enum Storyboard : String {
        case main
        case launchScreen
        var filename: String {
            return rawValue.capitalized
        }
    }
    
    class func storyboard(_ storyboard: Storyboard, bundle: Bundle? = nil) -> UIStoryboard {
        return UIStoryboard(name: storyboard.filename, bundle: bundle)
    }
}

extension StoryboardIdentifiable where Self : UIViewController { //Protocol implementation of storyboardIdentifier declared in GKViewController
    static var storyboardIdentifier : String {
        return String(describing : self)
    }
}
