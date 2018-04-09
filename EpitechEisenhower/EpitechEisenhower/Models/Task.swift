//
//  Task.swift
//  EpitechEisenhower
//
//  Created by Kevin Djedje on 17/03/2018.
//

import Foundation

@objcMembers
class Task : NSObject {
    var title = ""
    var state = false
    var notes = ""
    var urgent = false
    var important = false
    var id = ""
    var dateTask = ""
    var objectId: String?
    
    override init() {
    }
    
    init(title: String, state: Bool = false, notes: String? = nil, urgent: Bool, important: Bool) {
        self.title = title
        self.state = state
        if let notes = notes {
            self.notes = notes
        }
        self.urgent = urgent
        self.important = important
    }
    
    func completeTask(complete: Bool) {
        self.state = complete
    }
    
    func editTitleTask(atIndex: Int, title: String) {
        self.title = title
    }
    
    func editNotesTask(atIndex: Int, notes: String) {
        self.notes = notes
    }
}
