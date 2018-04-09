//
//  LIbraryAPI.swift
//  EpitechEisenhower
//
//  Created by Kevin Djedje on 17/03/2018.
//

import Foundation

final class LibraryAPI {
    
    static let shared : LibraryAPI = LibraryAPI()
    let httpClient: HTTPClient = HTTPClient.shared
    
    private init () {}
    
    //    MARK: - Fonctions Connexion/Inscription
    public func register(user: User) {
        httpClient.register(email: user.email, password: user.password)
    }
    
    public func login(user: User) {
        httpClient.login(email: user.email, password: user.password)
    }
    
    public func loginWithFacebook(token: Token) {
        httpClient.loginWithFacebook(token: token)
    }
    
    //    MARK: - Déconnexion
    public func logoutBlock() {
        httpClient.logoutBlock()
    }
    public func logoutAsync() {
        httpClient.logoutAsync()
    }
    
    //    MARK: - Fonctions liées à l'utilisateur
    public func updateUser(user: BackendlessUser) {
        httpClient.updateUserInformation(user: user)
    }
    
    //    MARK: - Fonctions liées aux taches
    public func addTask(newTask: Task) {
        httpClient.postTask(newTask: newTask)
    }
    
    public func updateTask(updateTask: Task) {
        httpClient.updateTask(updateTask: updateTask)
    }
    
    public func getTask() {
        httpClient.getTask()
    }
    
    public func removeTask(deletedTask: Task) {
        httpClient.removeTask(deletedTask: deletedTask)
    }
    
    public func setRelationBetweenCurrentUserToTask(task: Task) {
        httpClient.addRelationBetweenCurrentUserAndTask(task: task)
    }
}
