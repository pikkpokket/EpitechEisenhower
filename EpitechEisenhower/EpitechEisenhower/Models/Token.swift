//
//  Token.swift
//  EpitechEisenhower
//
//  Created by Kevin Djedje on 24/03/2018.
//

import Foundation
import FacebookCore

struct Token {
    var accessToken: AccessToken!
    
    init(accessToken: AccessToken) {
        self.accessToken = accessToken
    }
}
