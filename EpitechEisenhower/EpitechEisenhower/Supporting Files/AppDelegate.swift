
import UIKit
import FBSDKCoreKit
import GoogleSignIn

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, GIDSignInDelegate {

    let backendless = Backendless.sharedInstance()!
    let APPLICATION_ID = "7504D3ED-A12C-2DE8-FFCA-C8D929180600"
    let API_KEY = "B6FB5E44-34AB-19F5-FF0B-ECDA08EB9600"
    let CLIENT_ID_GOOGLE = "73252829105-sufggiv7pvi25iu53igs84fgccuv6pqk.apps.googleusercontent.com"
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        backendless.initApp(APPLICATION_ID, apiKey: API_KEY)
        
//      Barre de status blanche
        UIApplication.shared.statusBarStyle = .lightContent
        
//        Facebook Delegate
        FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
        
//        Google Delegate
        GIDSignIn.sharedInstance().clientID = CLIENT_ID_GOOGLE
        GIDSignIn.sharedInstance().delegate = self
        
        return true
    }
    
//    Google fonctions    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if (error == nil) {
            backendless.userService.login(withGoogleSDK: user.authentication.idToken,
                                          accessToken: user.authentication.accessToken,
                                          response: {
                                            (user : BackendlessUser?) -> Void in
                                            NotificationCenter.default.post(name: .GoogleLogin, object: self, userInfo: ["success" : true, "user": user!])
            },
                                          error: {
                                            (fault : Fault?) -> Void in
                                            NotificationCenter.default.post(name: .GoogleLogin, object: self, userInfo: ["success": false, "error" : fault!])
            })
        }
    }
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        print("User has disconnected.")
    }

    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        if #available(iOS 9.0, *) {
            return GIDSignIn.sharedInstance().handle(url, sourceApplication: options[UIApplicationOpenURLOptionsKey.sourceApplication] as? String, annotation: options[UIApplicationOpenURLOptionsKey.annotation])
        }
        return false
    }
    
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        let boolFacebook = FBSDKApplicationDelegate.sharedInstance().application(application, open: url, sourceApplication: sourceApplication, annotation: annotation)
        
        return boolFacebook
    }
        
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
}

