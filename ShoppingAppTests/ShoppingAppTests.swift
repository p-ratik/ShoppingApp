//
//  NavigateTests.swift
//  NavigateTests
//
//  Created by Capgemini-DA161 on 8/9/22.
//

import XCTest
@testable import ShoppingApp

class NavigateTests: XCTestCase {
    
    var signUpViewControllerClass: SignUpViewController!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        signUpViewControllerClass = SignUpViewController()
        signUpViewControllerClass.testName = "Prat"
        signUpViewControllerClass.testEmail = "pratik@gmail.com"
        signUpViewControllerClass.testMobile = "7656453445"
        signUpViewControllerClass.testPassword = "Pratik@123"
    }
    
    func test_validateName() {
        XCTAssertTrue(signUpViewControllerClass.isValidName, "Name is not valid")
    }
    
    func test_validateEmail() {
        XCTAssertTrue(signUpViewControllerClass.isValidEmail, "Email is not valid")
    }
    
    func test_validateMobile() {
        XCTAssertTrue(signUpViewControllerClass.isValidMobile, "Mobile  is not valid")
    }
    
    func test_validatePassword() {
        XCTAssertTrue(signUpViewControllerClass.isValidPassword, "Password is not valid")
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
