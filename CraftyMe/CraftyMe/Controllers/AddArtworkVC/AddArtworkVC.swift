//
//  AddArtworkVC.swift
//  CraftyMe
//
//  Created by Daksh Upadhyay on 2021-11-26.
//

import UIKit
import MobileCoreServices
import IQDropDownTextField
import Firebase
import FirebaseStorage

class AddArtworkVC: DUBaseVC {
    
    //MARK: - Outlets
    @IBOutlet weak var imgArtwork: UIImageView!
    @IBOutlet weak var txtTitle: DUTextField!
    @IBOutlet weak var txtDescription: UITextView!
    @IBOutlet weak var txtCreatedDate: IQDropDownTextField!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var btnSave: DUButton!
    @IBOutlet weak var btnDelete: DUButton!
    
    var imagePicker = UIImagePickerController()
    var artwork = Artwork()
    var user = User()
    var artworkImage: UIImage?
    var isNew : Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initializeTextField()
        if self.isNew {
            self.lblTitle.text = "Add Artwork"
            self.btnDelete.isHidden = true
            self.btnSave.setTitle("Save", for: .normal)
        } else {
            self.lblTitle.text = "Update Artwork"
            self.btnDelete.isHidden = false
            self.btnSave.setTitle("Update", for: .normal)
            self.loadData()
        }
    }
    
    func loadData() {
        self.txtTitle.text = self.artwork.title        
        if let createdDate = self.artwork.createdDate {
            self.txtCreatedDate.date = getDate(strDate: createdDate)
        }
        self.txtDescription.text = self.artwork.artDescription
        self.imgArtwork.sd_setImage(with: URL(string: artwork.artworkImageUrl ?? ""), placeholderImage: UIImage(named: "logo.png"))
        
        self.imgArtwork.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        
        UIView.animate(withDuration: 2.0, animations: {
            self.imgArtwork.transform = CGAffineTransform(scaleX: 1, y: 1)
        })
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
    
    func initializeTextField() {
        
        self.txtCreatedDate.dropDownMode = .datePicker
        self.txtCreatedDate.placeholder = "Select Artwork Created Date"
        
        self.txtCreatedDate.datePicker.minimumDate = Date().dateBeforeDays(days: 730) //MINIMUM 2 Years
        self.txtCreatedDate.datePicker.maximumDate = Date().dateAfterDays(days: 730) //MAXIMUM 2 Years
        self.txtCreatedDate.dateTimeFormatter = appDateFormatterWithSingleHourFormat()
        
        self.txtCreatedDate.keyboardToolbar.doneBarButton.setTarget(self, action: #selector(self.doneAction(_:)))
        
        self.txtCreatedDate.delegate = self
    }
    
    @IBAction func btnSaveAction(_ sender: Any) {
        
        if self.isNew {
            if self.artworkImage == nil{
                self.saveArtwork()
            }else{
                self.saveWithMedia()
            }
        } else {
            if self.artworkImage == nil{
                self.updateArtWork()
            }else{
                self.updateWithMedia()
            }
        }
        
        DUMessage.showSuccessWithMessage(message: self.isNew ? "Artwork Added successfully" : "Artwork updated successfully")
        self.goBack()
        
    }
    
    @IBAction func btnDeleteAction(_ sender: Any) {
        self.showDeleteConfirmation()
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

extension AddArtworkVC: IQDropDownTextFieldDelegate {
    
    // MARK: - IQDropDownTextFieldDelegate
    
    @objc func doneAction(_ sender : IQDropDownTextField) {
        self.txtCreatedDate.date = sender.datePicker.date
    }
}

//Firebase

extension AddArtworkVC {
        
    func saveWithMedia() {
        if let userId = self.user.id {
            let storageRef = Storage.storage().reference().child("\(userId)_ARTWORK_\(self.timestamp).png")
            if let img = self.artworkImage {
                if let uploadData = img.pngData(){
                    storageRef.putData(uploadData, metadata: nil, completion: { (metadata, error) in
                        if error != nil {
                            print("error")
                            return}
                        else{
                            storageRef.downloadURL(completion: { (url, error) in
                                print("Image URL: \((url?.absoluteString)!)")
                                self.saveArtwork(imageUrl: (url?.absoluteString)!)
                            })
                        }
                    })
                }
            }
        }
    }
    
    func updateWithMedia() {
        if let userId = self.user.id {
            let storageRef = Storage.storage().reference().child("\(userId)_ARTWORK_\(self.timestamp).png")
            if let img = self.artworkImage {
                if let uploadData = img.pngData(){
                    storageRef.putData(uploadData, metadata: nil, completion: { (metadata, error) in
                        if error != nil {
                            print("error")
                            return}
                        else{
                            storageRef.downloadURL(completion: { (url, error) in
                                print("Image URL: \((url?.absoluteString)!)")
                                self.updateArtWork(imageUrl: (url?.absoluteString)!)
                            })
                        }
                    })
                }
            }
        }
    }
    
    func saveArtwork() {
        let timeStampId = Int(self.timestamp)
        if let userId = self.user.id {
            self.firebaseRef.child("users").child(userId).child("artworks").child("\(timeStampId)").setValue([
                "id": "\(timeStampId)",
                "title" : "\(self.txtTitle.text!)",
                "createdDate": self.txtCreatedDate.date?.getFullDateInDefaultFormat() ?? Date().getFullDateInDefaultFormat(),
                "artDescription": "\(self.txtDescription.text!)"
            ])
            fireNotification()
        }
    }
    
    func saveArtwork(imageUrl: String) {
        let timeStampId = Int(self.timestamp)
        if let userId = self.user.id {
            self.firebaseRef.child("users").child(userId).child("artworks").child("\(timeStampId)").setValue([
                "id": "\(timeStampId)",
                "title" : "\(self.txtTitle.text!)",
                "createdDate": self.txtCreatedDate.date?.getFullDateInDefaultFormat() ?? Date().getFullDateInDefaultFormat(),
                "artDescription": "\(self.txtDescription.text!)",
                "artworkImageUrl": imageUrl
            ])
            fireNotification()
        }
    }
    
    func deleteArtwork() {
        if let id = self.artwork.id, let userId = self.user.id {
            self.firebaseRef.child("users").child(userId).child("artworks").child(id).removeValue()
        }
        DUMessage.showSuccessWithMessage(message: "Deleted successfully")
        self.goBack()
    }
    
    func updateArtWork(imageUrl: String) {
        if let userId = self.user.id, let id = self.artwork.id {
            self.firebaseRef.child("users").child(userId).child("artworks").child(id).updateChildValues([
                "title" : self.txtTitle.text!,
                "createdDate": self.txtCreatedDate.date?.getFullDateInDefaultFormat() ?? Date().getFullDateInDefaultFormat(),
                "artDescription": "\(self.txtDescription.text!)",
                "artworkImageUrl": imageUrl
            ])
            fireNotification()
            DUMessage.showSuccessWithMessage(message: "Profile updated successfully.")
        }
    }
    
    func updateArtWork() {
        if let userId = self.user.id, let id = self.artwork.id {
            self.firebaseRef.child("users").child(userId).child("artworks").child(id).updateChildValues([
                "title" : self.txtTitle.text!,
                "createdDate": self.txtCreatedDate.date?.getFullDateInDefaultFormat() ?? Date().getFullDateInDefaultFormat(),
                "artDescription": "\(self.txtDescription.text!)"
            ])
            fireNotification()
            DUMessage.showSuccessWithMessage(message: "Profile updated successfully.")
        }
    }
    
    func showDeleteConfirmation() {
            
            let alert = UIAlertController(title: "Delete", message: kAreYouSureToDeleteArtwork, preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Delete", style: .default, handler: { (_) in
                self.deleteArtwork()
            }))
            
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (_) in
                
            }))
            
            self.present(alert, animated: true, completion: nil)
        }
    
    func getDate(strDate: String) -> Date? {
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .medium
            dateFormatter.timeStyle = .none
            dateFormatter.locale = Locale.current
            print(dateFormatter.date(from: strDate))
            return dateFormatter.date(from: strDate) // replace Date String
    }
    
    func fireNotification(){        
        let content = UNMutableNotificationContent()
        if(isNew){
            content.title = "Artwork Added Successfully"
            content.body = "Your Artwork Was Added Successfully"
        }else{
            content.title = "Artwork Update Successfully"
            content.body = "Your Artwork Was Updated Successfully"
        }
        content.sound = UNNotificationSound.default

        // show this notification in two seconds from now
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 2, repeats: false)

        // choose a random identifier
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

        // add our notification request
        UNUserNotificationCenter.current().add(request)
            
    }
}
