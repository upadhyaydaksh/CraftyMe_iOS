//
//  AppDelegate + Additions.swift
//  CraftyMe
//
//  Created by Daksh Upadhyay on 2021-11-28.
//

import Foundation
import UIKit

extension AppDelegate {
    
    func setHomeVC() {
            let nav: NavigationController = UIStoryboard.main().instantiateViewController(withIdentifier: "NavigationController") as! NavigationController
            let obj = HomeVC.instantiate()
            nav.setViewControllers([obj], animated: false)
            nav.isNavigationBarHidden = true
            self.window?.rootViewController = nav
            self.window?.makeKeyAndVisible()
        }
        
        func setRootViewController() {
            if UserManager.sharedManager().isUserLoggedIn() {
                // Move to HomeVC
                self.setHomeVC()
            } else {
                UserManager.sharedManager().deleteActiveUser()
                //Set login page as root
                let nav: NavigationController = UIStoryboard.main().instantiateViewController(withIdentifier: "NavigationController") as! NavigationController
                let obj = LoginVC.instantiate()
                nav.setViewControllers([obj], animated: false)
                nav.isNavigationBarHidden = true
                self.window?.rootViewController = nav
            }
        }
}
