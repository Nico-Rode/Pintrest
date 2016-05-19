//
//  LogInInformationViewController.swift
//  Pinterest
//
//  Created by Nicholas Rode on 5/10/16.
//  Copyright © 2016 Razeware LLC. All rights reserved.
//

import UIKit
import Parse

class LogInInformationViewController: UIViewController {

    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    
    @IBOutlet weak var loginLabel: UILabel!
    @IBOutlet weak var saveLabel: UILabel!
    @IBOutlet weak var savePassSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func LogIn(sender: AnyObject) {
        if username.text != "" && password.text != "" {
            if savePassSwitch.on {
                PFUser.logInWithUsernameInBackground(username.text!, password: password.text!) {
                    (user, error) -> Void in
                    if user != nil {
                        // Yes, User Exists
                        self.loginLabel.text = "User Exists"
                    }
                    else {
                        self.loginLabel.text = "User doesn't exist"
                    }
                }            }
            else {
                // If the user has selected NO to saving password
            }
        } else {
            // Empty, Notify user
            self.loginLabel.text = "All Fields Required"
        }
        
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
