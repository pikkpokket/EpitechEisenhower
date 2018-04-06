//
//  User.swift
//  EpitechEisenhower
//
//  Created by Kevin Djedje on 17/03/2018.
//

import Foundation

struct User {
    var email = ""
    var password = ""
    var detail = ""
    
    init(email: String, password: String, detail: String = "") {
        self.email = email
        self.password = password
        self.detail = detail
    }
}
