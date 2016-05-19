//
//  YourPostsTableViewController.swift
//  Pinterest
//
//  Created by Nicholas Rode on 5/3/16.
//  Copyright © 2016 Razeware LLC. All rights reserved.
//

import UIKit
import Parse

class YourPostsTableViewController: UITableViewController {
    var userPosts:NSMutableArray = NSMutableArray()
    var imageCounter = 0
    var titleData:String = ""
    var priceData:String = ""
    var descriptionData:String = ""
    var imageData:UIImage = UIImage(named: "Default.jpg")!
    
    func loadData(page: String)
    {
        print("DID THIS LOAD?")
        var findTimelineData:PFQuery = PFQuery(className: page)
        findTimelineData.findObjectsInBackgroundWithBlock{ (results, error) in
            if error == nil
            {
                for object in results!
                {
                    if let parsePublisherData = object["publisher"] as? PFUser
                    {
                        if let user = PFUser.currentUser()
                        {
                            print("User found")
                            if user.objectId == parsePublisherData.objectId
                            {
                                print("Same user ID")
                                print(parsePublisherData.objectId)
                                print(user.objectId)
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
                                self.userPosts.addObject(Item)
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
                                            print("Once image has been set there are ", self.userPosts.count, " images in the array")
                                            self.imageCounter += 1

                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            let Array:NSArray = self.userPosts.reverseObjectEnumerator().allObjects
            self.userPosts = NSMutableArray(array: Array)
            self.tableView?.reloadData()
        }
        print("RELOADING DATA")
        self.tableView?.reloadData()

        
        }
    }
    override func viewDidAppear(animated: Bool) {
        self.navigationController?.navigationBar.hidden = true
        self.tableView?.reloadData()
    }
    
    func configureTableView()
    {
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 160
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let user = PFUser.currentUser()
        {
            self.loadData("Book")
            self.loadData("Classified")
        }

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        print("The number of rows in section is ", userPosts.count)
        return userPosts.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("UserPostsCell", forIndexPath: indexPath) as! UserPostsTableViewCell
        
        cell.photo = userPosts[indexPath.item] as? Book
        print(userPosts.count, " number of items in the array")
        print("CELL FOR ROW FOR INDEX PATH")

        

        return cell
    }


    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        print("SEGUE CALLED?")
        if let cell = sender as? UITableViewCell, indexPath = tableView!.indexPathForCell(cell) {
            print(indexPath.item)
            let book:Book = userPosts[indexPath.item] as! Book
            (segue.destinationViewController as! DetailedItemTableViewController).itemData = book
        }
       
    }


}
