//
//  UserService.swift
//  Sweeper
//
//  Created by Paul Sokolik on 10/14/17.
//  Copyright © 2017 team11. All rights reserved.
//

import Foundation
import UIKit
import Parse

class UserService {    
    static let sharedInstance = UserService()
    
    func signup(username: String, password: String, completion: @escaping (Bool, Error?) -> Void) {
        let pfUser = PFUser()
        pfUser.username = username
        pfUser.password = password
        
        pfUser.signUpInBackground(block: { (success, error) in
            if success {
                let user = pfUser as? User
                // store user in local storage
                User.currentUser = user
            }
            completion(success, error)
        })
    }
    
    func login(username: String, password: String, completion: @escaping (Bool, Error?) -> Void) {
        PFUser.logInWithUsername(inBackground: username, password: password) { (pfUser, error) in
            var user: User?
            var success = false
            if pfUser != nil {
                user = pfUser as? User
                // store user in local storage
                User.currentUser = user
                success = true
            }
            completion(success, error)
        }
    }
    
    // remove stored user. View controller is responsible for view segue
    func logout() {
        User.logOut() // this will automatically set current user to nil
        NotificationCenter.default.post(Notification(name: Notification.Name(rawValue: User.userDidLogoutKey)))
    }
}
