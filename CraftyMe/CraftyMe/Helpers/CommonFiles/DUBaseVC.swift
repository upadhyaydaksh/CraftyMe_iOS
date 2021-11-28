//
//  DUBaseVC.swift
//  CraftyMe
//
//  Created by Daksh Upadhyay on 2021-11-27.
//

import Foundation
import UIKit

class DUBaseVC: UIViewController {
    
    class func identifier() -> String {
        return String(describing: self)
    }
    
    func push(vc: UIViewController) {
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func goBack() {
        self.navigationController?.popViewController(animated: true)
    }
    
//    class func instantiate() -> HomeVC {
//        return UIStoryboard.main().instantiateViewController(identifier: HomeVC.identifier()) as! HomeVC
//    }
    
}
