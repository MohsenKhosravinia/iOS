//
//  LoginViewModelTests.swift
//  ExampleTestingTests
//
//  Created by Mohsen Khosravinia on 10/10/21.
//

import XCTest
@testable import ExampleTesting

class LoginViewModelTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testEmailValidation_ReturnsTrue() {
        // Arrange
        let viewModel: LoginViewModelInterface = LoginViewModel()
        // Act
        let isValid = viewModel.isValid(email: "mohsen@gmail.com")
        // Assert
        XCTAssertTrue(isValid, "The email validation is not working")
    }

    func testEmailValidation_ReturnsFalse() {
        // Arrange
        let viewModel: LoginViewModelInterface = LoginViewModel()
        // Act
        let isValid = viewModel.isValid(email: "mohsengmail.com")
        // Assert
        XCTAssertFalse(isValid, "The email validation is not working")
    }

}
