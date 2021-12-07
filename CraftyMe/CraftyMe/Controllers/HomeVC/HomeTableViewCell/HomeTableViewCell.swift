//
//  HomeTableViewCell.swift
//  CraftyMe
//
//  Created by Daksh Upadhyay on 2021-11-27.
//

import UIKit

class HomeTableViewCell: UITableViewCell {
    
    //MARK: - Outlets
    @IBOutlet weak var imgArtWork: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var lblCreatedDate: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    class func reUserIdentifier() -> String {
        return String(describing: self)
    }
    
    func configureCell(artwork: Artwork) {
        self.lblTitle.text = artwork.title
    }
    
}
