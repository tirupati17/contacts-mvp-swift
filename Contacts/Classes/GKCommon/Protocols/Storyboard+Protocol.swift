//
//  Storyboard+Protocol.swift
//  Contacts
//
//  Created by Tirupati Balan on 15/04/19.
//  Copyright © 2019 Tirupati Balan. All rights reserved.
//

import Foundation
import UIKit

protocol StoryboardIdentifiable {
    static var storyboardIdentifier : String { get }
}

extension StoryboardIdentifiable where Self : UIViewController {
    static var storyboardIdentifier : String {
        return String(describing : self)
    }
}
