//
//  User.swift
//  Sweeper
//
//  Created by Paul Sokolik on 10/13/17.
//  Copyright © 2017 team11. All rights reserved.
//

import Foundation
import UIKit
import Parse

class User: PFUser {
    static let userDidLogoutKey = "user_logged_out"
    
    @NSManaged var firstName: String?
    @NSManaged var lastName: String?
    @NSManaged var caption: String?
    @NSManaged var profileImageUrl: URL?
    
    private static var _currentUser: User?
    static var currentUser: User? {
        get {
            if _currentUser == nil {
                _currentUser = current()
            }
            return _currentUser
        }
        set(user) {
            _currentUser = user
            do {
                try user?.save()
            } catch {
                print("Save user error")
            }
        }
    }
    
    func getFullName() -> (String) {
        var result = ""
        if self.firstName != nil {
            result += "\(self.firstName!)"
        }
        
        if self.lastName != nil {
            if result.characters.count > 0 {
                result += " "
            }
            result += "\(self.lastName!)"
        }
        return result
    }
}