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
    func login( completionBlock: @escaping (_ success: Bool) -> Void) {
        Auth.auth().signIn(withEmail: self.txtEmail.text!, password: self.txtPassword.text!) { (result, error) in
            if let error = error, let _ = AuthErrorCode(rawValue: error._code) {
                completionBlock(false)
            } else {
                
                guard let userID = Auth.auth().currentUser?.uid else { return }
                print(userID)
                
                self.firebaseRef.child("users").child(userID).observeSingleEvent(of: .value, with: { snapshot in
                    // Get user value
                    let value = snapshot.value as? NSDictionary
                    let userId = value?["id"] as? String ?? ""
                    let firstName = value?["firstName"] as? String ?? ""
                    let lastName = value?["lastName"] as? String ?? ""
                    let email = value?["email"] as? String ?? ""
                    
                    
                    let user = User(id: userId, firstName: firstName, lastName: lastName, email: email, profilePicture: "")
                    UserManager.sharedManager().activeUser = user
                    completionBlock(true)
                }) { error in
                    print(error.localizedDescription)
                }
            }
        }
    }
}
