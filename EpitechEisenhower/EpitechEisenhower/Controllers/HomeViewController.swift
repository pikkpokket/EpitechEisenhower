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
        LibraryAPI.shared.getTask()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        homeTableView.delegate = self
        homeTableView.dataSource = self
        homeTableView.separatorColor = #colorLiteral(red: 0.5029722452, green: 0.7940927148, blue: 0.8642711043, alpha: 1)
        
        self.navigationController?.isNavigationBarHidden = true
        NotificationCenter.default.addObserver(self, selector: #selector(linkTasksToController(notification:)), name: .GetTask, object: nil)
        
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
        let profilViewController: ProfilViewController = storyboard!.instantiateViewController(withIdentifier: "Profil") as! ProfilViewController
        navigationController?.pushViewController(profilViewController, animated: true)

        
    }
    
    @objc private func addButtonDidPressed() {
        let createViewController: CreateTaskViewController = storyboard!.instantiateViewController(withIdentifier: "CreateTask") as! CreateTaskViewController
        self.navigationController?.pushViewController(createViewController, animated: true)
    }
    
    @objc private func pushTaskDetailView(sender: UITapGestureRecognizer) {
        print("ViewTouched TAG : \(sender.view!.tag)")
        let detailViewController: TaskDetailViewController = storyboard!.instantiateViewController(withIdentifier: "TaskDetail") as! TaskDetailViewController
        if sender.view!.tag % 2 == 0 {
            if let taskView: TaskView = sender.view! as? TaskView {
                if taskView.task == nil {
                    print("OUI MAGGLE")
                }
                detailViewController.task = taskView.task
                self.navigationController?.pushViewController(detailViewController, animated: true)
            }
            if let taskView: Task2View = sender.view! as? Task2View {
                if taskView.task == nil {
                    print("OUI MAGGLE")
                }
                detailViewController.task = taskView.task
                self.navigationController?.pushViewController(detailViewController, animated: true)
            }
        } else {
            let taskView = sender.view! as? Task2View
            if taskView?.task == nil {
                print("OUI MAGGLE")
            }
            detailViewController.task = taskView?.task
            self.navigationController?.pushViewController(detailViewController, animated: true)
        }
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
            cell.initController(storyBoard: self.storyboard!, navigationController: self.navigationController!, task1: tasksInProgress[index], task2: tasksInProgress[index + 1])
            
            cell.firstTaskView.tag = index
            cell.secondTaskView.tag = index + 1
            cell.firstTaskView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(pushTaskDetailView(sender:))))
            cell.secondTaskView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(pushTaskDetailView(sender:))))
            count -= 2
            return cell
        } else if count == 1 {
            cell.initControllerWithOneTask(storyBoard: self.storyboard!, navigationController: self.navigationController!, task2: tasksInProgress[index])
            cell.secondTaskView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(pushTaskDetailView(sender:))))
            cell.addButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(addButtonDidPressed)))
            cell.secondTaskView.tag = index
            count -= 1
            return cell
        } else if count == 0 {
            cell.initControllerWithOutTask(storyBoard: self.storyboard!, navigationController: self.navigationController!)
            cell.addButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(addButtonDidPressed)))
            return cell
        }
        return cell
    }
}
