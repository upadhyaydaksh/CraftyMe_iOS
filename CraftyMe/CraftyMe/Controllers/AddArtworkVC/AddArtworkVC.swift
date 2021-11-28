//
//  AddArtworkVC.swift
//  CraftyMe
//
//  Created by Daksh Upadhyay on 2021-11-26.
//

import UIKit

class AddArtworkVC: DUBaseVC {
    
    //MARK: - Outlets
    @IBOutlet weak var imgArtwork: UIImageView!
    @IBOutlet weak var txtTitle: DUTextField!
    @IBOutlet weak var txtDescription: UITextView!
    @IBOutlet weak var txtCreatedDate: DUTextField!
    @IBOutlet weak var lblTitle: UILabel!
    
    var isFromHome : Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if isFromHome {
            self.lblTitle.text = "Update"
        } else {
            self.lblTitle.text = "Add Artwork"
        }
    }
    

    class func instantiate() -> AddArtworkVC {
        return UIStoryboard.main().instantiateViewController(identifier: AddArtworkVC.identifier()) as! AddArtworkVC
    }
    
    //MARK: - Actions
    @IBAction func btnImageAction(_ sender: Any) {
        
    }
    
    
    @IBAction func btnSaveAction(_ sender: Any) {
        
    }
    
    @IBAction func btnDeleteAction(_ sender: Any) {
        
    }
    
    @IBAction func btnGoBackAction(_ sender: Any) {
        self.goBack()
    }
    
    
}
