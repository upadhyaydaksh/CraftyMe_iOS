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
        if let createdDate = artwork.createdDate {
            self.lblCreatedDate.text = createdDate
        }
        self.lblDescription.text = artwork.artDescription
        self.imgArtWork.sd_setImage(with: URL(string: artwork.artworkImageUrl ?? ""), placeholderImage: UIImage(named: "logo.png"))
        
        self.imgArtWork.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        UIView.animate(withDuration: 2.0, animations: {
            self.imgArtWork.transform = CGAffineTransform(scaleX: 1, y: 1)
        })
    }
    
    func getDate(strDate: String) -> Date? {
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .medium
            dateFormatter.timeStyle = .none
            dateFormatter.locale = Locale.current
            print(dateFormatter.date(from: strDate))
            return dateFormatter.date(from: strDate) // replace Date String
        }
    
}
