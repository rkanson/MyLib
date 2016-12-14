//
//  LoginViewController.swift
//  CS498 Final Project
//
//  Created by Rich Kanson on 12/14/16.
//  Copyright © 2016 Richard Kanson. All rights reserved.
//

import Firebase
import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet var emailField: UITextField!
    @IBOutlet var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func loginButtonPressed(sender: AnyObject) {
        FIRAuth.auth()?.signInWithEmail(emailField.text!, password: passwordField.text!, completion: { (user: FIRUser?, error) in
            
            if error != nil {
                let alertController = UIAlertController(title: "Error", message: "Incorrect email or password. Try again.",preferredStyle: .Alert)
                let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
                alertController.addAction(defaultAction)
                self.presentViewController(alertController, animated: true, completion: nil)
            }
            else {
                print("Success")
                self.performSegueWithIdentifier("loginSegue", sender: self)
            }
        })
    }
    
    @IBAction func createAccountButtonPressed(sender: AnyObject) {
        FIRAuth.auth()?.createUserWithEmail(emailField.text!, password: passwordField.text!, completion: { (user: FIRUser?, error) in
            if error != nil {
                let alert = UIAlertController()
                alert.title = "Error"
                alert.message = "Error creating user. Please try again."
                self.presentViewController(alert, animated: true, completion: nil)
                
            }
            else {
                print("Success")
                self.performSegueWithIdentifier("loginSegue",sender: self)
            }
        })
    }
    
}
