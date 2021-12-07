//
//  AddArtworkVC.swift
//  CraftyMe
//
//  Created by Daksh Upadhyay on 2021-11-26.
//

import UIKit
import MobileCoreServices

class AddArtworkVC: DUBaseVC {
    
    //MARK: - Outlets
    @IBOutlet weak var imgArtwork: UIImageView!
    @IBOutlet weak var txtTitle: DUTextField!
    @IBOutlet weak var txtDescription: UITextView!
    @IBOutlet weak var txtCreatedDate: DUTextField!
    @IBOutlet weak var lblTitle: UILabel!
    
    var imagePicker = UIImagePickerController()
    var artwork = Artwork()
    var user = User()
    var artworkImage: UIImage?
    
    var isFromHome : Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if isFromHome {
            self.lblTitle.text = "Update"
        } else {
            self.lblTitle.text = "Add"
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.user = UserManager.sharedManager().activeUser
    }
    
    //MARK: - Actions
    @IBAction func btnImgAction(_ sender: Any) {
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
        self.saveArtwork()
    }
    
    @IBAction func btnDeleteAction(_ sender: Any) {
        self.deleteArtwork()
    }
    
    @IBAction func btnGoBackAction(_ sender: Any) {
        self.goBack()
    }
    
    
}

extension AddArtworkVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        self.artworkImage = (info[UIImagePickerController.InfoKey.originalImage] as? UIImage)!
        self.imgArtwork.image = self.artworkImage
        picker.dismiss(animated: true, completion: nil)
    }
}

extension AddArtworkVC {
    
    func saveArtwork() {
        let timeStampId = Int(self.timestamp)
        self.firebaseRef.child("users").child(self.user.id!).child("artworks").child("\(timeStampId)").setValue([
            "id": "\(timeStampId)",
            "title" : "\(self.txtTitle.text!)"
        ])
        self.goBack()
    }
    
    func deleteArtwork() {
        if let id = self.artwork.id {
            self.firebaseRef.child("users").child(self.user.id!).child("artworks").child(id).removeValue()
        }
        DUMessage.showSuccessWithMessage(message: "Deleted successfully")
        self.goBack()
    }
}
