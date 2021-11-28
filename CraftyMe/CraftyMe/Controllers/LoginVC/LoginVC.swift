//
//  LoginVC.swift
//  CraftyMe
//
//  Created by Daksh Upadhyay on 2021-11-26.
//

import UIKit

class LoginVC: DUBaseVC {

    //MARK: - Outlets
    @IBOutlet weak var txtEmail: DUTextField!
    @IBOutlet weak var txtPassword: DUTextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    class func instantiate() -> LoginVC {
        return UIStoryboard.main().instantiateViewController(identifier: LoginVC.identifier()) as! LoginVC
    }
    
    //MARK: - Actions
    @IBAction func btnLoginAction(_ sender: Any) {
        
    }
    
    @IBAction func btnSignUpAction(_ sender: Any) {
        
    }
    

}
