//
//  MessageTableViewCell.swift
//  Pinterest
//
//  Created by Nicholas Rode on 5/1/16.
//  Copyright © 2016 Razeware LLC. All rights reserved.
//

import UIKit

class MessageTableViewCell: UITableViewCell {

    @IBOutlet weak var receiving: UILabel!
    @IBOutlet weak var sending: UILabel!
    
    var message: messages? {
        didSet {
            if (message?.recieved)! == 1
            {
                receiving.alpha = 1
                receiving.text = message?.message
                sending.text = ""
                sending.alpha = 0
            }
            else
            {
                sending.alpha = 1
                sending.text = message?.message
                receiving.text = ""
                receiving.alpha = 0
                
            }
        }
    }

    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
