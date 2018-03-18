//
//  HTTPClient.swift
//  EpitechEisenhower
//
//  Created by Kevin Djedje on 17/03/2018.
//

import Foundation


class HTTPClient {

    let APPLICATION_ID = "7504D3ED-A12C-2DE8-FFCA-C8D929180600"
    let API_KEY = "B6FB5E44-34AB-19F5-FF0B-ECDA08EB9600"
    let SERVER_URL = "https://api.backendless.com"
    let backendless = Backendless.sharedInstance()!
    static let shared: HTTPClient = HTTPClient()
    
    private enum VerboseAPI {
        static let Error = "Une erreur est survenue"
    }
    
    private static let ErrorName: [String: String] = [
        "2002": "Invalid application info (application id or api key)",
        "3009": "User registration is disabled for the application",
        "3010" : "User registration has an unknown property and dynamic properties are disabled for this version of the application",
        "3011" : "Missing 'password' property",
        "3012" : "Required property is missing",
        "3013" : "Missing value for the identity property",
        "3014" : "External registration failed with an error",
        "3021" : "General user registration error. Details included with the error message",
        "3033" : "User with the same identity alredy exists",
        "3038" : "Missing application-id or collection of properties for the registering user",
        "3039" : "Property 'id' cannot be used in the registration call",
        "3040" : "Email address is in the wrong format",
        "3041" : "A value for a required property is missing",
        "3043" : "Duplicate properties in the registration request",
        "8000" : "Property value exceeds the length limit"
    ]
    
    private enum TableName {
        static let Task = "TaskTable"
    }
    
    private init () {
        backendless.hostURL = SERVER_URL
        backendless.initApp(APPLICATION_ID, apiKey: API_KEY)
    }
 
    //  MARK: - Fonctions Requêtes Connexion/Inscription
    public func register(email: String, password: String) {
        let user = BackendlessUser()
        user.setProperty("email", object: email)
        user.setProperty("password", object: password)
        backendless.userService.register(user, response: { (registeredUser: BackendlessUser?) in
            NotificationCenter.default.post(name: .RegisterUser, object: self, userInfo: ["success": true])
            print("L'utilisateur '\(email)' s'est bien enregistré dans la BDD")
        }) { (fault: Fault?) in
            NotificationCenter.default.post(name: .RegisterUser, object: self, userInfo: ["success": false, "error": fault!])
            print("Une erreur est survenue : \(String(describing: fault)), message:\(fault!.message), \(fault!.detail), LE CODE ====>\(fault!.faultCode)")
        }
    }
    
    public func login(email: String, password: String) {
        backendless.userService.login(email, password: password, response: { (userLogged: BackendlessUser?) in
            NotificationCenter.default.post(name: .LoginUser, object: self, userInfo: ["success": true])
            print("L'utilisateur est connecté: \(userLogged!.getProperties())")
        }) { (fault: Fault?) in
            NotificationCenter.default.post(name: .LoginUser, object: self, userInfo: ["success": false, "error": fault!])
            print("Une erreur est survenue : \(fault!)")
        }
    }
    
    //    MARK: - Fonctions Requête Utilisateur
    public func updateUserInformation() {
        let user = backendless.userService.currentUser
        backendless.userService.update(user, response: { (updatedUser: BackendlessUser?) in
            print("Utilisateur mise à jour")
        }) { (fault: Fault?) in
            print("Une erreur est survenue : \(fault!.message)")
        }
    }
    
    //    MARK: - Fonctions Requêtes Taches
    public func postTask(newTask: Task) {
        let dataStore = backendless.data.of(Task().ofClass())
        dataStore?.save(newTask, response: { (result) in
            print("La nouvelle tache \(newTask.title) a bien été ajoutée à votre liste")
            NotificationCenter.default.post(name: .CreateTask, object: self, userInfo: ["success": true])
        }, error: { (fault: Fault?) in
            print("Une erreur est apparue : \(String(describing: fault))")
            NotificationCenter.default.post(name: .CreateTask, object: self, userInfo: ["success": false, "error": fault!])
        })
    }
    
    public func updateTask(updateTask: Task) {
        let dataStore = backendless.data.of(Task().ofClass())
        dataStore?.save(updateTask, response: { (updatedTask) in
            print("La tache '\(updateTask.title)'a bien été édité!")
            NotificationCenter.default.post(name: .UpdateTask, object: self, userInfo: ["success": true])
        }, error: { (fault: Fault?) in
            print("Une erreur est survenue : \(String(describing: fault))")
            NotificationCenter.default.post(name: .UpdateTask, object: self, userInfo: ["success": false, "error": fault!])
        })
    }
}

