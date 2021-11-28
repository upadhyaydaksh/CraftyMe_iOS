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
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: HomeTableViewCell = tableView.dequeueReusableCell(withIdentifier: HomeTableViewCell.reUserIdentifier()) as! HomeTableViewCell
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let obj = AddArtworkVC.instantiate()
        obj.isFromHome = true
        self.push(vc: obj)
    }
    
}
