//
//  ExampleQATests.swift
//  ExampleQATests
//
//  Created by Mohsen Khosravinia on 5/2/23.
//

import XCTest
@testable import ExampleQA

final class ExampleQATests: XCTestCase {
    func testHaterStartsNicely() {
       let hater = Hater()
       XCTAssertFalse(hater.hating)
    }
    
    func testHaterHatesAfterBadDay() {
       var hater = Hater()
       hater.hadABadDay()
       XCTAssertTrue(hater.hating)
    }
    
    func testHaterHappyAfterGoodDay() {
       var hater = Hater()
       hater.hadAGoodDay()
       XCTAssertFalse(hater.hating)
    }
}
