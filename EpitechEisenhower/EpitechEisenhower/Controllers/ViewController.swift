 import UIKit

class ViewController: UIViewController {
    
    let APPLICATION_ID = "7504D3ED-A12C-2DE8-FFCA-C8D929180600"
    let API_KEY = "B6FB5E44-34AB-19F5-FF0B-ECDA08EB9600"
    let SERVER_URL = "https://api.backendless.com"
    let backendless = Backendless.sharedInstance()!
    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    
    @IBAction func connexionButtonDidPressed() {
        let user = User(email: "kevindjedje@hotmail.fr", password: "prout")
        
        LibraryAPI.shared.updateUser(user: user)
    }
    
 }
