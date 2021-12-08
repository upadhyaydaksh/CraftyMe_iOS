//
//  HomeVC + TableView.swift
//  CraftyMe
//
//  Created by Daksh Upadhyay on 2021-11-27.
//

import Foundation
import UIKit

extension HomeVC: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.artworks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: HomeTableViewCell = tableView.dequeueReusableCell(withIdentifier: HomeTableViewCell.reUserIdentifier()) as! HomeTableViewCell
        cell.configureCell(artwork: self.artworks[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let obj = AddArtworkVC.instantiate()
        obj.isNew = false
        obj.artwork = self.artworks[indexPath.row]
        self.push(vc: obj)
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {

        // action one
        let editAction = UITableViewRowAction(style: .default, title: "Edit", handler: { (action, indexPath) in
            let obj = AddArtworkVC.instantiate()
            obj.artwork = self.artworks[indexPath.row]
            obj.isNew = false
            self.push(vc: obj)
        })
        editAction.backgroundColor = UIColor.blue

        // action two
        let deleteAction = UITableViewRowAction(style: .default, title: "Delete", handler: { (action, indexPath) in
            self.showDeleteConfirmation(id: self.artworks[indexPath.row].id)
            
        })
        deleteAction.backgroundColor = UIColor.red

        return [editAction, deleteAction]
    }
    
    func showDeleteConfirmation(id: String?) {
        
        let alert = UIAlertController(title: "Delete", message: kAreYouSureToDeleteArtwork, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Delete", style: .default, handler: { (_) in
            self.deleteSubscription(id: id)
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (_) in
            
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func deleteSubscription(id: String?) {
        if let id = id, let userId = self.user.id {
            self.firebaseRef.child("users").child(userId).child("artworks").child(id).removeValue()
            
        }
        DUMessage.showSuccessWithMessage(message: "Deleted successfully")
        self.getArtworks()
    }
    
    
    
}
