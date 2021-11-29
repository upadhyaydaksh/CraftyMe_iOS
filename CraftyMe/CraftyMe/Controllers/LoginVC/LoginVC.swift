//
//  LoginVC.swift
//  CraftyMe
//
//  Created by Daksh Upadhyay on 2021-11-26.
//

import UIKit
import Firebase

class LoginVC: DUBaseVC {

    //MARK: - Outlets
    @IBOutlet weak var txtEmail: DUTextField!
    @IBOutlet weak var txtPassword: DUTextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }    
    
    //MARK: - Actions
    @IBAction func btnLoginAction(_ sender: Any) {
        self.login() { success in
            if success{
                let obj = HomeVC.instantiate()
                self.push(vc: obj)
            }else{
                // Error Message
                self.showAlertWithMessage(message: "Failed to Login. Try Again")
            }
        }
    }
    
    @IBAction func btnSignUpAction(_ sender: Any) {
        let obj = SignUpVC.instantiate()
        self.push(vc: obj)
    }
    

}

extension LoginVC{
    func login(completionBlock: @escaping (_ success: Bool) -> Void) {
        Auth.auth().signIn(withEmail: self.txtEmail.text!, password: self.txtPassword.text!) { (authResult, error) in
            if let user = authResult?.user {
                completionBlock(true)
            } else {                
                completionBlock(false)
            }
        }
    }
}
