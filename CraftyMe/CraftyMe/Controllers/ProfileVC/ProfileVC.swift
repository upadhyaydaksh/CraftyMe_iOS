//
//  ProfileVC.swift
//  CraftyMe
//
//  Created by Daksh Upadhyay on 2021-11-26.
//

import UIKit

class ProfileVC: DUBaseVC {
    
    //MARK: - Outlets
    @IBOutlet weak var txtFirstName: DUTextField!
    @IBOutlet weak var txtLastName: DUTextField!
    @IBOutlet weak var txtEmail: DUTextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    class func instantiate() -> ProfileVC {
        return UIStoryboard.main().instantiateViewController(identifier: ProfileVC.identifier()) as! ProfileVC
    }
    
    //MARK: - Actions
    @IBAction func btnImageAction(_ sender: Any) {
        
    }
    
    @IBAction func btnSaveAction(_ sender: Any) {
        
    }
    
    @IBAction func btnLogoutAction(_ sender: Any) {
        
    }
    
    
}
