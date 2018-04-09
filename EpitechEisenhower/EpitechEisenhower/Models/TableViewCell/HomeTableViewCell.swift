//
//  HomeTableViewCell.swift
//  EpitechEisenhower
//
//  Created by Kevin Djedje on 31/03/2018.
//

import UIKit

class HomeTableViewCell: UITableViewCell {

    @IBOutlet weak var firstTaskView: TaskView!
    @IBOutlet weak var secondTaskView: Task2View!
    @IBOutlet weak var addButton: UIButton!
    
    private var storyboard: UIStoryboard!
    private var navigationController: UINavigationController!
    private var task1: Task? {
        didSet{
            firstTaskView.isHidden = false
            firstTaskView.title = task1!.title
            firstTaskView.date = task1!.dateTask
            firstTaskView.style = self.getStyleTask(task: task1!)
            firstTaskView.task = task1!
        }
    }
    
    private var task2: Task? {
        didSet {
            secondTaskView.isHidden = false
            secondTaskView.title = task2!.title
            secondTaskView.date = task2!.dateTask
            secondTaskView.style = self.getStyleTask2(task: task2!)
            secondTaskView.task = task2!
        }
    }
    
    var leftView: TaskView = TaskView(frame: CGRect(x: 8, y: 16, width: 158, height: 81))
    var rightView: TaskView = TaskView(frame: CGRect(x: 177, y: 16, width: 158, height: 81))
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
//        self.isUserInteractionEnabled = false
        self.selectionStyle = .none
        firstTaskView.isHidden = false
        secondTaskView.isHidden = false
        addButton.isHidden = true
        
    }

    private func getStyleTask2(task: Task) -> Task2View.Style {
        if task.important {
            if task.urgent {
                return .importanteAndUrgente
            } else {
                return .importanteAndNotUrgente
            }
        } else {
            if task.urgent {
                return .NotImportanteAndUrgente
            } else {
                return .regular
            }
        }
    }
    
    private func getStyleTask(task: Task) -> TaskView.Style {
        if task.important {
            if task.urgent {
                return .importanteAndUrgente
            } else {
                return .importanteAndNotUrgente
            }
        } else {
            if task.urgent {
                return .NotImportanteAndUrgente
            } else {
                return .regular
            }
        }
    }

    @objc private func touched() {
        print("TOUCHED VIEW")
    }
    
    @objc private func touchTaskView(viewTouched: UIView) {
        let detailViewController: TaskDetailViewController = storyboard!.instantiateViewController(withIdentifier: "TaskDetail") as! TaskDetailViewController
        if viewTouched == firstTaskView {
            detailViewController.task = task1!
            self.navigationController?.pushViewController(detailViewController, animated: true)
        } else if viewTouched == secondTaskView {
            detailViewController.task = task2
            self.navigationController?.pushViewController(detailViewController, animated: true)
        }
}
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    public func initController(storyBoard: UIStoryboard, navigationController: UINavigationController, task1: Task, task2: Task) {
        self.navigationController = navigationController
        self.storyboard = storyBoard
        self.task1 = task1
        self.task2 = task2
        self.addButton.isHidden = true
    }
    
    public func initControllerWithOneTask(storyBoard: UIStoryboard, navigationController: UINavigationController, task2: Task) {
        self.navigationController = navigationController
        self.storyboard = storyBoard
        self.task2 = task2
        self.firstTaskView.isHidden = true
        self.addButton.isHidden = false
    }
    
    public func initControllerWithOutTask(storyBoard: UIStoryboard, navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.storyboard = storyBoard
        self.firstTaskView.isHidden = true
        self.secondTaskView.isHidden = true
        self.addButton.isHidden = false
    }
    
    @IBAction func addButtonDidPressed() {
        print("Add Button worked")
    }
}
