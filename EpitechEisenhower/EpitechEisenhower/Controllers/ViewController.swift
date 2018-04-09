import UIKit
import FacebookLogin
import FacebookCore
import GoogleSignIn

class ViewController: UIViewController {
    
    let APPLICATION_ID = "7504D3ED-A12C-2DE8-FFCA-C8D929180600"
    let API_KEY = "B6FB5E44-34AB-19F5-FF0B-ECDA08EB9600"
    let SERVER_URL = "https://api.backendless.com"
    let backendless = Backendless.sharedInstance()!
    @IBOutlet weak var label: UILabel!
    @IBOutlet var loginView: LoginView!
    @IBOutlet weak var loading: UIActivityIndicatorView!
    
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var facebookButton: UIButton!
    @IBOutlet weak var googleButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loading.isHidden = true
        self.navigationController?.isNavigationBarHidden = true
//        LibraryAPI.shared.logout()
        
        NotificationCenter.default.addObserver(self, selector: #selector(loginComplete(notification:)), name: .LoginUser, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(facebookLoginComplete(notification:)), name: .FacebookLogin, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(googleLoginComplete(notification:)), name: .GoogleLogin, object: nil)
        instantiateDelegateSocialNetwork()
    }
    
    
    func instantiateDelegateSocialNetwork() {
        //         Google Delegate
        GIDSignIn.sharedInstance().uiDelegate = self
    }
    
    @IBAction func connexionButtonDidPressed() {
        //        let user = User(email: "kevindjedje@hotmail.fr", password: "prout")
        
        let token = Token(accessToken: AccessToken.current!)
        
        print("J'ai bien récupéré l'acces token")
        
        LibraryAPI.shared.loginWithFacebook(token: token)
    }
    
    @IBAction func googleButtonDidPressed(_ sender: Any) {
        loadingStart()
        GIDSignIn.sharedInstance().signIn()
    }
    
    @IBAction func facebookButtonDidPressed() {
        facebookConnect()
    }
    
    @IBAction func loginButtonDidPressed() {
        loadingStart()
        let error: String = Login(email: loginView.email, password: loginView.password).login()
        
        if error != "" {
            loadingStop()
            displayError(error: error)
        }
    }
    
    //    Bouton Facebook
    @objc func facebookConnect() {
        loadingStart()
        let loginManager = LoginManager()
        loginManager.logIn(readPermissions: [.publicProfile, .email], viewController: self) { (value: LoginResult) in
            switch value {
            case .failed(let error):
//                print("Une erreur est survenue : \(error)")
                self.displayError(error: "Une erreur est survenue: \(error)")
                self.loadingStop()
            case .cancelled:
                print("L'utilisateur a annulé la connexion")
                self.loadingStop()
            case .success(let grantedPermissions, let declinedPermissions, let token):
                print("L'utilisateur est bien connecté avec les differents paramètre : grantedPermissions : \(grantedPermissions) , declinedPermissions : \(declinedPermissions) et le token : \(token)")
                LibraryAPI.shared.loginWithFacebook(token: Token(accessToken: AccessToken.current!))
            }
        }    
    }
    
    
    @objc func loginComplete(notification: NSNotification) {
        if notification.userinfoSuccess() {
            loadingStop()
            print("C'est un succès, l'utilisateur est bien connecté  1")
            pushToHomeViewController()
        } else {
            loadingStop()
            let userInfo = notification.userInfo as? [String: Any]
            let error = userInfo!["error"] as! Fault
//            print("Malheureusement la tentative de connexion ne s'est pas bien déroulé. Une erreur est survenue : \(error.detail)")
//            displayError(error: "Malheureusement la tentative de connexion ne s'est pas bien déroulé. Une erreur est survenue : \(error.detail!)")
            displayError(error: error.detail!)
        }
        
    }
    
    @objc func facebookLoginComplete(notification: NSNotification) {
        loadingStop()
        pushToHomeViewController()
    }
    
    @objc func googleLoginComplete(notification: NSNotification) {
        if notification.userinfoSuccess() {
            loadingStop()
            pushToHomeViewController()
        } else {
            loadingStop()
            let error = notification.userInfo!["error"] as! Fault
            displayError(error: error.message)
        }
    }
    
    private func pushToHomeViewController() {
        let homeViewController = self.storyboard?.instantiateViewController(withIdentifier: "navigationController")
        self.present(homeViewController!, animated: true, completion: nil)
    }
    
    private func displayError(error: String) {
        loginView.error = error
    }
    
    private func loadingStart() {
        loading.isHidden = false
        loading.startAnimating()
        
        loginView.isHidden = true
        loginButton.isHidden = true
        signInButton.isHidden = true
        facebookButton.isHidden = true
        googleButton.isHidden = true
        
    }
    
    private func loadingStop() {
        loading.stopAnimating()
        loading.isHidden = true
        
        loginView.isHidden = false
        loginButton.isHidden = false
        signInButton.isHidden = false
        facebookButton.isHidden = false
        googleButton.isHidden = false
    }
}

extension ViewController : GIDSignInUIDelegate {
    func sign(_ signIn: GIDSignIn!, present viewController: UIViewController!) {
        self.present(viewController, animated: true)
    }
    
    func sign(_ signIn: GIDSignIn!, dismiss viewController: UIViewController!) {
        self.dismiss(animated: true)
    }
}
