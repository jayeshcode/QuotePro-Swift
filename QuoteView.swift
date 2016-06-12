//
//  QuoteView.swift
//  QuotePro
//
//  Created by Jayesh Wadhwani on 2016-06-10.
//  Copyright © 2016 Jayesh Wadhwani. All rights reserved.
//

import UIKit

@IBDesignable class QuoteView: UIView {
 
    @IBOutlet weak var quoteLabel: UILabel!
    
    
    
    @IBOutlet weak var MyImageView: UIImageView!
    @IBOutlet weak var authorLabel: UILabel!
    
    func setUpWithQuote(model: Model) {
        
        
        quoteLabel.text = model.quote
        authorLabel.text = model.author
        MyImageView.image = model.photo
    }


}
       
    /*
     @IBOutlet weak var authorLabel: UILabel!
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
 */
