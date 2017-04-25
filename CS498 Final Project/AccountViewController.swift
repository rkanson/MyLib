//
//  AccountViewController.swift
//  CS498 Final Project
//
//  Created by Rich Kanson on 12/14/16.
//  Copyright © 2016 Richard Kanson. All rights reserved.
//

import Firebase
import UIKit

class AccountViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func changePassword(sender: AnyObject) {
        FIRAuth.auth()?.sendPasswordResetWithEmail((FIRAuth.auth()?.currentUser?.email)!, completion: { (error) in })
        let alertController = UIAlertController(title: "Password Change", message: "An email to change your password has been sent.", preferredStyle: .Alert)
        let ok = UIAlertAction(title: "OK", style: .Default, handler: { (action) -> Void in
        })
        alertController.addAction(ok)
        presentViewController(alertController, animated: true, completion: nil)
    }
    
    @IBAction func logoutPressed(sender: AnyObject) {
        try! FIRAuth.auth()?.signOut()
        if let storyboard = self.storyboard {
            let vc = storyboard.instantiateViewControllerWithIdentifier("loginController") as! LoginViewController
            self.presentViewController(vc, animated: false, completion: nil)
        }
    }
    
}
