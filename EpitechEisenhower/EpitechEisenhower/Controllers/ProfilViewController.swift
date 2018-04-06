//
//  ProfilViewController.swift
//  EpitechEisenhower
//
//  Created by Kevin Djedje on 06/04/2018.
//

import UIKit

class ProfilViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var detailTextField: UITextView!
    @IBOutlet weak var emailTextField: UITextField!
    
    var user: BackendlessUser?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController!.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.5029722452, green: 0.7940927148, blue: 0.8642711043, alpha: 1)
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationItem.title = "Your Profile"
        self.navigationController!.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor : UIColor.white]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        user = Backendless.sharedInstance().userService.currentUser
        nameTextField.text = user!.getProperty("name") as? String
        detailTextField.text = user!.getProperty("detail") as? String
        emailTextField.text = String(user!.email)
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateUserCompleted(notification:)), name: .UpdateUser, object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func newPasswordButtonDidPressed() {
    }
    
    @IBAction func saveChangesButtonDidPressed() {
        user?.setProperty("detail", object: detailTextField.text!)
        LibraryAPI.shared.updateUser(user: user!)
    }
    
    @IBAction func logoutButtonDidPressed() {
    }
    
    @objc private func updateUserCompleted(notification: NSNotification) {
        let alert = UIAlertController(title: "", message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        if notification.userinfoSuccess() {
            alert.title = "Success"
            alert.message = "Profil updated"
            self.present(alert, animated: true, completion: nil)
        } else {
            alert.title = "Error"
            let error = notification.userInfo!["error"] as! Fault
            alert.message = "\(error.message)"
            self.present(alert, animated: true, completion: nil)
        }
    }
}
