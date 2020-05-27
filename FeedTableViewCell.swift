//
//  FeedTableViewCell.swift
//  ParseStarterProject-Swift
//
//  Created by Luis Juarez on 11/15/16.
//  Copyright © 2016 Parse. All rights reserved.
//

import UIKit

class FeedTableViewCell: UITableViewCell {

    @IBOutlet var messageLabel: UILabel!
    
    @IBOutlet var usernameLabel: UILabel!
    
    @IBOutlet var postedImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
