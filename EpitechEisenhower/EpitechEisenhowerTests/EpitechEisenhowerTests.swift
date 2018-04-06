//
//  EpitechEisenhowerTests.swift
//  EpitechEisenhowerTests
//
//  Created by Kevin Djedje on 28/03/2018.
//

import XCTest
@testable import EpitechEisenhower

class EpitechEisenhowerTests: XCTestCase {
    
    var login : Login!
    private let EMAIL_EMPTY = "Le champ email est vide. Veuillez le remplir."
    private let EMAIL_INVALID = "L'email saisi est invalide."
    private let PASSWORD_EMPTY = "Le champ mot de passe est vide. Veuillez le remplir."
    private let PASSWORD_TOO_SHORT = "Le mot de passe choisi est trop court."
    private let SUCCESS = ""

    private let EMAIL_EMPTY_ANSWER = "Erreur lors de la vérification d'un email vide"
    private let EMAIL_INVALID_ANSWER = "Erreur lors de la vérification d'une chaine ne contenant pas @"
    private let PASSWORD_EMPTY_ANSWER = "Erreur lors de la vérification d'un password vide"
    private let PASSWORD_TOO_SHORT_ANSWER = "Erreur lors de la vérification d'un password trop court"
    private let SUCCESS_ANSWER = "Une erreur est survenue : "
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        login = nil
    }
    
    func testEmailVide() {
//        GIVEN
        login = Login(email: "", password: "password")
        let returnValue = login.login()
        
//        WHEN
        
//        THEN
        XCTAssertEqual(returnValue, EMAIL_EMPTY, EMAIL_EMPTY_ANSWER)
    }
    
    func testEmailDoestntCorrect() {
        login = Login(email: "kevindjedje/hotmail.fr", password: "password")
        let returnValue = login.login()
        
        XCTAssertEqual(returnValue, EMAIL_INVALID, EMAIL_INVALID_ANSWER)
    }
    
    func testEmaiCorrect() {
        login = Login(email: "kevindjedje@hotmail.fr", password: "password")
        let returnValue = login.login()
        
        XCTAssertEqual(returnValue, SUCCESS, "\(SUCCESS_ANSWER + returnValue)")
    }
    
    func testPasswordVide() {
        login = Login(email: "kevindjedje@hotmail.fr", password: "")
        let returnValue = login.login()
        
        XCTAssertEqual(returnValue, PASSWORD_EMPTY, PASSWORD_EMPTY_ANSWER)
    }
    
    func testPasswordTooShort() {
        login = Login(email: "kevindjedje@hotmail.fr", password: "ab")
        let returnValue = login.login()
        
        XCTAssertEqual(returnValue, PASSWORD_TOO_SHORT, PASSWORD_TOO_SHORT_ANSWER)
    }
    
    func testPasswordValide() {
        login = Login(email: "kevindjedje@hotmail.fr", password: "password")
        let returnValue = login.login()
        
        XCTAssertEqual(returnValue, SUCCESS, "\(SUCCESS_ANSWER + returnValue)")
    }
    
    
}
