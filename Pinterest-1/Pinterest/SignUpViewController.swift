//
//  LoginViewController.swift
//  Pinterest
//
//  Created by Nicholas Rode on 5/10/16.
//  Copyright © 2016 Razeware LLC. All rights reserved.
//

import UIKit
import Parse

class SignUpViewController: UIViewController {

    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var repeatPassword: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var messageLabel: UILabel!
    
    
    
    @IBAction func loginVerify(sender: AnyObject) {
        var usernameEntered = username.text
        var passwordEntered = password.text
        var repeatedPasswordEntered = repeatPassword.text
        var emailEntered = email.text
        
        if usernameEntered != "" && passwordEntered != "" && emailEntered != "" {
            if passwordEntered == repeatedPasswordEntered
            {
                userSignUp(usernameEntered!, passwordEntered: passwordEntered!, emailEntered: emailEntered!)
            }
            else
            {
                self.messageLabel.text = "Passwords don't match"
            }
            
        } else {
            self.messageLabel.text = "All Fields Required"
        }
        
    }
    
    func userSignUp(usernameEntered: String, passwordEntered: String, emailEntered: String) {
        
        var user = PFUser()
        user.username = usernameEntered
        user.password = passwordEntered
        user.email = emailEntered
        
        user.signUpInBackgroundWithBlock({ (succuess, error) in
            if (error != nil)
            {
                print(error?.localizedDescription)
                self.messageLabel.text = error!.localizedDescription
            }
            else
            {
                self.messageLabel.text = "Signed up!"
            }
        })

    }
    override func viewDidLoad() {
        super.viewDidLoad()

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
