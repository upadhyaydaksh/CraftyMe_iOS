//
//  SignUpVC.swift
//  CraftyMe
//
//  Created by Daksh Upadhyay on 2021-11-26.
//

import UIKit

class SignUpVC: DUBaseVC {
    
    //MARK: - Outlets
    @IBOutlet weak var txtFirstName: DUTextField!
    @IBOutlet weak var txtLastName: DUTextField!
    @IBOutlet weak var txtEmail: DUTextField!
    @IBOutlet weak var txtPassword: DUTextField!
    @IBOutlet weak var txtConfirmPassword: DUTextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    class func instantiate() -> SignUpVC {
        return UIStoryboard.main().instantiateViewController(identifier: SignUpVC.identifier()) as! SignUpVC
    }
    
    //MARK: - Actions
    @IBAction func btnSignUpAction(_ sender: Any) {
        
    }
    
    @IBAction func btnGoBackAction(_ sender: Any) {
        
    }
    
    

}
