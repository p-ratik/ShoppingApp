//
//  CategoryTableViewCell.swift
//  Navigate
//
//  Created by Capgemini-DA161 on 9/21/22.
//

import UIKit

class CategoryTableViewCell: UITableViewCell {

    // MARK: - IBOutlets for Custon cell Category Cell starts
    @IBOutlet weak var carButton: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var customImageView: UIImageView!
    
    @IBOutlet weak var cartItemTitle: UILabel!
    @IBOutlet weak var cartItemDescription: UILabel!
    @IBOutlet weak var cartItemImageView: UIImageView!
    
    @IBOutlet weak var placeOrderButton: UIButton!
    // MARK: - IBOutlets for Custon cell Category Cell ends
    
    override func awakeFromNib() {
        super.awakeFromNib()
        customImageView?.layer.borderWidth = 0.3
        customImageView?.layer.cornerRadius = 10
        
        cartItemImageView?.layer.borderWidth = 0.3
        cartItemImageView?.layer.cornerRadius = 10
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
