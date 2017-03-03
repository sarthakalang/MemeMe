//
//  MemeTableViewCell.swift
//  MemeMe
//
//  Created by Sarthak on 3/3/17.
//  Copyright © 2017 Sarthak. All rights reserved.
//

import UIKit

class MemeTableViewCell: UITableViewCell {
    @IBOutlet weak var memeLabel: UILabel!    
    @IBOutlet weak var memedImage: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
