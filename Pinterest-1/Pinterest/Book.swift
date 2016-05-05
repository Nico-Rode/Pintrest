//
//  Book.swift
//  Pinterest
//
//  Created by Nicholas Rode on 4/26/16.
//  Copyright © 2016 Razeware LLC. All rights reserved.
//

import UIKit

class Book
{
    
    class func allBooks() -> [Book]
    {
        print("called the allbooks func")
        var books = [Book]()
        var FindTimeLineData:PFQuery = PFQuery(className: "Book")
        FindTimeLineData.findObjectsInBackgroundWithBlock{ (results, error) in
            if (error != nil)
            {
                print("FUCKEME")
                print(error?.localizedDescription)
            }
            else
            {
                print("No errors in parse query")
                if let actualz = results
                {
                    print("We queried parse for book class using the book func")
                    for obj in actualz
                    {
                        print("WE HAVE ONE using the bookfunc")
                                                
                    }
                }
            }
        }
        return books
    }
    
    
    var title: String
    var description: String
    var price: String
    var image: UIImage
    
    init(title: String, description: String, price: String, image: UIImage)
    {
        self.title = title
        self.description = description
        self.price = price
        self.image = image
    }
    
//    convenience init(dictionary: NSDictionary)
//    {
//        let title = dictionary["title"] as? String
//        let description = dictionary["description"] as? String
//        let price = dictionary["price"] as? String
//        let image = UIImage(named: book!)?.decompressedImage
//        self.init(title: title!, description: description!, image: image!, price: price!)
//    }

    
    func heightForComment(font: UIFont, width: CGFloat) -> CGFloat
    {
        let rect = NSString(string: description).boundingRectWithSize(CGSize(width: width, height: CGFloat(MAXFLOAT)), options: .UsesLineFragmentOrigin, attributes: [NSFontAttributeName: font], context: nil)
        return ceil(rect.height)
    }

}
