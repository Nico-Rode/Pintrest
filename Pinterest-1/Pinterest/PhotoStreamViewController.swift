//
//  PhotoStreamViewController.swift
//  Pinterest
//
//  Created by Nicholas Rode on 4/2/16.
//  Copyright © 2016 Razeware LLC. All rights reserved.
//

import UIKit
import AVFoundation
import Parse

class PhotoStreamViewController: UICollectionViewController {
    var Timeline:NSMutableArray = NSMutableArray()
    var titleData: String = ""
    var priceData: String = ""
    var descriptionData: String = ""
    var imageData: UIImage = UIImage(named: "Default.jpg")!
    var newPosting:Book?
    var imageCounter = 0
    
    
    func loadData()
    {
        print("HELLO? LOAD DATA HERE")
        Timeline.removeAllObjects()
        var findTimelineData:PFQuery = PFQuery(className: "Book")
        findTimelineData.findObjectsInBackgroundWithBlock{ (results, error) in
            print("LOAD DATA WAS CALLED")
            if error == nil
            {
                for object in results!
                {
                    if let parseTitleData = object["title"] as? String
                    {
                        self.titleData = parseTitleData
                    }
                    if let parsePriceData = object["price"] as? String
                    {
                        self.priceData = parsePriceData
                    }
                    if let parseDescriptionData = object["description"] as? String
                    {
                        print("We have a description from the DataBase which is: ", parseDescriptionData)
                        self.descriptionData = parseDescriptionData
                    }
                    let Item:Book = Book(title: self.titleData, description: self.descriptionData, price: self.priceData, image: self.imageData)
                    self.Timeline.addObject(Item)
                    if let parseImageData = object["image"] as? PFFile
                    {
                        print("Image is a pffile")
                        parseImageData.getDataInBackgroundWithBlock{
                            (ImageData: NSData?, error: NSError?)->Void in
                            if error == nil
                            {
                                print("no errors when grabbing image")
                                let parseImage = UIImage(data: ImageData!)!
                                self.imageData = parseImage
                                print("set the image data")
                                print("THE IMAGE DATA IS AS FOLLOWS: ")
                                print("TITLE: ", self.titleData)
                                Item.setImage(self.imageData)
                                print("Once image has been set there are ", self.Timeline.count, " images in the array")
                                self.imageCounter += 1
                                
                                if self.imageCounter == results!.count - 1
                                {
                                    let Array:NSArray = self.Timeline.reverseObjectEnumerator().allObjects
                                    self.Timeline = NSMutableArray(array: Array)
                                    self.collectionView?.reloadData()
                                }
                            }
                        }
                    }

                }
                print("The number of objects in array is ")
                print(self.Timeline.count)
//                let Array:NSArray = self.Timeline.reverseObjectEnumerator().allObjects
//                self.Timeline = NSMutableArray(array: Array)
            }
        }
    }
    
    
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let cell = sender as? UICollectionViewCell, indexPath = collectionView!.indexPathForCell(cell) {
            print(indexPath.item)
            let book:Book = Timeline[indexPath.item] as! Book
            (segue.destinationViewController as! DetailedItemTableViewController).itemData = book
        }
    }
    
    
    
    

  override func preferredStatusBarStyle() -> UIStatusBarStyle {
    return UIStatusBarStyle.LightContent
    
    
    
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    print("PLEASE TELL ME THIS WAS CALLED")
    
    if let patternImage = UIImage(named: "Pattern") {
      view.backgroundColor = UIColor(patternImage: patternImage)
    }
    
    collectionView!.backgroundColor = UIColor.clearColor()
    collectionView!.contentInset = UIEdgeInsets(top: 23, left: 5, bottom: 10, right: 5)
    
    let layout = collectionViewLayout as! PinterestLayout
    layout.cellPadding = 5
    layout.delegate = self
    layout.numberOfColumns = 2
    self.loadData()
    }
    
    override func viewWillAppear(animated: Bool)
    {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBarHidden = true
//        if PFUser.currentUser() == nil {
//            var login = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("LogInViewController") as! LogInViewController
//            //set properties of login
//            self.presentViewController(login, animated: true, completion: nil)
//        }
    }
  
}



extension PhotoStreamViewController {
  
  override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    print("Number of items in section is ", Timeline.count)
    return Timeline.count
  }
  
  override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCellWithReuseIdentifier("AnnotatedPhotoCell", forIndexPath: indexPath) as! AnnotatedPhotoCell
    cell.viewPage = "Books"
    cell.photo = Timeline[indexPath.item] as? Book
    return cell
  }
  
}

extension PhotoStreamViewController: PinterestLayoutDelegate {
  
    func collectionView(collectionView: UICollectionView, heightForPhotoAtIndexPath indexPath: NSIndexPath, withWidth width: CGFloat) -> CGFloat {
        let photo = Timeline[indexPath.item] as! Book
        let boundingRect = CGRect(x: 0, y: 0, width: width, height: CGFloat(MAXFLOAT))
        let rect = AVMakeRectWithAspectRatioInsideRect(photo.image.size, boundingRect)
        return rect.height
    
  }
    
    func collectionView(collectionView: UICollectionView, heightForAnnotationAtIndexPath indexPath: NSIndexPath, withWidth width: CGFloat) -> CGFloat {
        return 60
    }
}
