//
//  DUBaseVC.swift
//  CraftyMe
//
//  Created by Daksh Upadhyay on 2021-11-27.
//

import Foundation
import UIKit
import Firebase

class DUBaseVC: UIViewController {
    
    //MARK: - Class Variables
    let firebaseRef = Database.database().reference()
    let timestamp = NSDate().timeIntervalSince1970
    
    func push(vc: UIViewController) {
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func goBack() {
        self.navigationController?.popViewController(animated: true)
    }
    
    class func instantiate() -> Self {
        let controller = UIStoryboard.main().instantiateViewController(withIdentifier: String(describing: self))
        return controller as! Self
    }
    
    func showAlertWithMessage(message: String){
        let alertController = UIAlertController(title: applicationName(), message: message, preferredStyle: UIAlertController.Style.alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
            print(message)
        }))
        self.present(alertController, animated: true, completion: nil)
    }
}
