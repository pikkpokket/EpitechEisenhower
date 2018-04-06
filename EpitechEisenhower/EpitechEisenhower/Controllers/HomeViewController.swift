//
//  HomeViewController.swift
//  EpitechEisenhower
//
//  Created by Kevin Djedje on 30/03/2018.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var homeTableView: UITableView!
    
    private var count: Int = 0
//    private var tasks: [Task] = []
    private var tasksInProgress: [Task] = [] {
        didSet {
            count = tasksInProgress.count
        }
    }
    
    private var HEIGHT_CELL: CGFloat = 104.0
    
    private enum CellName {
        static let cell = "cell"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        homeTableView.delegate = self
        homeTableView.dataSource = self
        homeTableView.separatorColor = #colorLiteral(red: 0.5029722452, green: 0.7940927148, blue: 0.8642711043, alpha: 1)
        
        self.navigationController?.isNavigationBarHidden = true
        NotificationCenter.default.addObserver(self, selector: #selector(linkTasksToController(notification:)), name: .GetTask, object: nil)
        
//        LibraryAPI.shared.login(user: User(email: "kevin.djedje@epitech.eu", password: "password"))
        LibraryAPI.shared.getTask()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc private func linkTasksToController(notification: NSNotification) {
        if notification.userinfoSuccess() {
            let newTasks: [Task] = notification.userInfo!["tasks"] as! [Task]
            if !newTasks.isEmpty {
//                tasks = newTasks
                tasksInProgress = getInProgressTask(allTasks: newTasks)
                homeTableView.reloadData()
            }
        } else {
            let error: Fault = notification.userInfo!["error"] as! Fault
            print("error : \(error.message)")
        }
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
    
    private func getInProgressTask(allTasks: [Task]) -> [Task] {
        var inProgressTasks: [Task] = []
        
        for task in allTasks {
            if task.state == false {
                inProgressTasks.append(task)
            }
        }
        return inProgressTasks
    }
    
    @IBAction func profileButtonDidPressed() {
//        let controller = storyboard?.instantiateViewController(withIdentifier: "Profil")
//        self.navigationController!.pushViewController(controller!, animated: true)
        
        let profilViewController: ProfilViewController = storyboard!.instantiateViewController(withIdentifier: "Profil") as! ProfilViewController
        navigationController?.pushViewController(profilViewController, animated: true)

        
    }
    
    private func pushToProfilViewController() {
        
    }
}

extension HomeViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return HEIGHT_CELL
    }
}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tasksInProgress.count == 0 {
            return 1
        } else {
            return tasksInProgress.count / 2 + 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: HomeTableViewCell = tableView.dequeueReusableCell(withIdentifier: CellName.cell, for: indexPath) as! HomeTableViewCell
        let index = indexPath.row * 2
        if count >= 2 {
            let firstTask = tasksInProgress[index]
            let secondTask = tasksInProgress[index + 1]
            
            cell.firstTaskView.isHidden = false
            cell.secondTaskView.isHidden = false
            cell.addButton.isHidden = true
            
            
            cell.firstTaskView.title = firstTask.title
            cell.firstTaskView.style = getStyleTask(task: firstTask)
            cell.secondTaskView.title = secondTask.title
            cell.secondTaskView.style = getStyleTask2(task: secondTask)
            
            count -= 2
            return cell
        } else if count == 1 {
            let secondTask = tasksInProgress[index]
            
            cell.secondTaskView.title = secondTask.title
            cell.secondTaskView.style = getStyleTask2(task: secondTask)
            cell.secondTaskView.isHidden = false
            cell.firstTaskView.isHidden = true
            cell.addButton.isHidden = false
            
            count -= 1
            return cell
        } else if count == 0 {
            cell.addButton.isHidden = false
            cell.firstTaskView.isHidden = true
            cell.secondTaskView.isHidden = true
            
            return cell
        }
        return cell
    }
}
