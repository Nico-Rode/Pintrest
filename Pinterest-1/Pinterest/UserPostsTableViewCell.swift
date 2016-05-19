//
//  UserPostsTableViewCell.swift
//  Pinterest
//
//  Created by Nicholas Rode on 5/12/16.
//  Copyright © 2016 Razeware LLC. All rights reserved.
//

import UIKit

class UserPostsTableViewCell: UITableViewCell {

    @IBOutlet weak var imagez: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var descriptionz: UILabel!
//    @IBOutlet weak var price: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    var photo: Book? {
        didSet {
            print("SETTING THE OBJECT TO DISPLAY")
            if let photo = photo {
                imagez.image = photo.image
                title.text = photo.title
                descriptionz.text = photo.description
//                price.text = "$" + photo.price
                
            }
        }
    }
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
