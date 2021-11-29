//
//  ProfileVC.swift
//  CraftyMe
//
//  Created by Daksh Upadhyay on 2021-11-26.
//

import UIKit
import MobileCoreServices

class ProfileVC: DUBaseVC {
    
    //MARK: - Outlets
    @IBOutlet weak var btnImagePicker: UIButton!
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var txtFirstName: DUTextField!
    @IBOutlet weak var txtLastName: DUTextField!
    @IBOutlet weak var txtEmail: DUTextField!
    var imagePicker = UIImagePickerController()
    
    var profileImage: UIImage?
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }    
    
    //MARK: - Actions
    @IBAction func btnBackAction(_ sender: Any) {
        self.goBack()
    }
    
    @IBAction func btnImageAction(_ sender: Any) {
        let actionSheet = UIAlertController(title: "Upload Photo", message: "Select an option", preferredStyle: .actionSheet)
                
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (_) in
            self.selectImage(sourceType: .camera)
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { (_) in
            self.selectImage(sourceType: .photoLibrary)
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (_) in
            
        }))
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    func selectImage(sourceType: UIImagePickerController.SourceType) {
            imagePicker.modalPresentationStyle = .fullScreen
            imagePicker.delegate = self
            imagePicker.allowsEditing = false
            imagePicker.sourceType = sourceType
            imagePicker.mediaTypes = [kUTTypeImage as String]
            imagePicker.modalPresentationStyle = .fullScreen
            self.present(imagePicker, animated: true, completion: nil)
        }
    
    @IBAction func btnSaveAction(_ sender: Any) {
        
    }
    
    @IBAction func btnLogoutAction(_ sender: Any) {
        self.showLogoutConfirmation()
    }
    
    
}

extension ProfileVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func showLogoutConfirmation() {
        let alert = UIAlertController(title: "Logout", message: kAreYouSureToLogout, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Logout", style: .default, handler: { (_) in
            UserManager.sharedManager().logout()
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (_) in
            
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        self.profileImage = (info[UIImagePickerController.InfoKey.originalImage] as? UIImage)!
        self.imgProfile.image = self.profileImage
        picker.dismiss(animated: true, completion: nil)
    }
}
