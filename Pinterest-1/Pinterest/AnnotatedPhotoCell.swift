//
//  AnnotatedPhotoCell.swift
//  Pinterest
//
//  Created by Nicholas Rode on 4/2/16.
//  Copyright © 2016 Razeware LLC. All rights reserved.
//

import UIKit

class AnnotatedPhotoCell: UICollectionViewCell {
  
    @IBOutlet weak var classifiedImageViewHeightLayoutConstraint: NSLayoutConstraint!
  @IBOutlet private weak var imageView: UIImageView!
  @IBOutlet private weak var imageViewHeightLayoutConstraint: NSLayoutConstraint!
  
    @IBOutlet weak var captionLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var Price: UILabel!
  
    @IBOutlet weak var classifiedImageView: UIImageView!
    @IBOutlet weak var classifiedCommentLabel: UILabel!
    @IBOutlet weak var classifiedPrice: UILabel!
    @IBOutlet weak var classifiedCaptionLabel: UILabel!
    
    var viewPage = "Books"
    

    
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
    
    var classified: Book?
        {
        didSet {
            print("Trying to display the classifieds")
            if let classified = classified {
                classifiedImageView.image = classified.image
                classifiedCaptionLabel.text = classified.title
                classifiedCommentLabel.text = classified.description
                classifiedPrice.text = "$" + classified.price
                
            }
        }
    }
    
    override func applyLayoutAttributes(layoutAttributes: UICollectionViewLayoutAttributes) {
        super.applyLayoutAttributes(layoutAttributes)
        let attributes = layoutAttributes as! PinterestLayoutAttributes
        if viewPage == "Books"
        {
        imageViewHeightLayoutConstraint.constant = attributes.photoHeight
        }
        else
        {
            print("Setting the height constraints")
            classifiedImageViewHeightLayoutConstraint.constant = attributes.photoHeight
        }
    }
  
}
