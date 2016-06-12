//
//  MyTableViewCell.swift
//  QuotePro
//
//  Created by Jayesh Wadhwani on 2016-06-08.
//  Copyright © 2016 Jayesh Wadhwani. All rights reserved.
//

import UIKit

class MyTableViewCell: UITableViewCell {

    @IBOutlet weak var myImageView: UIImageView!
    @IBOutlet weak var authorLabel: UILabel!
    
   
    @IBOutlet weak var quoteLabel: UILabel!
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
