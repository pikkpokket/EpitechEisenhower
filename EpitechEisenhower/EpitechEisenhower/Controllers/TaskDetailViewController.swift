//
//  TaskDetailViewController.swift
//  EpitechEisenhower
//
//  Created by Kevin Djedje on 08/04/2018.
//

import UIKit

class TaskDetailViewController: UIViewController {
    @IBOutlet private weak var nameLabel: UITextField!
    @IBOutlet private weak var notesLabel: UITextView!
    @IBOutlet private weak var dateLabel: UITextField!
    
    public var task: Task?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.isNavigationBarHidden = false
        self.navigationController!.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.5029722452, green: 0.7940927148, blue: 0.8642711043, alpha: 1)
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationItem.title = "Task Detail (Edit)"
        self.navigationController!.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor : UIColor.white]

        
        
        
        // Do any additional setup after loading the view.
        nameLabel.text = task?.title
        notesLabel.text = task?.notes
        dateLabel.text = task?.dateTask
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func saveChangesButtonDidPressed() {
        task!.title = nameLabel.text!
        task!.notes = notesLabel.text!
        task!.dateTask = dateLabel.text!
        LibraryAPI.shared.updateTask(updateTask: task!)
    }
    
    @IBAction func deleteTaskButtonDidPressed() {
        LibraryAPI.shared.removeTask(deletedTask: task!)
    }
    
    @objc private func updateTaskCompleted(notification: NSNotification) {
        
    }
    
    @objc private func removeTaskCompleted(notification: NSNotification) {
        
    }
    
}
