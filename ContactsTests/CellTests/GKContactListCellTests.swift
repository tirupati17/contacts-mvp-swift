//
//  GKContactListCellTests.swift
//  ContactsTests
//
//  Created by Tirupati Balan on 19/04/19.
//  Copyright © 2019 Tirupati Balan. All rights reserved.
//

import Foundation
import XCTest

@testable import Contacts

class GKContactListCellTests : XCTestCase {
    var contactListCell: GKContactListCell!
    
    override func setUp() {
        super.setUp()
        contactListCell = GKContactListCell(style: .default, reuseIdentifier: "GKContactListCellId")
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    // MARK: Base tests
    
    func testContactListCellExists() {
        XCTAssertNotNil(contactListCell, "GKContactListCell instance should be creatable")
    }
    
    // MARK: After init

    func testContactListCellInstances() {
        XCTAssertNotNil(contactListCell.profileImageView, "profileImageView instance should be present")
        XCTAssertNotNil(contactListCell.nameLabel, "nameLabel instance should be present")
        XCTAssertNotNil(contactListCell.favouriteButton, "favouriteButton instance should be present")
        if let isUpdatedConstraints = contactListCell?.isUpdatedConstraints {
            XCTAssertTrue(isUpdatedConstraints, "isUpdatedConstraints should be true")
        } else {
            XCTFail("isUpdatedConstraints should be created")
        }
    }
}
