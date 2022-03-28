//
//  ViewControllerTests.swift
//  PasswordTests
//
//  Created by Micaella Morales on 3/27/22.
//

import XCTest

@testable import Password

class ViewControllerTests_NewPassword_Validation: XCTestCase {
    
    var vc: ViewController!
    let validPassword = "12345678Aa!"
    let tooShort = "1234Aa!"
    let button = UIButton()
    
    override func setUp() {
        super.setUp()
        vc = ViewController()
    }
    
    func testEmptyPassword() throws {
        vc.newPasswordView.text = ""
        vc.resetPasswordButtonTappedTest(UIButton())

        XCTAssertEqual(vc.newPasswordView.errorMessageLabel.text, "Enter your password")
        XCTAssertFalse(vc.newPasswordView.errorMessageLabel.isHidden)
    }
    
    func testInvalidPassword() throws {
        vc.newPasswordView.text = "🕹"
        vc.resetPasswordButtonTappedTest(button)
        
        XCTAssertEqual(vc.newPasswordView.errorMessageLabel.text, "Enter valid special chars (.,@:?!()$^%&\\/#) with no spaces")
        XCTAssertFalse(vc.newPasswordView.errorMessageLabel.isHidden)
    }
    
    func testCriteriaNotMet() throws {
        vc.newPasswordView.text = tooShort
        vc.resetPasswordButtonTappedTest(button)
        
        XCTAssertEqual(vc.newPasswordView.errorMessageLabel.text, "Your password must meet the requirements below")
        XCTAssertFalse(vc.newPasswordView.errorMessageLabel.isHidden)
    }
    
    func testValidPassword() throws {
        vc.newPasswordView.text = validPassword
        vc.resetPasswordButtonTappedTest(button)
        
        XCTAssertEqual(vc.newPasswordView.errorMessageLabel.text, "")
        XCTAssertTrue(vc.newPasswordView.errorMessageLabel.isHidden)
    }
    
}

class ViewControllerTests_ConfirmPassword_Validation: XCTestCase {
    var vc: ViewController!
    let validPassword = "12345678Aa!"
    let tooShort = "1234Aa!"
    let button = UIButton()
    
    override func setUp() {
        super.setUp()
        vc = ViewController()
    }
    
    func testEmptyPassword() throws {
        vc.confirmPasswordView.text = ""
        vc.resetPasswordButtonTappedTest(button)
        
        XCTAssertEqual(vc.confirmPasswordView.errorMessageLabel.text, "Enter your password")
        XCTAssertFalse(vc.confirmPasswordView.errorMessageLabel.isHidden)
    }
    
    func testPasswordsDoNotMatch() throws {
        vc.newPasswordView.text = validPassword
        vc.confirmPasswordView.text = tooShort
        vc.resetPasswordButtonTappedTest(button)
        
        XCTAssertEqual(vc.confirmPasswordView.errorMessageLabel.text, "Passwords do not match")
        XCTAssertFalse(vc.confirmPasswordView.errorMessageLabel.isHidden)
    }
    
    func testPasswordsMatch() throws {
        vc.newPasswordView.text = validPassword
        vc.confirmPasswordView.text = validPassword
        vc.resetPasswordButtonTappedTest(button)
        
        XCTAssertEqual(vc.confirmPasswordView.errorMessageLabel.text, "")
        XCTAssertTrue(vc.confirmPasswordView.errorMessageLabel.isHidden)
    }
}

class ViewControllerTests_Show_Alert: XCTestCase {
    
    var vc: ViewController!
    let validPassword = "12345678Aa!"
    let tooShort = "1234Aa!"
    let button = UIButton()
    
    override func setUp() {
        super.setUp()
        vc = ViewController()
    }
    
    func testShowSuccess() throws {
        vc.newPasswordView.text = validPassword
        vc.confirmPasswordView.text = validPassword
        vc.resetPasswordButtonTappedTest(button)
        
        XCTAssertNotNil(vc.alert)
        XCTAssertEqual(vc.alert!.title, "Success")
    }
    
    func testShowError() throws {
        vc.newPasswordView.text = validPassword
        vc.confirmPasswordView.text = tooShort
        vc.resetPasswordButtonTappedTest(button)
        
        XCTAssertNil(vc.alert)
    }
}
