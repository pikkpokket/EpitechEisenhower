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
    let RELATION_NAME = "userID"
    
    let KEY_SUCCESS = "success"
    let KEY_ERROR = "error"
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
            NotificationCenter.default.post(name: .RegisterUser, object: self, userInfo: [self.KEY_SUCCESS: true])
        }) { (fault: Fault?) in
            NotificationCenter.default.post(name: .RegisterUser, object: self, userInfo: [self.KEY_SUCCESS: false, self.KEY_ERROR: fault!])
        }
    }
    
    public func login(email: String, password: String) {
        print("LOGIN : \(email) || \(password)")
        backendless.userService.login(email, password: password, response: { (userLogged: BackendlessUser?) in
            NotificationCenter.default.post(name: .LoginUser, object: self, userInfo: [self.KEY_SUCCESS: true])
        }) { (fault: Fault?) in
            NotificationCenter.default.post(name: .LoginUser, object: self, userInfo: [self.KEY_SUCCESS: false, self.KEY_ERROR: fault!])
        }
    }
    
    public func loginWithFacebook(token: Token) {
        let userID = token.accessToken.userId
        let tokenString = token.accessToken.authenticationToken
        let expirationDate = token.accessToken.expirationDate
        let fieldsMapping = NSDictionary(dictionary: ["email": "email"])
        
        backendless.userService.login(withFacebookSDK: userID, tokenString: tokenString, expirationDate: expirationDate, fieldsMapping: fieldsMapping, response: { (userLogged: BackendlessUser?) in
            NotificationCenter.default.post(name: .FacebookLogin, object: self, userInfo: [self.KEY_SUCCESS : true])
        }) { (fault: Fault?) in
            NotificationCenter.default.post(name: .FacebookLogin, object: self, userInfo: [self.KEY_SUCCESS: false, self.KEY_ERROR : fault!])
        }
    }
    
    //    MARK: - Deconnexion
    
    public func logoutBlock() {
        backendless.userService.logout()
    }
    
    public func logoutAsync() {
        backendless.userService.logout({ (result) in
            print("Utilisateur déconnecté")
        }) { (fault) in
            print("Erreur survenue : \(fault!.message)")
        }
    }
    
    //    MARK: - Fonctions Requête Utilisateur
    public func updateUserInformation(user: BackendlessUser) {
        backendless.userService.update(user, response: { (updatedUser: BackendlessUser?) in
            NotificationCenter.default.post(name: .UpdateUser, object: self, userInfo: [self.KEY_SUCCESS: true])
        }) { (fault: Fault?) in
            NotificationCenter.default.post(name: .UpdateUser, object: self, userInfo: [self.KEY_SUCCESS: false, self.KEY_ERROR: fault!])
        }
    }
    
    //    MARK: - Fonctions Requêtes Taches
    public func postTask(newTask: Task) {
        let dataStore = backendless.data.of(Task().ofClass())
        dataStore?.save(newTask, response: { (result) in
            print("La nouvelle tache \(newTask.title) a bien été ajoutée à votre liste")
            NotificationCenter.default.post(name: .CreateTask, object: self, userInfo: [self.KEY_SUCCESS: true, "newTask" : result])
        }, error: { (fault: Fault?) in
            print("Une erreur est apparue : \(String(describing: fault))")
            NotificationCenter.default.post(name: .CreateTask, object: self, userInfo: [self.KEY_SUCCESS: false, self.KEY_ERROR: fault!])
        })
    }
    
    public func updateTask(updateTask: Task) {
        let dataStore = backendless.data.of(Task.ofClass())
        dataStore?.save(updateTask, response: { (updatedTask) in
            print("La tache '\(updateTask.title)'a bien été édité!")
            NotificationCenter.default.post(name: .UpdateTask, object: self, userInfo: [self.KEY_SUCCESS: true])
        }, error: { (fault: Fault?) in
            print("Une erreur est survenue : \(String(describing: fault))")
            NotificationCenter.default.post(name: .UpdateTask, object: self, userInfo: [self.KEY_SUCCESS: false, self.KEY_ERROR: fault!])
        })
    }
    
    
    public func getTask() {
        let dataStore = backendless.data.of(BackendlessUser.ofClass())
        // Prepare LoadRelationsQueryBuilder
        let loadRelationsQueryBuilder = LoadRelationsQueryBuilder.of(Task.ofClass())
        loadRelationsQueryBuilder?.setRelationName(RELATION_NAME)
        let objectId = String(backendless.userService.currentUser.objectId)
        
        print("objectID : \(objectId)")
        
        dataStore!.loadRelations(objectId,queryBuilder: loadRelationsQueryBuilder,response: { tasks in
                                    NotificationCenter.default.post(name: .GetTask, object: self, userInfo: [self.KEY_SUCCESS : true, "tasks": tasks!])
        },
                                 error: { fault in
                                    NotificationCenter.default.post(name: .GetTask, object: self, userInfo: [self.KEY_SUCCESS: false, self.KEY_ERROR: fault!])
        })
    }
    
    public func removeTask(deletedTask: Task) {
        let dataStore = backendless.data.of(Task.ofClass())
        
        dataStore!.remove(deletedTask, response: { (resultNumber) in
            print("Success")
        }) { (fault: Fault?) in
            print("Error : \(fault!.message)")
        }
    }
    
    public func addRelationBetweenCurrentUserAndTask(task: Task) {
        let dataStore = backendless.data.of(BackendlessUser.ofClass())
        dataStore?.addRelation("userID", parentObjectId: String(backendless.userService.currentUser.objectId), childObjects: [task.objectId], response: { (resultNumber) in
            print("Relation between User and Task is succeed")
        }, error: { (fault: Fault?) in
            print("Error with \(fault!.message)")
        })
    }
    
}

