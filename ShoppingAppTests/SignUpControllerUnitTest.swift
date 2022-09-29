//
//  SignUpControllerUnitTest.swift
//  ShoppingAppTests
//
//  Created by Capgemini-DA161 on 9/27/22.
//

import XCTest
@testable import ShoppingApp

class SignUpControllerUnitTest: XCTestCase {

    var signUpViewC: SignUpViewController!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        signUpViewC = SignUpViewController.getVC()
        signUpViewC.loadViewIfNeeded()
    }

    func test_checkSignUpButtonAction() throws {
        let signUpButton: UIButton = try XCTUnwrap(signUpViewC.signUpButton, "SignUp button with no referencing outlet")
        let sigUpButtonAction = try XCTUnwrap(signUpButton.actions(forTarget: signUpViewC, forControlEvent: .touchUpInside), "Signup Button dont have any Action")
        XCTAssertEqual(sigUpButtonAction.count, 1)
        XCTAssertEqual(sigUpButtonAction.first, "signUpButtonClicked:", "No Action for SignUp Button")
    }
    
    func test_checkUsernameOutlet() throws {
        XCTAssertNotNil(signUpViewC.usernameTextField, "Username don't have outlet connection")
    }
    
    func test_checkEmailOutlet() throws {
        XCTAssertNotNil(signUpViewC.signUpEmailTextField, "signUpEmailTextField don't have outlet connection")
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
