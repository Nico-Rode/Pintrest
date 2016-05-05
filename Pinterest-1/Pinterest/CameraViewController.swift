//
//  CameraViewController.swift
//  Pinterest
//
//  Created by Nicholas Rode on 5/4/16.
//  Copyright © 2016 Razeware LLC. All rights reserved.
//

import UIKit

class CameraViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var imageView: UIImageView!
    var chosenImage:UIImage = UIImage(named: "Default.jpg")!

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBarHidden = false

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func chooseExistingPhoto()
    {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .PhotoLibrary
        
        presentViewController(picker, animated: true, completion: nil)
        
    }
    @IBAction func useCamera()
    {
        let picker = UIImagePickerController()
        if picker.sourceType == .Camera
        {
            picker.delegate = self
            picker.sourceType = .Camera
            presentViewController(picker, animated: true, completion: nil)
        }
        else
        {
            print("NO FUKCING CAMERA")
        }
        
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        imageView.image = chosenImage
        dismissViewControllerAnimated(true, completion: nil)
    }
    

    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        (segue.destinationViewController as! PostingTableViewController).itemData.image = chosenImage
        
    }


}
