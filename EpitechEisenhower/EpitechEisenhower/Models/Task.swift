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

    override init() {
    }
    
    init(title: String, state: Bool = false, notes: String? = nil) {
        self.title = title
        self.state = state
        if let notes = notes {
            self.notes = notes
        }
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
