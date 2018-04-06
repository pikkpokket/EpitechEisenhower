//
//  NSNotificationExtension.swift
//  EpitechEisenhower
//
//  Created by Kevin Djedje on 06/04/2018.
//

import Foundation

extension NSNotification {
    public func userinfoSuccess() -> Bool {
        if self.userInfo!["success"] as! Bool == true {
            return true
        } else {
            return false
        }
    }
}
