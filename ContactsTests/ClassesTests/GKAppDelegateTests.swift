//
//  GKAppDelegateTests.swift
//  ContactsTests
//
//  Created by Tirupati Balan on 19/04/19.
//  Copyright © 2019 Tirupati Balan. All rights reserved.
//

import Foundation
import XCTest

@testable import Contacts

class GKAppDelegateTests : XCTestCase {
    var appDelegate: GKAppDelegate = GKAppDelegate()
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    // MARK: Test after application launch
    
    func testWindowIsKeyAfterApplicationLaunch() {
        let mainAppDelegate = UIApplication.shared.delegate
        
        if let mainAppDelegate = mainAppDelegate {
            if let window = mainAppDelegate.window {
                if let window = window {
                    XCTAssertTrue(window.isKeyWindow)
                } else {
                    XCTFail("app delegate window should not be nil")
                }
            } else {
                XCTFail("app delegate window should not be nil")
            }
        } else {
            XCTFail("shared application should have a delegate")
        }
    }
    
    func testThatDidFinishLaunchingWithOptionsReturnsTrue() {
        XCTAssertTrue(appDelegate.application(UIApplication.shared, didFinishLaunchingWithOptions: nil), "should return true from didFinishLaunchingWithOptions")
    }
}
