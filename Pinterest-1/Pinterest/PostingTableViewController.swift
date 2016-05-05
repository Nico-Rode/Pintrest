//
//  PostingTableViewController.swift
//  Pinterest
//
//  Created by Nicholas Rode on 4/29/16.
//  Copyright © 2016 Razeware LLC. All rights reserved.
//

import UIKit

class PostingTableViewController: UITableViewController, UIPickerViewDataSource, UIPickerViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    // MARK: Properties
    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var itemTitle: UITextField!
    @IBOutlet weak var itemPrice: UITextField!
    @IBOutlet weak var itemDescription: UITextView!

    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var ChangeImgae: UITableViewCell!
//    @IBAction func imagePicker(sender: AnyObject) {
//        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera) {
//            print("I GOT YO CAMERA")
//            var imagePicker = UIImagePickerController()
//            imagePicker.delegate = self
//            imagePicker.sourceType = UIImagePickerControllerSourceType.Camera;
//            imagePicker.allowsEditing = false
//            self.presentViewController(imagePicker, animated: true, completion: nil)
//        }
//        else
//        {
//            print("NO FUCKING CAMERA")
//        }
//        
//    }
    
    let pickerData1 = ["Buying", "Selling"]
    let pickerData2 = ["Books", "Classifieds"]
    var itemData:Book = Book(title: "Title", description: "Description", price: "$", image: UIImage(named: "Default.jpg")!)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
//         self.navigationItem.rightBarButtonItem = self.editButtonItem()
        pickerView.dataSource = self
        pickerView.delegate = self
        itemImage.image = itemData.image
        itemTitle.text = itemData.title
        itemPrice.text = itemData.price
        itemDescription.text = itemData.description
        
        
        

    }
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Mark: - Picker Delegates and Data Source
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 2
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0
        {
            return pickerData1[row]
        }
        else
        {
            return pickerData2[row]
        }
    }
    
    
    // MARK: - Table view data source

    

    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)

        // Configure the cell...

        return cell
    }
    */

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
        if segue.identifier == "update"
        {
        let obj = PFObject(className: "Book")
        obj.setObject(itemData.price, forKey: "price");
        obj.setObject(itemData.title, forKey: "title");
        obj.setObject(itemData.description, forKey: "description");
        obj.saveInBackgroundWithBlock({ (success, error) in
            if (error != nil)
            {
                print(error?.localizedDescription);
            }
            else
            {
                print("UPLOADED TO PARSE")
            }
        });
//        let imageData = UIImagePNGRepresentation(itemData.image)
//        var image = info[UIImagePickerControllerOriginalImage] as! UIImage
        var imgData: NSData = NSData(data: UIImageJPEGRepresentation((itemData.image), 1)!)
        // var imgData: NSData = UIImagePNGRepresentation(image)
        // you can also replace UIImageJPEGRepresentation with UIImagePNGRepresentation.
        var imageSize: Int = imgData.length
        print("size of image in KB: %f ", imageSize / 1024)
        let parseImageData = PFFile(name: "uploaded_image.png", data: imgData)
        obj["image"] = parseImageData
        obj.saveInBackgroundWithBlock(
        {
            (success: Bool, error: NSError?) -> Void in
            
            if error == nil
            {
                //take user home
                print("data uploaded")
                
            }
                
            else
            {
                
                print(error)
            }
        })
        }
    }

}
