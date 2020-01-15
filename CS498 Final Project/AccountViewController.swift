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
        FIRAuth.auth()?.sendPasswordReset(withEmail: (FIRAuth.auth()?.currentUser?.email)!, completion: { (error) in })
        let alertController = UIAlertController(title: "Password Change", message: "An email to change your password has been sent.", preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
        })
        alertController.addAction(ok)
        present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func logoutPressed(sender: AnyObject) {
        try! FIRAuth.auth()?.signOut()
        if let storyboard = self.storyboard {
            let vc = storyboard.instantiateViewController(withIdentifier: "loginController") as! LoginViewController
            self.present(vc, animated: false, completion: nil)
        }
    }
    
}
