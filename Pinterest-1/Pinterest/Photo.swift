//
//  Photo.swift
//  Pinterest
//
//  Created by Nicholas Rode on 4/2/16.
//  Copyright © 2016 Razeware LLC. All rights reserved.
//

import UIKit
import Parse


class Photo {
  

    class func allPhotos() -> [Photo] {
    var photos = [Photo]()
//    if let URL = NSBundle.mainBundle().URLForResource("Photos", withExtension: "plist") {
//      if let photosFromPlist = NSArray(contentsOfURL: URL) {
//        for dictionary in photosFromPlist {
//          let photo = Photo(dictionary: dictionary as! NSDictionary)
//          photos.append(photo)
//        }
//        }
//    }
    print("all photos function had been called")
    var FindTimeLineData:PFQuery = PFQuery(className: "Book")
    FindTimeLineData.findObjectsInBackgroundWithBlock{ (results, error) in
        if (error != nil)
        {
            print("FUCKEME")
            print(error?.localizedDescription)
        }
        else
        {
            if let actualz = results
            {
                print("We queried parse for book class using photofunc")
                for obj in actualz
                    {
                        print("WE HAVE ONE from using the photofunc")
//                        let Post:PFObject = obj as PFObject
//                        let itemPicture = obj["image"] as PFFile
//                            {
//                            itemPicture.getDataInBackgroundWithBlock({ (imageData: NSData!, error: NSError!) -> Void in
//                                if (error == nil)
//                                {
//                                    let image = UIImage(data:imageData)
//                                }
//                            })
//                            }
                    }
            }
        }
        }

    

    let item = Photo(caption: "Test", comment: "I dont know what I'm doing", image: UIImage(named: "Bike.jpg")!, price: "$15")
    photos.append(item)
    return photos
    }
    

    
    
    
  
  var caption: String
  var comment: String
  var price: String
  var image: UIImage
  
    init(caption: String, comment: String, image: UIImage, price: String) {
    self.caption = caption
    self.comment = comment
    self.image = image
    self.price = price
  }
  
  convenience init(dictionary: NSDictionary) {
    let caption = dictionary["Caption"] as? String
    let comment = dictionary["Comment"] as? String
    let photo = dictionary["Photo"] as? String
    let price = dictionary["Price"] as? String
    let image = UIImage(named: photo!)?.decompressedImage
    self.init(caption: caption!, comment: comment!, image: image!, price: price!)
  }

  func heightForComment(font: UIFont, width: CGFloat) -> CGFloat {
    let rect = NSString(string: comment).boundingRectWithSize(CGSize(width: width, height: CGFloat(MAXFLOAT)), options: .UsesLineFragmentOrigin, attributes: [NSFontAttributeName: font], context: nil)
    return ceil(rect.height)
  }
    

}
