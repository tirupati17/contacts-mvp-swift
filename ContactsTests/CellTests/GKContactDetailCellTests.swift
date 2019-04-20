//
//  GKContactDetailCellTests.swift
//  ContactsTests
//
//  Created by Tirupati Balan on 19/04/19.
//  Copyright © 2019 Tirupati Balan. All rights reserved.
//

import Foundation
import XCTest

@testable import Contacts

class GKContactDetailCellTests : XCTestCase {
    var contactDetailCell: GKContactDetailCell!
    
    override func setUp() {
        super.setUp()
        contactDetailCell = GKContactDetailCell(style: .default, reuseIdentifier: "GKContactDetailCellId")
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    // MARK: Base tests
    
    func testContactDetailCellExists() {
        XCTAssertNotNil(contactDetailCell, "GKContactDetailCell instance should be creatable")
    }
    
    // MARK: After init
    
    func testContactDetailCellInstances() {
        XCTAssertNotNil(contactDetailCell.profileImageView, "profileImageView instance should be present")
        XCTAssertNotNil(contactDetailCell.nameLabel, "nameLabel instance should be present")
        XCTAssertNotNil(contactDetailCell.firstNameTextField, "firstNameTextField instance should be present")
        XCTAssertNotNil(contactDetailCell.firstNameStaticLabel, "firstNameStaticLabel instance should be present")
        XCTAssertNotNil(contactDetailCell.lastNameTextField, "lastNameTextField instance should be present")
        XCTAssertNotNil(contactDetailCell.lastNameStaticLabel, "lastNameStaticLabel instance should be present")
        XCTAssertNotNil(contactDetailCell.mobileTextField, "mobileTextField instance should be present")
        XCTAssertNotNil(contactDetailCell.mobileStaticLabel, "mobileStaticLabel instance should be present")
        XCTAssertNotNil(contactDetailCell.emailTextField, "emailTextField instance should be present")
        XCTAssertNotNil(contactDetailCell.emailStaticLabel, "emailStaticLabel instance should be present")

        if let isUpdatedConstraints = contactDetailCell?.isUpdatedConstraints {
            XCTAssertFalse(isUpdatedConstraints, "isUpdatedConstraints should be false") //because isUpdatedConstraints updating in sub cells
        } else {
            XCTFail("isUpdatedConstraints should be created")
        }
    }
}
