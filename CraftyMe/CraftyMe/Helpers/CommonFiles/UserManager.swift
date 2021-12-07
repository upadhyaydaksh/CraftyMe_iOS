//
//  UserManager.swift
//  CraftyMe
//
//  Created by Daksh Upadhyay on 2021-11-28.
//

import Foundation
import UIKit
import SVProgressHUD
import ObjectMapper

class UserManager: NSObject {
    
    fileprivate var _activeUser: User?
    
    var activeUser: User! {
        get {
            return _activeUser
        }
        set {
            _activeUser = newValue
            
            if let _ = _activeUser {
                self.saveActiveUser()
            }
        }
    }
    
    // MARK: - KeyChain / User Defaults / Flat file / XML
    
    /**
     Load last logged user data, if any
     */
    func loadActiveUser() {
        
        guard let decodedUser = UserDefaults.standard.object(forKey: Constants.UserDefaultKeys.ACTIVE_USER_KEY) as? Data,
            let user = NSKeyedUnarchiver.unarchiveObject(with: decodedUser) as? User
            else {
                return
        }
        self.activeUser = user
    }
    
    /**
     Save current user data
     */
    func saveActiveUser() {
        UserDefaults.standard.set(NSKeyedArchiver.archivedData(withRootObject: self.activeUser!) as AnyObject?, forKey: Constants.UserDefaultKeys.ACTIVE_USER_KEY)
        UserDefaults.standard.synchronize()
    }
    
    
    /**
     Delete current user data
     */
    func deleteActiveUser() {
        // remove active user from storage
        UserDefaults.standard.removeObject(forKey: Constants.UserDefaultKeys.ACTIVE_USER_KEY)
        UserDefaults.standard.synchronize()
        // free user object memory
        self.activeUser = nil
        
        UIApplication.shared.applicationIconBadgeNumber = 0
    }
    
    // MARK: Singleton Instance
    fileprivate static let _sharedManager = UserManager()
    
    class func sharedManager() -> UserManager {
        return _sharedManager
    }
    
    
    fileprivate override init() {
        // initiate any queues / arrays / filepaths etc
        super.init()
        
        // Load last logged user data if exists
        if isUserLoggedIn() {
            loadActiveUser()
        }
    }
    
    func isUserLoggedIn() -> Bool {
        guard let _ = UserDefaults.standard.object(forKey: Constants.UserDefaultKeys.ACTIVE_USER_KEY)
            else {
                return false
        }
        return true
    }
    
    func logout() {
        self.deleteActiveUser()
        appDel.setRootViewController()
    }
    
}
