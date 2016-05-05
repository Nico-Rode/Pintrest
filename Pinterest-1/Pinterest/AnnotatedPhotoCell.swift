//
//  AnnotatedPhotoCell.swift
//  Pinterest
//
//  Created by Nicholas Rode on 4/2/16.
//  Copyright © 2016 Razeware LLC. All rights reserved.
//

import UIKit

class AnnotatedPhotoCell: UICollectionViewCell {
  
  @IBOutlet private weak var imageView: UIImageView!
  @IBOutlet private weak var imageViewHeightLayoutConstraint: NSLayoutConstraint!
  
    @IBOutlet weak var captionLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var Price: UILabel!
  
  var photo: Book? {
    didSet {
      if let photo = photo {
        imageView.image = photo.image
        captionLabel.text = photo.title
        print(photo.title)
        commentLabel.text = photo.description
        Price.text = "$" + photo.price
        
      }
    }
  }
    
    override func applyLayoutAttributes(layoutAttributes: UICollectionViewLayoutAttributes) {
        super.applyLayoutAttributes(layoutAttributes)
        let attributes = layoutAttributes as! PinterestLayoutAttributes
        imageViewHeightLayoutConstraint.constant = attributes.photoHeight
    }
  
}
