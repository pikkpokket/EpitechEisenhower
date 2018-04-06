//
//  Login.swift
//  EpitechEisenhower
//
//  Created by Kevin Djedje on 27/03/2018.
//

import Foundation

class Login {
    private var email: String!
    private var password: String!
    private var error = ""
    
    private let EMAIL_EMPTY = "Email field is empty. Please fill it in"
    private let EMAIL_INVALID = "Incorrect email"
    private let PASSWORD_EMPTY = "Password field is empty. Please fill it in"
    private let PASSWORD_TOO_SHORT = "Password is too short"
    
    init(email: String, password: String) {
        self.email = email
        self.password = password
    }
    
    public func login() -> String {
        if checkParameters() {
            HTTPClient.shared.login(email: email, password: password)
        }
        return error
    }
    
    private func checkParameters() -> Bool {
        if !checkEmail() || !checkPassword() {
            return false
        }
        return true
    }
    
    private func checkEmail() -> Bool {
        if email == "" {
            error = EMAIL_EMPTY
            return false
        }
        
        let charset = CharacterSet(charactersIn: "@")
        if email.rangeOfCharacter(from: charset) == nil {
            error = EMAIL_INVALID
            return false
        }
        return true
    }
    
    private func checkPassword() -> Bool {
        if password == "" {
            error = PASSWORD_EMPTY
            return false
        }
        
        if password.count < 3 {
            error = PASSWORD_TOO_SHORT
            return false
        }
        return true
    }
}
