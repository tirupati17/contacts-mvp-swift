//
//  GKContactListViewTests.swift
//  ContactsTests
//
//  Created by Tirupati Balan on 19/04/19.
//  Copyright © 2019 Tirupati Balan. All rights reserved.
//

import Foundation
import XCTest

@testable import Contacts

class GKContactListViewTests : XCTestCase {
    var contactListView: GKContactListView!

    override func setUp() {
        super.setUp()
        contactListView = GKContactListView()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    // MARK: Base tests
    
    func testContactListViewExists() {
        XCTAssertNotNil(contactListView, "GKContactListView instance should be creatable")
    }
    
    // MARK: loadView tests
    
    func testThatAfterLoadViewATableViewIsPresent() {
        let _ = contactListView?.view
        
        XCTAssertNotNil(contactListView?.tableView, "tableView instance should be present")
    }
    
    func testThatAfterLoadViewAContactListPresenterProtocolIsPresent() {
        let _ = contactListView?.view
        
        XCTAssertNotNil(contactListView?.contactListPresenterProtocol, "contactListPresenterProtocol instance should be present")
    }
    
    func testThatAfterLoadViewAEmptyContactIsPresent() {
        let _ = contactListView?.view
        
        XCTAssertNotNil(contactListView?.contacts, "contacts instance should be present")
    }
    
    func testThatAfterLoadViewAEmptySectionsIsPresent() {
        let _ = contactListView?.view
        
        XCTAssertNotNil(contactListView?.sections, "sections instance should be present")
    }
    
    func testThatAfterViewDidLoadIsUpdatedConstraintsIsTrue() {
        let _ = contactListView?.view
        
        if let isUpdatedConstraints = contactListView?.isUpdatedConstraints {
            XCTAssertTrue(isUpdatedConstraints, "isUpdatedConstraints should be true")
        } else {
            XCTFail("isUpdatedConstraints should be created")
        }
    }
    
}
