//
//  LogInViewController.swift
//  Pinterest
//
//  Created by Nicholas Rode on 5/10/16.
//  Copyright © 2016 Razeware LLC. All rights reserved.
//

import UIKit
import Firebase

class LogInViewController: UIViewController {
    
    var ref: Firebase!
    
    @IBAction func SignUp(sender: AnyObject) {
        var signup = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("SignUpViewController") as! SignUpViewController
        //set properties of login
        self.presentViewController(signup, animated: true, completion: nil)
    }

    @IBAction func LogIn(sender: AnyObject) {
        ref.authAnonymouslyWithCompletionBlock { (error, authData) in // 1
            if error != nil { print(error.description); return } // 2
            var signup = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("PhotoStreamViewController") as! PhotoStreamViewController
            //set properties of login
            self.presentViewController(signup, animated: true, completion: nil)
            
        }
            
            
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        UIGraphicsBeginImageContext(self.view.frame.size)
        UIImage(named: "Background.jpg")?.drawInRect(self.view.bounds)
        
        var image: UIImage = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        self.view.backgroundColor = UIColor(patternImage: image)
        
        ref = Firebase(url: "https://boiling-heat-9352.firebaseio.com/")
  

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
