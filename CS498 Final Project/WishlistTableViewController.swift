//
//  WishlistTableViewController.swift
//  CS498 Final Project
//
//  Created by Rich Kanson on 12/12/16.
//  Copyright © 2016 Richard Kanson. All rights reserved.
//

import Firebase
import UIKit

struct bookStruct2 {
    let title: String!
}

class WishlistTableViewController: UITableViewController {
    
    var books = [bookStruct2]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let ref = FIRDatabase.database().reference()
        let user = FIRAuth.auth()?.currentUser?.uid
        ref.child("wishlist").child(user!).queryOrderedByKey().observe(.childAdded, with: { snapshot in
            let title = snapshot.value!["title"]
            self.books.insert(bookStruct2(title: title), atIndex: 0)
            self.tableView.reloadData()
        })
    }
    
    @IBAction func addToWishlist(sender: AnyObject) {
        var titleTextField: UITextField?
        let alertController = UIAlertController(title: "Add to Wishlist", message: "Please enter a book title.", preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
            let ref = FIRDatabase.database().reference()
            let user = FIRAuth.auth()?.currentUser!.uid
            let key = ref.child("books").childByAutoId().key
            ref.child("wishlist").child(user!).child(key).child("title").setValue(titleTextField?.text)
        })
        let cancel = UIAlertAction(title: "Cancel", style: .cancel) { (action) -> Void in
        }
        alertController.addAction(ok)
        alertController.addAction(cancel)
        alertController.addTextField { (textField) -> Void in
            titleTextField = textField
            titleTextField?.placeholder = "Book Title"
        }
        present(alertController, animated: true, completion: nil)
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.delete) {
            self.tableView.reloadData()
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return books.count;
    }
    
   func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "wishlistCell", for: indexPath as IndexPath)
        cell.textLabel?.text = books[indexPath.row].title
        return cell
    }
    
    func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "wishlistSegue" {
            let destination = segue.destination as? AmazonWishlistViewController
            let indexPath = tableView.indexPathForSelectedRow!
            let bTitle = books[indexPath.row].title
            destination?.bTitle = bTitle
        }
    }
    
}
