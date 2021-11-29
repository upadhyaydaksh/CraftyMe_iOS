//
//  SignUpVC.swift
//  CraftyMe
//
//  Created by Daksh Upadhyay on 2021-11-26.
//

import UIKit
import Firebase

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
    
    //MARK: - Actions
    @IBAction func btnSignUpAction(_ sender: Any) {
        self.createUser(email: self.txtEmail.text!, password: self.txtPassword.text!) { success in
            if success{
                self.goBack()
            }else{
                // Error Message
                self.showAlertWithMessage(message: "Failed to Sign Up. Try Again")
            }
        }
    }
    
    @IBAction func btnGoBackAction(_ sender: Any) {
        self.goBack()
    }
    
    

}

extension SignUpVC{
    func createUser(email: String, password: String, completionBlock: @escaping (_ success: Bool) -> Void) {
            Auth.auth().createUser(withEmail: email, password: password) {(authResult, error) in
                if let user = authResult?.user {
                    print(user)
                    self.firebaseRef.child("users").child(user.uid).setValue([
                        "id": user.uid,
                        "firstName" : self.txtFirstName.text!,
                        "lastName" : self.txtLastName.text!,
                        "email" : self.txtEmail.text!
                    ])
                    let user = User(id: user.uid, firstName: self.txtFirstName.text, lastName: self.txtLastName.text, email: self.txtEmail.text, profilePicture: "")
                    UserManager.sharedManager().activeUser = user
                    completionBlock(true)
                } else {
                    completionBlock(false)
                }
            }
        }
}
