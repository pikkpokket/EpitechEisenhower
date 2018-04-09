//
//  NotificationExtension.swift
//  EpitechEisenhower
//
//  Created by Kevin Djedje on 17/03/2018.
//

import Foundation

extension Notification.Name {
    static let CreateTask = Notification.Name("PostTaskNotification")
    static let UpdateTask = Notification.Name("UpdateTaskNotification")
    static let GetTask = Notification.Name("GetTaskNotification")
    static let RemoveTask = Notification.Name("RemoveTaskNotification")
    static let RegisterUser = Notification.Name("RegisterUserNotification")
    static let LoginUser = Notification.Name("LoginUserNotification")
    static let GoogleLogin = Notification.Name("GoogleLoginNotification")
    static let FacebookLogin = Notification.Name("FacebookLoginNotification")
    static let UpdateUser = Notification.Name("UpdateUserNotification")
}
