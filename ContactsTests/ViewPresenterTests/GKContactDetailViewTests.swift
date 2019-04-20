//
//  GKContactDetailViewTests.swift
//  ContactsTests
//
//  Created by Tirupati Balan on 19/04/19.
//  Copyright © 2019 Tirupati Balan. All rights reserved.
//

import Foundation
import XCTest

@testable import Contacts

class GKContactDetailViewTests : XCTestCase {
    var contactDetailView: GKContactDetailView!
    
    override func setUp() {
        super.setUp()
        contactDetailView = GKContactDetailView()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    // MARK: Base tests
    
    func testContactDetailViewExists() {
        XCTAssertNotNil(contactDetailView, "GKContactDetailView instance should be creatable")
    }
    
    // MARK: loadView tests
    
    func testThatAfterLoadViewATableViewIsPresent() {
        let _ = contactDetailView?.view
        
        XCTAssertNotNil(contactDetailView?.tableView, "tableView instance should be present")
    }
    
    func testThatAfterLoadViewAContactListPresenterProtocolIsPresent() {
        let _ = contactDetailView?.view
        
        XCTAssertNotNil(contactDetailView?.contactDetailPresenterProtocol, "contactDetailPresenterProtocol instance should be present")
    }
    
    func testThatAfterViewDidLoadIsUpdatedConstraintsIsTrue() {
        let _ = contactDetailView?.view
        
        if let isUpdatedConstraints = contactDetailView?.isUpdatedConstraints {
            XCTAssertTrue(isUpdatedConstraints, "isUpdatedConstraints should be true")
        } else {
            XCTFail("isUpdatedConstraints should be created")
        }
    }
    
}
