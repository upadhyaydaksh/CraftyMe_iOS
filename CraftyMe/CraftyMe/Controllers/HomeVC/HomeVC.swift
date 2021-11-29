//
//  HomeVC.swift
//  CraftyMe
//
//  Created by Daksh Upadhyay on 2021-11-26.
//

import UIKit

class HomeVC: DUBaseVC {
    
    //MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.registerTableViewCell()
        
    }
    
    func registerTableViewCell() {
        self.tableView.register(UINib(nibName: HomeTableViewCell.reUserIdentifier(), bundle: nil), forCellReuseIdentifier: HomeTableViewCell.reUserIdentifier())
    }
    
    //MARK: - Actions
    @IBAction func btnAddAction(_ sender: Any) {
        let obj = AddArtworkVC.instantiate()
        self.push(vc: obj)
    }
    
    

}
