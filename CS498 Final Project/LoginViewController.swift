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
    }
    
    @IBAction func loginButtonPressed(sender: AnyObject) {
        FIRAuth.auth()?.signIn(withEmail: emailField.text!, password: passwordField.text!, completion: { (user: FIRUser?, error) in
            
            if error != nil {
                let alertController = UIAlertController(title: "Error", message: "Incorrect email or password. Try again.",preferredStyle: .alert)
                let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                alertController.addAction(defaultAction)
                self.present(alertController, animated: true, completion: nil)
            }
            else {
                print("Success")
                self.performSegue(withIdentifier: "loginSegue", sender: self)
            }
        })
    }
    
    @IBAction func createAccountButtonPressed(sender: AnyObject) {
        FIRAuth.auth()?.createUser(withEmail: emailField.text!, password: passwordField.text!, completion: { (user: FIRUser?, error) in
            if error != nil {
                let alertController = UIAlertController(title: "Error", message: "Invalid entry. Try again.",preferredStyle: .alert)
                let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                alertController.addAction(defaultAction)
                self.present(alertController, animated: true, completion: nil)
                
            }
            else {
                print("Success")
                self.performSegue(withIdentifier: "loginSegue",sender: self)
            }
        })
    }
    
    
}
