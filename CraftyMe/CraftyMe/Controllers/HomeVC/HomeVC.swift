//
//  HomeVC.swift
//  CraftyMe
//
//  Created by Daksh Upadhyay on 2021-11-26.
//

import UIKit
import Foundation
import Firebase
import ObjectMapper

class HomeVC: DUBaseVC {
    
    //MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    
    var user = User()
    var artworks : [Artwork] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.registerTableViewCell()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.user = UserManager.sharedManager().activeUser
        self.getArtworks()
    }
    
    func registerTableViewCell() {
        self.tableView.register(UINib(nibName: HomeTableViewCell.reUserIdentifier(), bundle: nil), forCellReuseIdentifier: HomeTableViewCell.reUserIdentifier())
    }
    
    //MARK: - Actions
    @IBAction func btnAddAction(_ sender: Any) {
        let obj = AddArtworkVC.instantiate()
        obj.isNew = true
        self.push(vc: obj)
    }
    
    @IBAction func btnProfileAction(_ sender: Any) {
        let obj = ProfileVC.instantiate()
        self.push(vc: obj)
    }
    

}

extension HomeVC {
 
    func getArtworks() {
        self.artworks.removeAll()
        if let userId = self.user.id{
            let placeRef = self.firebaseRef.child("users").child(userId).child("artworks")
            placeRef.observeSingleEvent(of: .value, with: { snapshot in
                if(snapshot.childrenCount > 0){
                    for child in snapshot.children {
                        let snap = child as! DataSnapshot
                        let placeDict = snap.value as! [String: Any]
                        if let artwork: Artwork = Mapper<Artwork>().map(JSON: placeDict) {
                            self.artworks.append(artwork)
                        }                       
                    }
                    self.tableView.reloadData()
                }
                else{
                    self.tableView.reloadData()
                }
            })
        }
    }
}
