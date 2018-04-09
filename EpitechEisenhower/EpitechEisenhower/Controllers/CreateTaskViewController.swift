//
//  CreateTaskViewController.swift
//  EpitechEisenhower
//
//  Created by Kevin Djedje on 09/04/2018.
//

import UIKit

class CreateTaskViewController: UIViewController {
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var noteTextField: UITextView!
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var urgentSwitch: UISwitch!
    @IBOutlet weak var importantSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        NotificationCenter.default.addObserver(self, selector: #selector(addTaskCompleted(notification:)), name: .CreateTask, object: nil)
        
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController!.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.5029722452, green: 0.7940927148, blue: 0.8642711043, alpha: 1)
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationItem.title = "Task Create"
        self.navigationController!.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor : UIColor.white]

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func addTaskButtonDidPressed() {
        let task = Task(title: titleTextField.text!, state: false, notes: noteTextField.text!, urgent: urgentSwitch.isOn, important: importantSwitch.isOn)
        
        
        LibraryAPI.shared.addTask(newTask: task)
    }
    
    @objc private func addTaskCompleted(notification: NSNotification) {
        if notification.userinfoSuccess() {
            let newTask = notification.userInfo!["newTask"] as! Task
            LibraryAPI.shared.setRelationBetweenCurrentUserToTask(task: newTask)
        } else {
            let error : Fault = notification.userInfo!["error"] as! Fault
            print("Error : \(error.message)")
        }
    }
}
