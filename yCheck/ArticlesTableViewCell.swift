//
//  ArticlesTableViewCell.swift
//  yCheck
//
//  Created by Hint Desktop on 01/10/2017.
//  Copyright © 2017 Yacine.M. All rights reserved.
//

import UIKit

class ArticlesTableViewCell: UITableViewCell {

    @IBOutlet var Author: UILabel!
    @IBOutlet var Title: UILabel!
    @IBOutlet var Description: UILabel!
    @IBOutlet var Date: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
