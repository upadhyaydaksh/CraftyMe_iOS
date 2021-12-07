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
    
}
