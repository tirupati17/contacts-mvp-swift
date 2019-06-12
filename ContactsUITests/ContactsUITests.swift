//
//  ContactsUITests.swift
//  ContactsUITests
//
//  Created by Tirupati Balan on 15/04/19.
//  Copyright © 2019 Tirupati Balan. All rights reserved.
//

import XCTest

class ContactsUITests: XCTestCase {
    var app: XCUIApplication!

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        app = XCUIApplication()
        
        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    // MARK: - Tests
    
    func testGoingForAddContactButtonsFlow() {
        
        app.launch()
        
        // Tap the "Groups" button for nothing
        app.buttons["Groups"].tap()

        // Tap the "Add" button to show Contact Add View
        app.buttons["Add"].tap()
        
        // Tap the "camera button" button to show Gallary View
        app.buttons["camera"].tap()
        
        // Tap the "Cancel" button to hide Gallary View
        app.buttons["Cancel"].tap()
        
        // Tap the "Cancel" button to hide Contact Add View
        app.buttons["Cancel"].tap()
    }
    

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

}
